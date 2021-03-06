<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>

    <jsp:include page="WEB-INF/partial/config.jsp"></jsp:include>
    <script src="${pageContext.request.contextPath}/res/js/login.js"></script>
</head>
<body>
<div class="container text-center" style="margin-top: 8%;">
    <h1 class="ssafy">회원가입</h1>
    <hr>

    <form action="${pageContext.request.contextPath}/main.do" method="post">
        <input type="hidden" name="action" value="signUp">

        <div class="form-group">
            <label for="id">ID</label>
            <input class="form-control margin-auto login-input-width"
                   type="text" id="id" name="id"
                   placeholder="ID를 입력하세요.">

            <c:if test="${errorMessages.idError != null}">
                <span class="error">${errorMessages.idError}</span>
            </c:if>

            <c:if test="${errorMessages.idAlready != null}">
                <span class="error">${errorMessages.idAlready}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="pw">PW</label>
            <input class="form-control margin-auto login-input-width"
                   type="password" id="pw" name="pw"
                   placeholder="Password를 입력하세요.">

            <c:if test="${errorMessages.pwError != null}">
                <span class="error">${errorMessages.pwError}</span>
            </c:if>
        </div>

        <div class="form-group">
            <label for="name">NAME</label>
            <input class="form-control margin-auto login-input-width"
                   type="text" id="name" name="name"
                   placeholder="이름을 입력하세요.">

            <c:if test="${errorMessages.nameError != null}">
                <span class="error">${errorMessages.nameError}</span>
            </c:if>
        </div>

        <div>
            <label>Allergy</label><br>
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