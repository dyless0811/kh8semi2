<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form method="post">

<h3>회원정보수정</h3>


    <div class="form-group">
        <fieldset>
          <label class="form-label mt-4" for="readOnlyInput">이메일</label>
          <input class="form-control" id="readOnlyInput" type="text" value="${memberDto.memberEmail}" readonly="">
        </fieldset>
      </div>  

      <div class="form-group">
        <label class="col-form-label mt-4" for="inputDefault">별명</label>
        <input type="text" class="form-control" value="${memberDto.memberNickname}" id="inputDefault">
      </div>

      <fieldset class="form-group">
        <label class="mt-4">성별</label>
      </fieldset>
      <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked="">
        <label class="btn btn-outline-primary" for="btnradio1">남자</label>
        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" checked="">
        <label class="btn btn-outline-primary" for="btnradio2">여자</label>
      </div>

      <div class="form-group">
        <label for="date" class="form-label mt-4">생년월일</label>
        <input type="date">
    </div>

      <div class="row">
        <label for="date" class="form-label mt-4">프로필 이미지
        </label>
        <c:choose>
            <c:when test="${memberProfileDto == null}">
            <img src="https://via.placeholder.com/300x300?text=User" width="100%" class="image image-round image-border">
            </c:when>
            <c:otherwise>
            <img src="profile?memberProfileNo=${memberProfileDto.memberProfileNo}" width="100%" class="image image-round image-border">
            </c:otherwise>
        </c:choose>
    
      <div class="form-group">
        <label for="exampleTextarea" class="form-label mt-4">한줄소개</label>
        <textarea class="form-control" id="exampleTextarea" rows="1"></textarea>
      </div>

      <div class="d-grid gap-2">
        <button class="btn btn-lg btn-primary" type="submit">회원 정보 수정</button>
      </div>

	<c:if test="${param.error != null}">
	<div class="row center">
		<h4 class="error">입력하신 정보가 일치하지 않습니다</h4>
	</div>
	</c:if>
</div>
</form>

<%if(request.getParameter("error") != null){ %>
	<h4><font color="red">입력하신 정보가 일치하지 않습니다</font></h4>
<%} %>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>