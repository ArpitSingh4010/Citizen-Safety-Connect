<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Simplified Starter</title>
    <style>body{font-family:Arial,Helvetica,sans-serif;margin:24px}</style>
</head>
<body>
<h1>Welcome to the Simplified Starter</h1>
<p>This is a beginner-friendly minimal example showing a JSP and a Servlet.</p>

<p>Use the form below (handled by `HelloServlet` at `/hello`):</p>
<form method="post" action="hello">
    <label for="name">Your name:</label>
    <input id="name" name="name" />
    <button type="submit">Say hello</button>
</form>

<p>Or click <a href="hello">Hello servlet (GET)</a>.</p>

<h3>Notes for beginners</h3>
<ul>
    <li>Servlets live under `src/main/java` and are compiled to `WEB-INF/classes`.</li>
    <li>JSPs are static files that can include dynamic Java code or Expression Language.</li>
    <li>Use `ant quick-deploy` (see root README) to compile and deploy quickly to Tomcat.</li>
</ul>

</body>
</html>
