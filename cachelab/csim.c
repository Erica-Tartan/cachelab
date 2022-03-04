#include "cachelab.h"
#include <ctype.h>
#include <getopt.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned long hits;            /* number of hits */
unsigned long misses;          /* number of misses */
unsigned long evictions;       /* number of evictions */
int dirty_bytes;               /* number of dirty bytes in cache
                                              at end of simulation */
unsigned long dirty_evictions; /* number of bytes evicted from dirty lines */

typedef struct {
    unsigned int valid;
    unsigned int dirtyb;
    unsigned long tag;
    unsigned long block;
    int time;
} cache_elem;

void cache_free(cache_elem **cache, int s) {
    unsigned int num_sets = (unsigned int)pow(2, s);
    unsigned int i;
    for (i = 0; i < num_sets; i++) {
        free(cache[i]);
    }
    free(cache);
}

cache_elem **create_cache(int s, int E) {
    unsigned int num_sets = (unsigned int)pow(2, s);
    cache_elem **cache = malloc(
        num_sets *
        sizeof(cache_elem *)); // each set contains an array of cache_elem
    if (cache == NULL) {
        exit(1);
    }
    unsigned int i;
    for (i = 0; i < num_sets; i++) {
        cache[i] = malloc((unsigned int)E * sizeof(cache_elem));
        if (cache[i] == NULL) {
            exit(1);
        }
        int j;
        for (j = 0; j < E; j++) {
            cache[i][j].valid = 0;
            cache[i][j].dirtyb = 0;
            cache[i][j].tag = 0;
            cache[i][j].block = 0;
            cache[i][j].time = 0;
        }
    }
    return cache;
}

cache_elem **cache_load(cache_elem **cache, unsigned long addr, int size, int s,
                        int E, int b) {
    unsigned long block_offset = addr & (unsigned int)(pow(2, b) - 1);
    printf("block_offset %lx\n", block_offset);
    unsigned long set = (addr >> b) & (unsigned int)(pow(2, s) - 1);
    printf("set %lx\n", set);
    unsigned long tag =
        (addr >> (s + b)) & ((unsigned long)(pow(2, 64 - (s + b))) - 1);
    printf("tag %lx\n", tag);
    int hitflag = 0;
    int spaceflag = 0;
    int spaceindex = E;
    int i;
    for (i = 0; i < E; i++) {
        if (cache[set][i].tag == tag && cache[set][i].valid == 1) {
            hits += 1;
            hitflag = 1;
            cache[set][i].block = block_offset;
            cache[set][i].time = 0;
            break;
        }
    }
    for (i = 0; i < E; i++) {
        if (cache[set][i].valid == 0) {
            spaceflag = 1;
            if (i < spaceindex) {
                // store the minimum index i such that cache[set][i].valid == 0
                spaceindex = i;
            }
        }
        cache[set][i].time += 1;
    }
    if (hitflag == 0) {
        misses += 1;
        // no eviction
        if (spaceflag == 1) {
            cache[set][spaceindex].valid = 1;
            cache[set][spaceindex].dirtyb = 0;
            cache[set][spaceindex].tag = tag;
            cache[set][spaceindex].block = block_offset;
            cache[set][spaceindex].time = 1;
        } else {
            evictions += 1;
            int maxtime = 0;
            int maxindex = 0;
            int i;
            for (i = 0; i < E; i++) {
                if (cache[set][i].time > maxtime) {
                    maxtime = cache[set][i].time;
                    maxindex = i;
                }
            }
            if (cache[set][maxindex].dirtyb == 1) {
                dirty_evictions += pow(2, b);
            }
            cache[set][maxindex].valid = 1;
            cache[set][maxindex].dirtyb = 0;
            cache[set][maxindex].tag = tag;
            cache[set][maxindex].block = block_offset;
            cache[set][maxindex].time = 1;
        }
    }
    return cache;
}

cache_elem **cache_store(cache_elem **cache, unsigned long addr, int size,
                         int s, int E, int b) {
    unsigned long block_offset = addr & (unsigned int)(pow(2, b) - 1);
    printf("block_offset %lx\n", block_offset);
    unsigned long set = (addr >> b) & (unsigned int)(pow(2, s) - 1);
    printf("set %lx\n", set);
    unsigned long tag =
        (addr >> (s + b)) & ((unsigned long)(pow(2, 64 - (s + b))) - 1);
    printf("tag %lx\n", tag);
    int hitflag = 0;
    int spaceflag = 0;
    int spaceindex = E;
    int i;
    for (i = 0; i < E; i++) {
        if (cache[set][i].tag == tag && cache[set][i].valid == 1) {
            hits += 1;
            hitflag = 1;
            cache[set][i].block = block_offset;
            cache[set][i].dirtyb = 1;
            cache[set][i].time = 0;
            break;
        }
    }
    for (i = 0; i < E; i++) {
        if (cache[set][i].valid == 0) {
            spaceflag = 1;
            if (i < spaceindex) {
                // store the minimum index i such that cache[set][i].valid == 0
                spaceindex = i;
            }
        }
        cache[set][i].time += 1;
    }
    if (hitflag == 0) {
        misses += 1;
        // no eviction
        if (spaceflag == 1) {
            cache[set][spaceindex].valid = 1;
            cache[set][spaceindex].dirtyb = 1;
            cache[set][spaceindex].tag = tag;
            cache[set][spaceindex].block = block_offset;
            cache[set][spaceindex].time = 1;
        } else {
            evictions += 1;
            int maxtime = 0;
            int maxindex = 0;
            int i;
            for (i = 0; i < E; i++) {
                if (cache[set][i].time > maxtime) {
                    maxtime = cache[set][i].time;
                    maxindex = i;
                }
            }
            if (cache[set][maxindex].dirtyb == 1) {
                dirty_evictions += pow(2, b);
            }
            cache[set][maxindex].valid = 1;
            cache[set][maxindex].dirtyb = 1;
            cache[set][maxindex].tag = tag;
            cache[set][maxindex].block = block_offset;
            cache[set][maxindex].time = 1;
        }
    }
    return cache;
}

int check_line_correct(char *s) {
    if (s == NULL) {
        return 0;
    }
    if (strlen(s) < 5) {
        printf("196\n");
        return 0;
    }
    if ((s[0] != 'L' && s[0] != 'S') || s[1] != ' ') {
        printf("%c, %c, 200\n", s[0], s[1]);
        return 0;
    }
    int i, j;
    int comma = 0;
    for (j = 2; j < (int)strlen(s); j++) {
        if (s[j] == ',') {
            comma = j;
        }
    }
    if (comma <= 2 || (unsigned long)comma >= strlen(s) - 1) {
        printf("211\n");
        return 0;
    }
    for (i = 2; i < comma; i++) {
        if (!isdigit(s[i]) && s[i] != 'a' && s[i] != 'b' && s[i] != 'c' &&
            s[i] != 'd' && s[i] != 'e' && s[i] != 'f') {
            printf("217\n");
            return 0;
        }
    }
    if (!isdigit(s[comma + 1])) {
        printf("%c", s[i]);
        printf("223\n");
        return 0;
    }
    return 1;
}

int main(int argc, char *argv[]) {
    extern char *optarg;
    extern int optind, opterr, optopt;

    int verbose = 0;
    int helpFlag = 0;
    int errorFlag = 0;

    int arg;
    int s = -1;
    int b = -1;
    int E = -1;
    char *trace;
    int t = -1;

    while ((arg = getopt(argc, argv, "hvs:b:E:t:")) != -1) {
        switch (arg) {
        case 'h': // print this help message and exit
            helpFlag = 1;
            break;
        case 'v': // verbose mode: report effects of each memory operation
            verbose = 1;
            break;
        case 's': // Number of set index bits (there are 2**s sets)
            s = atoi(optarg);
            printf("s (Number of set index bits) is %d\n", s);
            break;
        case 'b': // Number of block bits (there are 2**b blocks)
            b = atoi(optarg);
            printf("b (Number of block bits) is %d\n", b);
            break;
        case 'E': // Number of lines per set (associativity)
            E = atoi(optarg);
            printf("E (Number of lines per set) is %d\n", E);
            break;
        case 't': // File name of the memory trace to process
            trace = optarg;
            t = 1;
            break;
        default:
            errorFlag = 1;
            break;
        }
    }
    if (errorFlag) {
        fprintf(stderr, "default");
        exit(errorFlag);
    }
    if (helpFlag) {
        printf("print this help message and exit\n");
        exit(helpFlag);
    }
    if (verbose) {
        printf("verbose mode: report effects of each memory operation\n");
    }
    if (s < 0 || b < 0 || E < 0 || t < 0 || s + b > 64) {
        errorFlag = 1;
    } else {
        cache_elem **cache = create_cache(s, E);

        // Process a memory-access trace file.
        // @param trace Name of the trace file to process.
        // @return 0 if successful, 1 if there were errors.
        char Op;
        unsigned long addr;
        int size;

        FILE *tfp = fopen(trace, "rt");
        if (!tfp) {
            fprintf(stderr, "Error opening '%s': %s\n", trace, strerror(1));
            return 1;
        }
        unsigned int LINELEN = 22; // 1+1+16+1+2+1
        char *linebuf = malloc((LINELEN + 1) * sizeof(char));
        int parse_error = 0;
        while (fgets(linebuf, (int)LINELEN, tfp)) {
            if (check_line_correct(linebuf)) {
                if (strlen(linebuf) <= LINELEN - 1) {
                    printf("linebuf is %s\n", linebuf);
                    char *part = strtok(linebuf, " ,");
                    Op = part[0];
                    part = strtok(NULL, " ,");
                    // reference pointer
                    char *end;
                    addr = strtoul(part, &end, 16);
                    part = strtok(NULL, " ,");
                    size = atoi(part);
                    printf("addr is %lx\n", addr);
                    switch (Op) {
                    case 'L':
                        cache = cache_load(cache, addr, size, s, E, b);
                        break;
                    case 'S':
                        cache = cache_store(cache, addr, size, s, E, b);
                        break;
                    default:
                        errorFlag = 1;
                        break;
                    }
                }
            } else {
                parse_error = 1;
            }
        }
        fclose(tfp);
        if (parse_error) {
            return 1;
        } else {
            csim_stats_t result;
            result.hits = hits;
            result.misses = misses;
            result.evictions = evictions;
            int dirtyn = 0;
            int i, j;
            for (i = 0; i < (int)pow(2, s); i++) {
                for (j = 0; j < E; j++) {
                    if (cache[i][j].dirtyb == 1)
                        dirtyn++;
                }
            }
            dirty_bytes = (int)pow(2, b) * dirtyn;
            result.dirty_bytes = (unsigned long)dirty_bytes;
            result.dirty_evictions = dirty_evictions;
            printSummary(&result);
            free(linebuf);
            cache_free(cache, s);
            return 0;
        }
    }
    if (errorFlag) {
        fprintf(stderr, "The value for s, b, E, or t is incorrect");
        exit(errorFlag);
    }
    return 0;
}
