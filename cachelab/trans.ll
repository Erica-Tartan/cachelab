; ModuleID = 'trans.c'
source_filename = "trans.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"Transpose submission\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"Basic transpose\00", align 1
@.str.2 = private unnamed_addr constant [36 x i8] c"Transpose using the temporary array\00", align 1

; Function Attrs: nounwind uwtable
define dso_local void @registerFunctions() local_unnamed_addr #0 !dbg !7 {
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @transpose_submit, i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str, i64 0, i64 0)) #3, !dbg !10
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_basic, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i64 0, i64 0)) #3, !dbg !11
  tail call void @registerTransFunction(void (i64, i64, double*, double*, double*)* nonnull @trans_tmp, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.2, i64 0, i64 0)) #3, !dbg !12
  ret void, !dbg !13
}

declare dso_local void @registerTransFunction(void (i64, i64, double*, double*, double*)*, i8*) local_unnamed_addr #1

; Function Attrs: nounwind uwtable
define internal void @transpose_submit(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !27, metadata !DIExpression()), !dbg !39
  call void @llvm.dbg.value(metadata i64 %1, metadata !28, metadata !DIExpression()), !dbg !40
  call void @llvm.dbg.value(metadata double* %2, metadata !29, metadata !DIExpression()), !dbg !41
  call void @llvm.dbg.value(metadata double* %3, metadata !30, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.value(metadata double* %4, metadata !31, metadata !DIExpression()), !dbg !43
  call void @llvm.dbg.value(metadata i64 8, metadata !32, metadata !DIExpression()), !dbg !44
  %6 = or i64 %1, %0, !dbg !45
  %7 = and i64 %6, 7, !dbg !45
  %8 = icmp eq i64 %7, 0, !dbg !45
  br i1 %8, label %9, label %75, !dbg !45

; <label>:9:                                      ; preds = %5
  call void @llvm.dbg.value(metadata i64 0, metadata !37, metadata !DIExpression()), !dbg !46
  %10 = icmp eq i64 %0, 0, !dbg !47
  br i1 %10, label %97, label %11, !dbg !50

; <label>:11:                                     ; preds = %9
  %12 = icmp eq i64 %1, 0
  br label %13, !dbg !50

; <label>:13:                                     ; preds = %11, %73
  %14 = phi i64 [ 0, %11 ], [ %15, %73 ]
  call void @llvm.dbg.value(metadata i64 %14, metadata !37, metadata !DIExpression()), !dbg !46
  call void @llvm.dbg.value(metadata i64 0, metadata !38, metadata !DIExpression()), !dbg !51
  %15 = add i64 %14, 8
  br i1 %12, label %73, label %16, !dbg !52

; <label>:16:                                     ; preds = %13
  %17 = icmp eq i64 %14, -8
  br i1 %17, label %69, label %18, !dbg !52

; <label>:18:                                     ; preds = %16, %23
  %19 = phi i64 [ %20, %23 ], [ 0, %16 ]
  call void @llvm.dbg.value(metadata i64 %19, metadata !38, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.value(metadata i64 %14, metadata !33, metadata !DIExpression()), !dbg !54
  %20 = add i64 %19, 8
  %21 = icmp eq i64 %19, -8
  %22 = icmp eq i64 %14, %19
  br i1 %21, label %55, label %25, !dbg !55

; <label>:23:                                     ; preds = %38, %56, %55
  call void @llvm.dbg.value(metadata i64 %20, metadata !38, metadata !DIExpression()), !dbg !51
  %24 = icmp ult i64 %20, %1, !dbg !59
  br i1 %24, label %18, label %73, !dbg !52, !llvm.loop !60

; <label>:25:                                     ; preds = %18, %38
  %26 = phi i64 [ %39, %38 ], [ %14, %18 ]
  call void @llvm.dbg.value(metadata i64 %26, metadata !33, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i64 %19, metadata !36, metadata !DIExpression()), !dbg !62
  %27 = mul nsw i64 %26, %0
  %28 = getelementptr inbounds double, double* %2, i64 %27
  %29 = getelementptr inbounds double, double* %3, i64 %26
  br label %42, !dbg !63

; <label>:30:                                     ; preds = %41
  %31 = getelementptr inbounds double, double* %28, i64 %26, !dbg !67
  %32 = bitcast double* %31 to i64*, !dbg !67
  %33 = load i64, i64* %32, align 8, !dbg !67, !tbaa !70
  %34 = mul nsw i64 %26, %1, !dbg !74
  %35 = getelementptr inbounds double, double* %3, i64 %34, !dbg !74
  %36 = getelementptr inbounds double, double* %35, i64 %26, !dbg !74
  %37 = bitcast double* %36 to i64*, !dbg !75
  store i64 %33, i64* %37, align 8, !dbg !75, !tbaa !70
  br label %38, !dbg !76

; <label>:38:                                     ; preds = %30, %41
  %39 = add nuw i64 %26, 1, !dbg !77
  call void @llvm.dbg.value(metadata i64 %39, metadata !33, metadata !DIExpression()), !dbg !54
  %40 = icmp ult i64 %39, %15, !dbg !78
  br i1 %40, label %25, label %23, !dbg !55, !llvm.loop !79

; <label>:41:                                     ; preds = %52
  br i1 %22, label %30, label %38, !dbg !81

; <label>:42:                                     ; preds = %52, %25
  %43 = phi i64 [ %19, %25 ], [ %53, %52 ]
  call void @llvm.dbg.value(metadata i64 %43, metadata !36, metadata !DIExpression()), !dbg !62
  %44 = icmp eq i64 %26, %43, !dbg !82
  br i1 %44, label %52, label %45, !dbg !86

; <label>:45:                                     ; preds = %42
  %46 = getelementptr inbounds double, double* %28, i64 %43, !dbg !87
  %47 = bitcast double* %46 to i64*, !dbg !87
  %48 = load i64, i64* %47, align 8, !dbg !87, !tbaa !70
  %49 = mul nsw i64 %43, %1, !dbg !89
  %50 = getelementptr inbounds double, double* %29, i64 %49, !dbg !89
  %51 = bitcast double* %50 to i64*, !dbg !90
  store i64 %48, i64* %51, align 8, !dbg !90, !tbaa !70
  br label %52, !dbg !91

; <label>:52:                                     ; preds = %45, %42
  %53 = add nuw i64 %43, 1, !dbg !92
  call void @llvm.dbg.value(metadata i64 %53, metadata !36, metadata !DIExpression()), !dbg !62
  %54 = icmp ult i64 %53, %20, !dbg !93
  br i1 %54, label %42, label %41, !dbg !63, !llvm.loop !94

; <label>:55:                                     ; preds = %18
  br i1 %22, label %56, label %23, !dbg !55

; <label>:56:                                     ; preds = %55, %56
  %57 = phi i64 [ %67, %56 ], [ %14, %55 ]
  call void @llvm.dbg.value(metadata i64 %57, metadata !33, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.value(metadata i64 %19, metadata !36, metadata !DIExpression()), !dbg !62
  %58 = mul nsw i64 %57, %0, !dbg !67
  %59 = getelementptr inbounds double, double* %2, i64 %58, !dbg !67
  %60 = getelementptr inbounds double, double* %59, i64 %57, !dbg !67
  %61 = bitcast double* %60 to i64*, !dbg !67
  %62 = load i64, i64* %61, align 8, !dbg !67, !tbaa !70
  %63 = mul nsw i64 %57, %1, !dbg !74
  %64 = getelementptr inbounds double, double* %3, i64 %63, !dbg !74
  %65 = getelementptr inbounds double, double* %64, i64 %57, !dbg !74
  %66 = bitcast double* %65 to i64*, !dbg !75
  store i64 %62, i64* %66, align 8, !dbg !75, !tbaa !70
  %67 = add nuw i64 %57, 1, !dbg !77
  call void @llvm.dbg.value(metadata i64 %67, metadata !33, metadata !DIExpression()), !dbg !54
  %68 = icmp ult i64 %67, %15, !dbg !78
  br i1 %68, label %56, label %23, !dbg !55, !llvm.loop !79

; <label>:69:                                     ; preds = %16, %69
  %70 = phi i64 [ %71, %69 ], [ 0, %16 ]
  call void @llvm.dbg.value(metadata i64 %70, metadata !38, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.value(metadata i64 %14, metadata !33, metadata !DIExpression()), !dbg !54
  %71 = add i64 %70, 8, !dbg !96
  call void @llvm.dbg.value(metadata i64 %71, metadata !38, metadata !DIExpression()), !dbg !51
  %72 = icmp ult i64 %71, %1, !dbg !59
  br i1 %72, label %69, label %73, !dbg !52, !llvm.loop !60

; <label>:73:                                     ; preds = %23, %69, %13
  call void @llvm.dbg.value(metadata i64 %15, metadata !37, metadata !DIExpression()), !dbg !46
  %74 = icmp ult i64 %15, %0, !dbg !47
  br i1 %74, label %13, label %97, !dbg !50, !llvm.loop !97

; <label>:75:                                     ; preds = %5
  call void @llvm.dbg.value(metadata i64 %0, metadata !99, metadata !DIExpression()), !dbg !112
  call void @llvm.dbg.value(metadata i64 %1, metadata !102, metadata !DIExpression()), !dbg !115
  call void @llvm.dbg.value(metadata double* %2, metadata !103, metadata !DIExpression()), !dbg !116
  call void @llvm.dbg.value(metadata double* %3, metadata !104, metadata !DIExpression()), !dbg !117
  call void @llvm.dbg.value(metadata double* %4, metadata !105, metadata !DIExpression()), !dbg !118
  call void @llvm.dbg.value(metadata i64 0, metadata !106, metadata !DIExpression()), !dbg !119
  %76 = icmp eq i64 %1, 0, !dbg !120
  %77 = icmp eq i64 %0, 0
  %78 = or i1 %77, %76, !dbg !121
  br i1 %78, label %97, label %79, !dbg !121

; <label>:79:                                     ; preds = %75, %94
  %80 = phi i64 [ %95, %94 ], [ 0, %75 ]
  call void @llvm.dbg.value(metadata i64 %80, metadata !106, metadata !DIExpression()), !dbg !119
  call void @llvm.dbg.value(metadata i64 0, metadata !108, metadata !DIExpression()), !dbg !122
  %81 = mul nsw i64 %80, %0
  %82 = getelementptr inbounds double, double* %2, i64 %81
  %83 = getelementptr inbounds double, double* %3, i64 %80
  br label %84, !dbg !123

; <label>:84:                                     ; preds = %84, %79
  %85 = phi i64 [ 0, %79 ], [ %92, %84 ]
  call void @llvm.dbg.value(metadata i64 %85, metadata !108, metadata !DIExpression()), !dbg !122
  %86 = getelementptr inbounds double, double* %82, i64 %85, !dbg !124
  %87 = bitcast double* %86 to i64*, !dbg !124
  %88 = load i64, i64* %87, align 8, !dbg !124, !tbaa !70
  %89 = mul nsw i64 %85, %1, !dbg !127
  %90 = getelementptr inbounds double, double* %83, i64 %89, !dbg !127
  %91 = bitcast double* %90 to i64*, !dbg !128
  store i64 %88, i64* %91, align 8, !dbg !128, !tbaa !70
  %92 = add nuw i64 %85, 1, !dbg !129
  call void @llvm.dbg.value(metadata i64 %92, metadata !108, metadata !DIExpression()), !dbg !122
  %93 = icmp eq i64 %92, %0, !dbg !130
  br i1 %93, label %94, label %84, !dbg !123, !llvm.loop !131

; <label>:94:                                     ; preds = %84
  %95 = add nuw i64 %80, 1, !dbg !134
  call void @llvm.dbg.value(metadata i64 %95, metadata !106, metadata !DIExpression()), !dbg !119
  %96 = icmp eq i64 %95, %1, !dbg !120
  br i1 %96, label %97, label %79, !dbg !121, !llvm.loop !135

; <label>:97:                                     ; preds = %94, %73, %9, %75
  ret void, !dbg !138
}

; Function Attrs: nounwind uwtable
define internal void @trans_basic(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture readnone) #0 !dbg !100 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !99, metadata !DIExpression()), !dbg !139
  call void @llvm.dbg.value(metadata i64 %1, metadata !102, metadata !DIExpression()), !dbg !140
  call void @llvm.dbg.value(metadata double* %2, metadata !103, metadata !DIExpression()), !dbg !141
  call void @llvm.dbg.value(metadata double* %3, metadata !104, metadata !DIExpression()), !dbg !142
  call void @llvm.dbg.value(metadata double* %4, metadata !105, metadata !DIExpression()), !dbg !143
  call void @llvm.dbg.value(metadata i64 0, metadata !106, metadata !DIExpression()), !dbg !144
  %6 = icmp eq i64 %1, 0, !dbg !145
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !136
  br i1 %8, label %27, label %9, !dbg !136

; <label>:9:                                      ; preds = %5, %24
  %10 = phi i64 [ %25, %24 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !106, metadata !DIExpression()), !dbg !144
  call void @llvm.dbg.value(metadata i64 0, metadata !108, metadata !DIExpression()), !dbg !146
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = getelementptr inbounds double, double* %3, i64 %10
  br label %14, !dbg !132

; <label>:14:                                     ; preds = %14, %9
  %15 = phi i64 [ 0, %9 ], [ %22, %14 ]
  call void @llvm.dbg.value(metadata i64 %15, metadata !108, metadata !DIExpression()), !dbg !146
  %16 = getelementptr inbounds double, double* %12, i64 %15, !dbg !147
  %17 = bitcast double* %16 to i64*, !dbg !147
  %18 = load i64, i64* %17, align 8, !dbg !147, !tbaa !70
  %19 = mul nsw i64 %15, %1, !dbg !148
  %20 = getelementptr inbounds double, double* %13, i64 %19, !dbg !148
  %21 = bitcast double* %20 to i64*, !dbg !149
  store i64 %18, i64* %21, align 8, !dbg !149, !tbaa !70
  %22 = add nuw i64 %15, 1, !dbg !150
  call void @llvm.dbg.value(metadata i64 %22, metadata !108, metadata !DIExpression()), !dbg !146
  %23 = icmp eq i64 %22, %0, !dbg !151
  br i1 %23, label %24, label %14, !dbg !132, !llvm.loop !131

; <label>:24:                                     ; preds = %14
  %25 = add nuw i64 %10, 1, !dbg !152
  call void @llvm.dbg.value(metadata i64 %25, metadata !106, metadata !DIExpression()), !dbg !144
  %26 = icmp eq i64 %25, %1, !dbg !145
  br i1 %26, label %27, label %9, !dbg !136, !llvm.loop !135

; <label>:27:                                     ; preds = %24, %5
  ret void, !dbg !153
}

; Function Attrs: nounwind uwtable
define internal void @trans_tmp(i64, i64, double* nocapture readonly, double* nocapture, double* nocapture) #0 !dbg !154 {
  call void @llvm.dbg.value(metadata i64 %0, metadata !156, metadata !DIExpression()), !dbg !171
  call void @llvm.dbg.value(metadata i64 %1, metadata !157, metadata !DIExpression()), !dbg !172
  call void @llvm.dbg.value(metadata double* %2, metadata !158, metadata !DIExpression()), !dbg !173
  call void @llvm.dbg.value(metadata double* %3, metadata !159, metadata !DIExpression()), !dbg !174
  call void @llvm.dbg.value(metadata double* %4, metadata !160, metadata !DIExpression()), !dbg !175
  call void @llvm.dbg.value(metadata i64 0, metadata !161, metadata !DIExpression()), !dbg !176
  %6 = icmp eq i64 %1, 0, !dbg !177
  %7 = icmp eq i64 %0, 0
  %8 = or i1 %6, %7, !dbg !178
  br i1 %8, label %33, label %9, !dbg !178

; <label>:9:                                      ; preds = %5, %30
  %10 = phi i64 [ %31, %30 ], [ 0, %5 ]
  call void @llvm.dbg.value(metadata i64 %10, metadata !161, metadata !DIExpression()), !dbg !176
  call void @llvm.dbg.value(metadata i64 0, metadata !163, metadata !DIExpression()), !dbg !179
  %11 = mul nsw i64 %10, %0
  %12 = getelementptr inbounds double, double* %2, i64 %11
  %13 = shl i64 %10, 1
  %14 = and i64 %13, 2
  %15 = getelementptr inbounds double, double* %3, i64 %10
  br label %16, !dbg !180

; <label>:16:                                     ; preds = %16, %9
  %17 = phi i64 [ 0, %9 ], [ %28, %16 ]
  call void @llvm.dbg.value(metadata i64 %17, metadata !163, metadata !DIExpression()), !dbg !179
  call void @llvm.dbg.value(metadata i64 %10, metadata !167, metadata !DIExpression(DW_OP_constu, 1, DW_OP_and, DW_OP_stack_value)), !dbg !181
  %18 = and i64 %17, 1, !dbg !182
  call void @llvm.dbg.value(metadata i64 %18, metadata !170, metadata !DIExpression()), !dbg !183
  %19 = getelementptr inbounds double, double* %12, i64 %17, !dbg !184
  %20 = bitcast double* %19 to i64*, !dbg !184
  %21 = load i64, i64* %20, align 8, !dbg !184, !tbaa !70
  %22 = or i64 %18, %14, !dbg !185
  %23 = getelementptr inbounds double, double* %4, i64 %22, !dbg !186
  %24 = bitcast double* %23 to i64*, !dbg !187
  store i64 %21, i64* %24, align 8, !dbg !187, !tbaa !70
  %25 = mul nsw i64 %17, %1, !dbg !188
  %26 = getelementptr inbounds double, double* %15, i64 %25, !dbg !188
  %27 = bitcast double* %26 to i64*, !dbg !189
  store i64 %21, i64* %27, align 8, !dbg !189, !tbaa !70
  %28 = add nuw i64 %17, 1, !dbg !190
  call void @llvm.dbg.value(metadata i64 %28, metadata !163, metadata !DIExpression()), !dbg !179
  %29 = icmp eq i64 %28, %0, !dbg !191
  br i1 %29, label %30, label %16, !dbg !180, !llvm.loop !192

; <label>:30:                                     ; preds = %16
  %31 = add nuw i64 %10, 1, !dbg !194
  call void @llvm.dbg.value(metadata i64 %31, metadata !161, metadata !DIExpression()), !dbg !176
  %32 = icmp eq i64 %31, %1, !dbg !177
  br i1 %32, label %33, label %9, !dbg !178, !llvm.loop !195

; <label>:33:                                     ; preds = %30, %5
  ret void, !dbg !197
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, metadata, metadata) #2

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.0 (tags/RELEASE_700/final)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "trans.c", directory: "/afs/andrew.cmu.edu/usr12/xinyiwan/private/15213/cachelab")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!7 = distinct !DISubprogram(name: "registerFunctions", scope: !1, file: !1, line: 159, type: !8, isLocal: false, isDefinition: true, scopeLine: 159, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocation(line: 161, column: 5, scope: !7)
!11 = !DILocation(line: 164, column: 5, scope: !7)
!12 = !DILocation(line: 165, column: 5, scope: !7)
!13 = !DILocation(line: 166, column: 1, scope: !7)
!14 = distinct !DISubprogram(name: "transpose_submit", scope: !1, file: !1, line: 125, type: !15, isLocal: true, isDefinition: true, scopeLine: 126, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !26)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !17, !17, !20, !20, !25}
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !18, line: 62, baseType: !19)
!18 = !DIFile(filename: "/usr/local/depot/llvm-7.0/lib/clang/7.0.0/include/stddef.h", directory: "/afs/andrew.cmu.edu/usr12/xinyiwan/private/15213/cachelab")
!19 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !21, size: 64)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, elements: !23)
!22 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!23 = !{!24}
!24 = !DISubrange(count: -1)
!25 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!26 = !{!27, !28, !29, !30, !31, !32, !33, !36, !37, !38}
!27 = !DILocalVariable(name: "M", arg: 1, scope: !14, file: !1, line: 125, type: !17)
!28 = !DILocalVariable(name: "N", arg: 2, scope: !14, file: !1, line: 125, type: !17)
!29 = !DILocalVariable(name: "A", arg: 3, scope: !14, file: !1, line: 125, type: !20)
!30 = !DILocalVariable(name: "B", arg: 4, scope: !14, file: !1, line: 125, type: !20)
!31 = !DILocalVariable(name: "tmp", arg: 5, scope: !14, file: !1, line: 126, type: !25)
!32 = !DILocalVariable(name: "block", scope: !14, file: !1, line: 128, type: !19)
!33 = !DILocalVariable(name: "i", scope: !34, file: !1, line: 130, type: !19)
!34 = distinct !DILexicalBlock(scope: !35, file: !1, line: 129, column: 43)
!35 = distinct !DILexicalBlock(scope: !14, file: !1, line: 129, column: 9)
!36 = !DILocalVariable(name: "j", scope: !34, file: !1, line: 130, type: !19)
!37 = !DILocalVariable(name: "i_c", scope: !34, file: !1, line: 131, type: !19)
!38 = !DILocalVariable(name: "j_c", scope: !34, file: !1, line: 131, type: !19)
!39 = !DILocation(line: 125, column: 37, scope: !14)
!40 = !DILocation(line: 125, column: 47, scope: !14)
!41 = !DILocation(line: 125, column: 57, scope: !14)
!42 = !DILocation(line: 125, column: 73, scope: !14)
!43 = !DILocation(line: 126, column: 37, scope: !14)
!44 = !DILocation(line: 128, column: 19, scope: !14)
!45 = !DILocation(line: 129, column: 24, scope: !35)
!46 = !DILocation(line: 131, column: 23, scope: !34)
!47 = !DILocation(line: 133, column: 27, scope: !48)
!48 = distinct !DILexicalBlock(scope: !49, file: !1, line: 133, column: 9)
!49 = distinct !DILexicalBlock(scope: !34, file: !1, line: 133, column: 9)
!50 = !DILocation(line: 133, column: 9, scope: !49)
!51 = !DILocation(line: 131, column: 28, scope: !34)
!52 = !DILocation(line: 134, column: 13, scope: !53)
!53 = distinct !DILexicalBlock(scope: !48, file: !1, line: 134, column: 13)
!54 = !DILocation(line: 130, column: 23, scope: !34)
!55 = !DILocation(line: 135, column: 17, scope: !56)
!56 = distinct !DILexicalBlock(scope: !57, file: !1, line: 135, column: 17)
!57 = distinct !DILexicalBlock(scope: !58, file: !1, line: 134, column: 50)
!58 = distinct !DILexicalBlock(scope: !53, file: !1, line: 134, column: 13)
!59 = !DILocation(line: 134, column: 31, scope: !58)
!60 = distinct !{!60, !52, !61}
!61 = !DILocation(line: 146, column: 13, scope: !53)
!62 = !DILocation(line: 130, column: 26, scope: !34)
!63 = !DILocation(line: 136, column: 21, scope: !64)
!64 = distinct !DILexicalBlock(scope: !65, file: !1, line: 136, column: 21)
!65 = distinct !DILexicalBlock(scope: !66, file: !1, line: 135, column: 53)
!66 = distinct !DILexicalBlock(scope: !56, file: !1, line: 135, column: 17)
!67 = !DILocation(line: 143, column: 35, scope: !68)
!68 = distinct !DILexicalBlock(scope: !69, file: !1, line: 142, column: 37)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 142, column: 25)
!70 = !{!71, !71, i64 0}
!71 = !{!"double", !72, i64 0}
!72 = !{!"omnipotent char", !73, i64 0}
!73 = !{!"Simple C/C++ TBAA"}
!74 = !DILocation(line: 143, column: 25, scope: !68)
!75 = !DILocation(line: 143, column: 33, scope: !68)
!76 = !DILocation(line: 144, column: 21, scope: !68)
!77 = !DILocation(line: 135, column: 49, scope: !66)
!78 = !DILocation(line: 135, column: 33, scope: !66)
!79 = distinct !{!79, !55, !80}
!80 = !DILocation(line: 145, column: 17, scope: !56)
!81 = !DILocation(line: 142, column: 25, scope: !65)
!82 = !DILocation(line: 137, column: 31, scope: !83)
!83 = distinct !DILexicalBlock(scope: !84, file: !1, line: 137, column: 29)
!84 = distinct !DILexicalBlock(scope: !85, file: !1, line: 136, column: 57)
!85 = distinct !DILexicalBlock(scope: !64, file: !1, line: 136, column: 21)
!86 = !DILocation(line: 137, column: 29, scope: !84)
!87 = !DILocation(line: 138, column: 39, scope: !88)
!88 = distinct !DILexicalBlock(scope: !83, file: !1, line: 137, column: 37)
!89 = !DILocation(line: 138, column: 29, scope: !88)
!90 = !DILocation(line: 138, column: 37, scope: !88)
!91 = !DILocation(line: 140, column: 25, scope: !88)
!92 = !DILocation(line: 136, column: 53, scope: !85)
!93 = !DILocation(line: 136, column: 37, scope: !85)
!94 = distinct !{!94, !63, !95}
!95 = !DILocation(line: 141, column: 21, scope: !64)
!96 = !DILocation(line: 134, column: 40, scope: !58)
!97 = distinct !{!97, !50, !98}
!98 = !DILocation(line: 146, column: 13, scope: !49)
!99 = !DILocalVariable(name: "M", arg: 1, scope: !100, file: !1, line: 81, type: !17)
!100 = distinct !DISubprogram(name: "trans_basic", scope: !1, file: !1, line: 81, type: !15, isLocal: true, isDefinition: true, scopeLine: 82, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !101)
!101 = !{!99, !102, !103, !104, !105, !106, !108}
!102 = !DILocalVariable(name: "N", arg: 2, scope: !100, file: !1, line: 81, type: !17)
!103 = !DILocalVariable(name: "A", arg: 3, scope: !100, file: !1, line: 81, type: !20)
!104 = !DILocalVariable(name: "B", arg: 4, scope: !100, file: !1, line: 81, type: !20)
!105 = !DILocalVariable(name: "tmp", arg: 5, scope: !100, file: !1, line: 82, type: !25)
!106 = !DILocalVariable(name: "i", scope: !107, file: !1, line: 86, type: !17)
!107 = distinct !DILexicalBlock(scope: !100, file: !1, line: 86, column: 5)
!108 = !DILocalVariable(name: "j", scope: !109, file: !1, line: 87, type: !17)
!109 = distinct !DILexicalBlock(scope: !110, file: !1, line: 87, column: 9)
!110 = distinct !DILexicalBlock(scope: !111, file: !1, line: 86, column: 36)
!111 = distinct !DILexicalBlock(scope: !107, file: !1, line: 86, column: 5)
!112 = !DILocation(line: 81, column: 32, scope: !100, inlinedAt: !113)
!113 = distinct !DILocation(line: 148, column: 9, scope: !114)
!114 = distinct !DILexicalBlock(scope: !35, file: !1, line: 147, column: 12)
!115 = !DILocation(line: 81, column: 42, scope: !100, inlinedAt: !113)
!116 = !DILocation(line: 81, column: 52, scope: !100, inlinedAt: !113)
!117 = !DILocation(line: 81, column: 68, scope: !100, inlinedAt: !113)
!118 = !DILocation(line: 82, column: 32, scope: !100, inlinedAt: !113)
!119 = !DILocation(line: 86, column: 17, scope: !107, inlinedAt: !113)
!120 = !DILocation(line: 86, column: 26, scope: !111, inlinedAt: !113)
!121 = !DILocation(line: 86, column: 5, scope: !107, inlinedAt: !113)
!122 = !DILocation(line: 87, column: 21, scope: !109, inlinedAt: !113)
!123 = !DILocation(line: 87, column: 9, scope: !109, inlinedAt: !113)
!124 = !DILocation(line: 88, column: 23, scope: !125, inlinedAt: !113)
!125 = distinct !DILexicalBlock(scope: !126, file: !1, line: 87, column: 40)
!126 = distinct !DILexicalBlock(scope: !109, file: !1, line: 87, column: 9)
!127 = !DILocation(line: 88, column: 13, scope: !125, inlinedAt: !113)
!128 = !DILocation(line: 88, column: 21, scope: !125, inlinedAt: !113)
!129 = !DILocation(line: 87, column: 36, scope: !126, inlinedAt: !113)
!130 = !DILocation(line: 87, column: 30, scope: !126, inlinedAt: !113)
!131 = distinct !{!131, !132, !133}
!132 = !DILocation(line: 87, column: 9, scope: !109)
!133 = !DILocation(line: 89, column: 9, scope: !109)
!134 = !DILocation(line: 86, column: 32, scope: !111, inlinedAt: !113)
!135 = distinct !{!135, !136, !137}
!136 = !DILocation(line: 86, column: 5, scope: !107)
!137 = !DILocation(line: 90, column: 5, scope: !107)
!138 = !DILocation(line: 150, column: 1, scope: !14)
!139 = !DILocation(line: 81, column: 32, scope: !100)
!140 = !DILocation(line: 81, column: 42, scope: !100)
!141 = !DILocation(line: 81, column: 52, scope: !100)
!142 = !DILocation(line: 81, column: 68, scope: !100)
!143 = !DILocation(line: 82, column: 32, scope: !100)
!144 = !DILocation(line: 86, column: 17, scope: !107)
!145 = !DILocation(line: 86, column: 26, scope: !111)
!146 = !DILocation(line: 87, column: 21, scope: !109)
!147 = !DILocation(line: 88, column: 23, scope: !125)
!148 = !DILocation(line: 88, column: 13, scope: !125)
!149 = !DILocation(line: 88, column: 21, scope: !125)
!150 = !DILocation(line: 87, column: 36, scope: !126)
!151 = !DILocation(line: 87, column: 30, scope: !126)
!152 = !DILocation(line: 86, column: 32, scope: !111)
!153 = !DILocation(line: 93, column: 1, scope: !100)
!154 = distinct !DISubprogram(name: "trans_tmp", scope: !1, file: !1, line: 101, type: !15, isLocal: true, isDefinition: true, scopeLine: 102, flags: DIFlagPrototyped, isOptimized: true, unit: !0, retainedNodes: !155)
!155 = !{!156, !157, !158, !159, !160, !161, !163, !167, !170}
!156 = !DILocalVariable(name: "M", arg: 1, scope: !154, file: !1, line: 101, type: !17)
!157 = !DILocalVariable(name: "N", arg: 2, scope: !154, file: !1, line: 101, type: !17)
!158 = !DILocalVariable(name: "A", arg: 3, scope: !154, file: !1, line: 101, type: !20)
!159 = !DILocalVariable(name: "B", arg: 4, scope: !154, file: !1, line: 101, type: !20)
!160 = !DILocalVariable(name: "tmp", arg: 5, scope: !154, file: !1, line: 102, type: !25)
!161 = !DILocalVariable(name: "i", scope: !162, file: !1, line: 106, type: !17)
!162 = distinct !DILexicalBlock(scope: !154, file: !1, line: 106, column: 5)
!163 = !DILocalVariable(name: "j", scope: !164, file: !1, line: 107, type: !17)
!164 = distinct !DILexicalBlock(scope: !165, file: !1, line: 107, column: 9)
!165 = distinct !DILexicalBlock(scope: !166, file: !1, line: 106, column: 36)
!166 = distinct !DILexicalBlock(scope: !162, file: !1, line: 106, column: 5)
!167 = !DILocalVariable(name: "di", scope: !168, file: !1, line: 108, type: !17)
!168 = distinct !DILexicalBlock(scope: !169, file: !1, line: 107, column: 40)
!169 = distinct !DILexicalBlock(scope: !164, file: !1, line: 107, column: 9)
!170 = !DILocalVariable(name: "dj", scope: !168, file: !1, line: 109, type: !17)
!171 = !DILocation(line: 101, column: 30, scope: !154)
!172 = !DILocation(line: 101, column: 40, scope: !154)
!173 = !DILocation(line: 101, column: 50, scope: !154)
!174 = !DILocation(line: 101, column: 66, scope: !154)
!175 = !DILocation(line: 102, column: 30, scope: !154)
!176 = !DILocation(line: 106, column: 17, scope: !162)
!177 = !DILocation(line: 106, column: 26, scope: !166)
!178 = !DILocation(line: 106, column: 5, scope: !162)
!179 = !DILocation(line: 107, column: 21, scope: !164)
!180 = !DILocation(line: 107, column: 9, scope: !164)
!181 = !DILocation(line: 108, column: 20, scope: !168)
!182 = !DILocation(line: 109, column: 27, scope: !168)
!183 = !DILocation(line: 109, column: 20, scope: !168)
!184 = !DILocation(line: 110, column: 32, scope: !168)
!185 = !DILocation(line: 110, column: 24, scope: !168)
!186 = !DILocation(line: 110, column: 13, scope: !168)
!187 = !DILocation(line: 110, column: 30, scope: !168)
!188 = !DILocation(line: 111, column: 13, scope: !168)
!189 = !DILocation(line: 111, column: 21, scope: !168)
!190 = !DILocation(line: 107, column: 36, scope: !169)
!191 = !DILocation(line: 107, column: 30, scope: !169)
!192 = distinct !{!192, !180, !193}
!193 = !DILocation(line: 112, column: 9, scope: !164)
!194 = !DILocation(line: 106, column: 32, scope: !166)
!195 = distinct !{!195, !178, !196}
!196 = !DILocation(line: 113, column: 5, scope: !162)
!197 = !DILocation(line: 116, column: 1, scope: !154)
