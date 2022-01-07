<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"></c:set>
<script src="${root }/resources/ckeditor5/build/ckeditor.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	.profile-image{
		border-radius: 50%;
		width:15%;
		height:15%;
	}
	.dropdown:hover{
		background-color: #dfe6e9;
	}
</style>
<script>
	$(function(){
		var page = 1;
		var size = 18;
		var result = $("#result")
		var column = "sns_no";
		
		$(".more-btn").click(function(){
			loadData(page, size, column);
			page++;
		});
		

		
			$(".column").click(function(e){
				e.preventDefault();
				page = 1;
				column = $(this).data("column");
				$(this).parent().next().next().find(".row").empty();
				console.log(column);
				loadData(page, size, column);
				page++;
			});
			
			
		
		$(".more-btn").click();
		
	});
		function loadData(page, size, column){
			$.ajax({
				url : "${pageContext.request.contextPath}/sns/data/list",
				type : "get",
				data : {
					page : page,
					size : size,
					column : column
				},
				dataType : "json",
				success:function(resp){
					console.log("성공", resp);
					if(resp.length < size){
						$(".more-btn").remove();
					}
					
					console.log(resp);
		
					for(var i=0; i<resp.length; i++){
						var result = $("#result")
						var clonedTemplate = $("#sns-template").clone();
						var templateContent = $(clonedTemplate.html());
						templateContent.find("#a").attr("href", "${pageContext.request.contextPath}/sns/detail?snsNo="+resp[i].snsNo);
						templateContent.find("#thumnail").attr("src", "${pageContext.request.contextPath}/sns/thumnail?snsNo="+resp[i].snsNo);
// 						var str = resp[i].snsDetail;
// 						templateContent.find(".card-text").text(str.substr(-10));
						templateContent.find(".profile-image").attr("src", "${pageContext.request.contextPath}/member/profile?memberNo="+resp[i].memberNo);
						templateContent.find("#nickname").text(resp[i].memberNickname);
						templateContent.find("#count").text("조회수 : "+resp[i].snsCount);
						var timestamp = resp[i].snsDate;
						var date = new Date(resp[i].snsDate);
						templateContent.find("#date").text(date.toLocaleString());
						templateContent.find("#like").text(resp[i].count);//좋아요개수
						templateContent.find("#reply").text(resp[i].snsReplyCount);
						templateContent.find(".follow-btn").attr("data-member-no", resp[i].memberNo);
						templateContent.find(".unfollowBtn").attr("data-member-no", resp[i].memberNo);
						templateContent.find(".member-page").attr("href", "${pageContext.request.contextPath}/member/page?memberNo=" + resp[i].memberNo);
						clonedTemplate.html(templateContent.prop('outerHTML'));
						result.append(clonedTemplate.html());
					}
				},
				error:function(e){
					console.log("실패", e);
				}
			});
		}
	
	
	
	
	$(function(){
		$(document).on("click", ".follow-btn", function (){
			console.log(1);
		var memberNo = $(this).data("member-no");
		console.log(memberNo);
			
		$.ajax({
			url:"${pageContext.request.contextPath}/follow/follow",
			type:"post",
			data : {
				memberNo : memberNo
			},
			dataType :"text",
			success : function(resp) {
					console.log("팔로우성공", resp);

			},
			error:function(e){
				console.log("실패", e);
			}
		});
	
		});
		
		$(document).on("click", ".unfollowBtn", function (){
			
			var memberNoValue = $(this).data("member-no");
			
		$.ajax({
					url : "${pageContext.request.contextPath}/follow/unfollow",
					type : "POST",
					data : {
						memberNo : memberNoValue
					},
					dataType :"text",
					success : function(resp) {
							console.log("언팔로우성공", resp);

					},
					error:function(e){
						console.log("실패", e);
					}
				});
		});
});
	
	
	
	
</script>

<div class="container-zipggu">
<div class="container-fluid">
	<div class="row py-lg-5 text-center">
   		<div class="col-lg-6 col-md-8 mx-auto">
        	<h1 class="fw-light">
        		<font style="vertical-align: inherit;">
        		<font style="vertical-align: inherit;">
        			앨범 예
        		</font>
        		</font>
        	</h1>
           	<p class="lead text-muted">
           		<font style="vertical-align: inherit;">
           		<font style="vertical-align: inherit;">
           			아래 앨범에 대한 간략한 설명(내용, 제작자 등). 
           		</font>
           		<font style="vertical-align: inherit;">
           			짧고 귀엽게 유지하되 너무 짧지 않도록 하여 사람들이 이 앨범을 완전히 건너뛰지 않도록 합니다.
           		</font>
           		</font>
           	</p>
        </div>
    </div>
	
	<div class="container text-start">
		<a href="sns" class="column btn btn-outline-secondary" data-column="sns_count">조회수 정렬</a>
		<a href="sns" class="column btn btn-outline-secondary" data-column="count">좋아요 정렬</a>
		<a href="sns" class="column btn btn-outline-secondary" data-column="sns_reply_count">댓글 정렬</a>
	</div>
	
   	<div class="container text-end">
		<a href="sns/write" class="btn btn-outline-secondary">등록</a>
	</div>
	
	<div class="album py-5">
		<div class="container">
           <div class="row row-cols-1 row-cols-sm-4 row-cols-sm-4 g-3" id="result"> 	
           </div>	
		</div>
	</div>
    <button type="button" class="btn btn-primary more-btn">더보기</button>
</div>
</div>
<template id="sns-template">

            	<div class="col">
                	<div class="card shadow-sm">
                		
	                		<a href="detail?snsNo=${snsDto.snsNo }" id="a">
								<img src="thumnail?snsNo=${snsDto.snsNo}" id="thumnail" class="card-img bd-placeholder-img card-img-top" width="100%" height="190" >
								<div class="card-img-overlay">
								<span id="count" style='color:white' style='text:bold'></span>
								</div>
							</a>
						
						<div class="d-flex justify-content-between align-items-center mt-2 ms-3">
  								<div>
   									<!-- 좋아요 아이콘 -->
                 					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
										<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
									</svg>
                   					<span id="like"></span>
                   					&nbsp;&nbsp;
                   					
                					<!-- 댓글 아이콘 -->
                   					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots ms-4" viewBox="0 0 16 16">
	  									<path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
	  									<path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"></path>
									</svg>
                   					<span id="reply"></span>
                   				
                 				</div>
                 	
            			</div>
						<div class="card-body p-2">
<!--   							<div class="card-text"> -->
<%--   								<pre id="content">${snsDto.snsDetail }</pre> --%>
<!--   							</div> -->
							
							<div>
                 				<!-- 페이지 이동 어디로??????????????????? -->
                 				<form class="follow">
                 					<input type="hidden" name="memberNo" value="${loginNo }">
                 				</form>
                 				
                 				<div class="dropdown">
								  <a href="#" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
               						<img src="profile?memberNo=${memberProfileDto.memberNo}" class="profile-image">
               						<small class="text-muted" id="nickname">
	                 					작성자	
	                 				</small>
								  </a>
								
								  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								    <li><button id="" class="follow-btn followBtn dropdown-item">팔로우</button></li>
								    <li><button class="unfollowBtn dropdown-item">팔로우 취소</button></li>
								    <li><a class="member-page dropdown-item" href="">회원 페이지</a></li>
								  </ul>
								</div>
<%--                					<a href="${root }/member/mypage"> --%>
<%--                						<img src="profile?memberNo=${memberProfileDto.memberNo}" class="profile-image"> --%>
<!--                  				<small class="text-muted" id="nickname"> -->
<%--                  					${loginNick }	 --%>
<!--                  				</small> -->
<!--                					</a> -->
                 			</div>
                 			<div>
                 				<div class="text-muted" id="date">게시물 등록 날짜</div>
                 			</div>
          				</div>
        			</div>
      			</div>

</template>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>