<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 정보 관리</title>

    <jsp:include page="../partial/config.jsp"></jsp:include>
    <script src="${pageContext.request.contextPath}/res/js/login.js"></script>
</head>
<body>
<div class="container text-center" style="margin-top: 8%;">
    <jsp:include page="../partial/nav.jsp"></jsp:include>

    <h1 class="ssafy">회원 정보 수정</h1>
    <hr>

    <form action="${pageContext.request.contextPath}/main.do" method="post">
        <input type="hidden" name="action" value="updateUser">

        <div class="form-group">
            <label for="id">USER_ID</label>
            <input class="form-control margin-auto login-input-width"
                   type="text" id="id" name="id" value="${user.userId}" readonly>
        </div>

        <div class="form-group">
            <label for="name">NAME</label>
            <input class="form-control margin-auto login-input-width"
                   type="text" id="name" name="name" value="${user.name}">
        </div>

        <br>

        <div>
            <label>현재 나의 알러지 정보</label><br>
            <c:choose>
                <c:when test="${not empty allergyList}">
                    <c:forEach items="${allergyList}" var="al">
                        <span>${al.name}&nbsp;</span>
                    </c:forEach>
                </c:when>
            </c:choose>
        </div>

        <hr>

        <div>
            <label>알러지 재설정</label><br>
            <c:forEach items="${allergies}" var="a">
                <label><input type="checkbox" name="allergy[]" value="${a.name}"> ${a.name}</label>
            </c:forEach>
        </div>

        <hr>
        <div class="div-margin-bottom">
            <button class="btn btn-primary" type="submit" onclick="validate();">저장</button>
        </div>
    </form>
</div>
</body>
</html>