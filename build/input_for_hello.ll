; ModuleID = '../../inputs/input_for_hello.c'
source_filename = "../../inputs/input_for_hello.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32*, %struct.Node* }

@.str = private unnamed_addr constant [14 x i8] c"v1=%d  v2=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [20 x i8] c"mean(float) = %.3f\0A\00", align 1
@.str.2 = private unnamed_addr constant [21 x i8] c"mean(double) = %.3f\0A\00", align 1

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn
define dso_local i32 @foo(i32 noundef %0, i32** nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = shl nsw i32 %0, 1
  %4 = load i32*, i32** %1, align 8, !tbaa !5
  %5 = load i32, i32* %4, align 4, !tbaa !9
  %6 = add nsw i32 %5, %3
  ret i32 %6
}

; Function Attrs: nofree norecurse nosync nounwind readonly uwtable
define dso_local i32 @count_first_letters(i8** nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #1 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %4, label %6

4:                                                ; preds = %2
  %5 = zext i32 %1 to i64
  br label %8

6:                                                ; preds = %8, %2
  %7 = phi i32 [ 0, %2 ], [ %15, %8 ]
  ret i32 %7

8:                                                ; preds = %4, %8
  %9 = phi i64 [ 0, %4 ], [ %16, %8 ]
  %10 = phi i32 [ 0, %4 ], [ %15, %8 ]
  %11 = getelementptr inbounds i8*, i8** %0, i64 %9
  %12 = load i8*, i8** %11, align 8, !tbaa !5
  %13 = load i8, i8* %12, align 1, !tbaa !11
  %14 = sext i8 %13 to i32
  %15 = add nsw i32 %10, %14
  %16 = add nuw nsw i64 %9, 1
  %17 = icmp eq i64 %16, %5
  br i1 %17, label %6, label %8, !llvm.loop !12
}

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: mustprogress nofree norecurse nosync nounwind uwtable willreturn
define dso_local i32 @swap_values(i32** nocapture noundef readonly %0, i32** nocapture noundef readonly %1) local_unnamed_addr #3 {
  %3 = load i32*, i32** %0, align 8, !tbaa !5
  %4 = load i32, i32* %3, align 4, !tbaa !9
  %5 = load i32*, i32** %1, align 8, !tbaa !5
  %6 = load i32, i32* %5, align 4, !tbaa !9
  store i32 %6, i32* %3, align 4, !tbaa !9
  store i32 %4, i32* %5, align 4, !tbaa !9
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn
define dso_local float @mean_two(float** nocapture noundef readonly %0, float** nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = load float*, float** %0, align 8, !tbaa !5
  %4 = load float, float* %3, align 4, !tbaa !15
  %5 = load float*, float** %1, align 8, !tbaa !5
  %6 = load float, float* %5, align 4, !tbaa !15
  %7 = fadd float %4, %6
  %8 = fmul float %7, 5.000000e-01
  ret float %8
}

; Function Attrs: nofree norecurse nosync nounwind readonly uwtable
define dso_local i32 @sum_array_ptrs([5 x i32*]* nocapture noundef readonly %0, i32 noundef %1) local_unnamed_addr #1 {
  %3 = icmp sgt i32 %1, 0
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = add i32 %1, -1
  %6 = call i32 @llvm.umin.i32(i32 %5, i32 4)
  %7 = add nuw nsw i32 %6, 1
  %8 = zext i32 %7 to i64
  br label %11

9:                                                ; preds = %11, %2
  %10 = phi i32 [ 0, %2 ], [ %17, %11 ]
  ret i32 %10

11:                                               ; preds = %4, %11
  %12 = phi i64 [ 0, %4 ], [ %18, %11 ]
  %13 = phi i32 [ 0, %4 ], [ %17, %11 ]
  %14 = getelementptr inbounds [5 x i32*], [5 x i32*]* %0, i64 0, i64 %12
  %15 = load i32*, i32** %14, align 8, !tbaa !5
  %16 = load i32, i32* %15, align 4, !tbaa !9
  %17 = add nsw i32 %16, %13
  %18 = add nuw nsw i64 %12, 1
  %19 = icmp eq i64 %18, %8
  br i1 %19, label %9, label %11, !llvm.loop !17
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn
define dso_local i32 @node_first_val(%struct.Node* nocapture noundef readonly %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.Node, %struct.Node* %0, i64 0, i32 0
  %3 = load i32*, i32** %2, align 8, !tbaa !18
  %4 = load i32, i32* %3, align 4, !tbaa !9
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn
define dso_local i32 @deep_char(i8*** nocapture noundef readonly %0) local_unnamed_addr #0 {
  %2 = load i8**, i8*** %0, align 8, !tbaa !5
  %3 = load i8*, i8** %2, align 8, !tbaa !5
  %4 = load i8, i8* %3, align 1, !tbaa !11
  %5 = sext i8 %4 to i32
  ret i32 %5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn
define dso_local double @mean_dbl(double** nocapture noundef readonly %0, double** nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = load double*, double** %0, align 8, !tbaa !5
  %4 = load double, double* %3, align 8, !tbaa !20
  %5 = load double*, double** %1, align 8, !tbaa !5
  %6 = load double, double* %5, align 8, !tbaa !20
  %7 = fadd double %4, %6
  %8 = fmul double %7, 5.000000e-01
  ret double %8
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @bar(i32 noundef %0, i32 noundef %1) local_unnamed_addr #4 {
  %3 = shl nsw i32 %0, 1
  %4 = add nsw i32 %3, %1
  ret i32 %4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn
define dso_local i32 @fez(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #4 {
  %4 = shl nsw i32 %0, 1
  %5 = add nsw i32 %4, %1
  %6 = shl nsw i32 %5, 1
  %7 = add nsw i32 %6, %0
  %8 = mul nsw i32 %2, 3
  %9 = add nsw i32 %7, %8
  ret i32 %9
}

; Function Attrs: nofree nounwind uwtable
define dso_local i32 @main(i32 noundef %0, i8** nocapture noundef readonly %1) local_unnamed_addr #5 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca [5 x i32*], align 16
  %8 = alloca float, align 8
  %9 = alloca float, align 8
  %10 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %10) #8
  store i32 10, i32* %3, align 4, !tbaa !9
  %11 = bitcast i32* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %11) #8
  store i32 20, i32* %4, align 4, !tbaa !9
  %12 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %12) #8
  store i32 30, i32* %5, align 4, !tbaa !9
  %13 = bitcast i32* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %13) #8
  store i32 40, i32* %6, align 4, !tbaa !9
  %14 = bitcast [5 x i32*]* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %14) #8
  %15 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 0
  store i32* %3, i32** %15, align 16, !tbaa !5
  %16 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 1
  store i32* %4, i32** %16, align 8, !tbaa !5
  %17 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 2
  store i32* %5, i32** %17, align 16, !tbaa !5
  %18 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 3
  store i32* %6, i32** %18, align 8, !tbaa !5
  %19 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 4
  store i32* %3, i32** %19, align 16, !tbaa !5
  %20 = bitcast float* %8 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %20)
  store float 0x40091EB860000000, float* %8, align 8, !tbaa !15
  %21 = bitcast float* %9 to i8*
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %21)
  store float 0x4005C28F60000000, float* %9, align 8, !tbaa !15
  %22 = icmp sgt i32 %0, 0
  br i1 %22, label %23, label %37

23:                                               ; preds = %2
  %24 = zext i32 %0 to i64
  br label %25

25:                                               ; preds = %25, %23
  %26 = phi i64 [ 0, %23 ], [ %33, %25 ]
  %27 = phi i32 [ 0, %23 ], [ %32, %25 ]
  %28 = getelementptr inbounds i8*, i8** %1, i64 %26
  %29 = load i8*, i8** %28, align 8, !tbaa !5
  %30 = load i8, i8* %29, align 1, !tbaa !11
  %31 = sext i8 %30 to i32
  %32 = add nsw i32 %27, %31
  %33 = add nuw nsw i64 %26, 1
  %34 = icmp eq i64 %33, %24
  br i1 %34, label %35, label %25, !llvm.loop !12

35:                                               ; preds = %25
  %36 = add i32 %32, 331
  br label %37

37:                                               ; preds = %35, %2
  %38 = phi i32 [ 331, %2 ], [ %36, %35 ]
  store i32 20, i32* %3, align 4, !tbaa !9
  store i32 10, i32* %4, align 4, !tbaa !9
  %39 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i64 0, i64 0), i32 noundef 20, i32 noundef 10)
  %40 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([20 x i8], [20 x i8]* @.str.1, i64 0, i64 0), double noundef 0x400770A3E0000000)
  br label %41

41:                                               ; preds = %41, %37
  %42 = phi i64 [ 0, %37 ], [ %48, %41 ]
  %43 = phi i32 [ 0, %37 ], [ %47, %41 ]
  %44 = getelementptr inbounds [5 x i32*], [5 x i32*]* %7, i64 0, i64 %42
  %45 = load i32*, i32** %44, align 8, !tbaa !5
  %46 = load i32, i32* %45, align 4, !tbaa !9
  %47 = add nsw i32 %46, %43
  %48 = add nuw nsw i64 %42, 1
  %49 = icmp eq i64 %48, 5
  br i1 %49, label %50, label %41, !llvm.loop !17

50:                                               ; preds = %41
  %51 = load i32, i32* %3, align 4, !tbaa !9
  %52 = add i32 %38, %47
  %53 = add i32 %52, %51
  %54 = bitcast float* %8 to double*
  %55 = load double, double* %54, align 8, !tbaa !20
  %56 = bitcast float* %9 to double*
  %57 = load double, double* %56, align 8, !tbaa !20
  %58 = fadd double %55, %57
  %59 = fmul double %58, 5.000000e-01
  %60 = call i32 (i8*, ...) @printf(i8* noundef nonnull dereferenceable(1) getelementptr inbounds ([21 x i8], [21 x i8]* @.str.2, i64 0, i64 0), double noundef %59)
  %61 = load i32, i32* %5, align 4, !tbaa !9
  %62 = mul i32 %53, 3
  %63 = add i32 %62, %61
  %64 = load i32, i32* %6, align 4, !tbaa !9
  %65 = shl nsw i32 %63, 1
  %66 = add i32 %63, %64
  %67 = add i32 %66, %65
  %68 = shl i32 %67, 1
  %69 = add i32 %68, 369
  %70 = bitcast float* %9 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %70)
  %71 = bitcast float* %8 to i8*
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %71)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %14) #8
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %13) #8
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %12) #8
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %11) #8
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %10) #8
  ret i32 %69
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(i8* nocapture noundef readonly, ...) local_unnamed_addr #6

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #7

attributes #0 = { mustprogress nofree norecurse nosync nounwind readonly uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree norecurse nosync nounwind readonly uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { mustprogress nofree norecurse nosync nounwind uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress nofree norecurse nosync nounwind readnone uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nofree nounwind uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{!"Ubuntu clang version 14.0.6"}
!5 = !{!6, !6, i64 0}
!6 = !{!"any pointer", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = !{!7, !7, i64 0}
!12 = distinct !{!12, !13, !14}
!13 = !{!"llvm.loop.mustprogress"}
!14 = !{!"llvm.loop.unroll.disable"}
!15 = !{!16, !16, i64 0}
!16 = !{!"float", !7, i64 0}
!17 = distinct !{!17, !13, !14}
!18 = !{!19, !6, i64 0}
!19 = !{!"Node", !6, i64 0, !6, i64 8}
!20 = !{!21, !21, i64 0}
!21 = !{!"double", !7, i64 0}
