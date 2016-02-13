<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>

<t:masterpage>
    <jsp:body>
        <!-- Main Content -->
        <div class="container-fluid">
            <div class="side-body padding-top">
                <div class="row">
                    <div class="col-lg-8 col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">
                                    <div class="title">URL tester</div>
                                </div>
                            </div>
                            <div class="card-body">
                                <form id="mainForm" class="form" action="/sendRequest" method="post">
                                    <div class="form-group">
                                        <div class="sub-title">URL:</div>
                                        <input id="urlField" class="text form-control" type="text" name="url"
                                               required/></p>
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                                        <div class="sub-title">Method:</div>
                                        <div>
                                            <div class="radio3 radio-check radio-inline">
                                                <input type="radio" id="radio1" name="optionGET" value="option1"
                                                       checked>
                                                <label for="radio1">
                                                    GET
                                                </label>
                                            </div>
                                            <div class="radio3 radio-check radio-inline">
                                                <input type="radio" id="radio2" name="optionPOST" value="option2"
                                                       disabled>
                                                <label for="radio2">
                                                    POST
                                                </label>
                                            </div>
                                        </div>
                                        <input id="submit" class="btn btn-success pull-right" type="submit"
                                               value="Submit">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <c:if test="${not empty responseValues}">
                    <div class="col-lg-4 col-md-4">
                        <div class="card">
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${responseValues.getResponseCode().startsWith('1')}">
                                        <h1>Code: <h2><span
                                                class="btn-primary">${responseValues.getResponseCode()}</span></h2>
                                        </h1>
                                    </c:when>
                                    <c:when test="${responseValues.getResponseCode().startsWith('2')}">
                                        <h1>Code: <h2><span
                                                class="btn-success">${responseValues.getResponseCode()}</span></h2>
                                        </h1>
                                    </c:when>
                                    <c:when test="${responseValues.getResponseCode().startsWith('3')}">
                                        <h1>Code: <h2><span class="btn-info">${responseValues.getResponseCode()}</span>
                                        </h2>
                                        </h1>
                                    </c:when>
                                    <c:when test="${responseValues.getResponseCode().startsWith('4')}">
                                        <h1>Code: <h2><span
                                                class="btn-danger">${responseValues.getResponseCode()}</span></h2>
                                        </h1>
                                    </c:when>
                                    <c:when test="${responseValues.getResponseCode().startsWith('5')}">
                                        <h1>Code: <h2><span
                                                class="btn-danger">${responseValues.getResponseCode()}</span></h2>
                                        </h1>
                                    </c:when>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">
                                    <div class="title">Request Headers
                                        <small> (${requestHeaders.size()})</small>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:forEach items="${requestHeaders}" var="entry">
                                    <ul>
                                        <li><b>${entry.key}:</b> ${entry.value}
                                        </li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">
                                    <div class="title">Response Headers
                                        <small> (${responseHeaders.size()})</small>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:forEach items="${responseHeaders}" var="entry">
                                    <ul>
                                        <li><b>${entry.key}:</b> ${entry.value}
                                        </li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">
                                    <div class="title">General Info
                                        <small> (${generalInfo.size()})</small>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <c:forEach items="${generalInfo}" var="entry">
                                    <ul>
                                        <li><b>${entry.key}:</b> ${entry.value}
                                        </li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="card">
                        <div class="card-header">
                            <div class="card-title">
                                <div class="title">Response</div>
                            </div>
                            <div class="card-body">
                                <textarea id="codeViewer">
                                        ${response}
                                </textarea>
                            </div>
                        </div>
                    </div>
                </div>
                </c:if>
            </div>
        </div>
        <script>
            "use strict";
            var codeMirror = CodeMirror.fromTextArea(document.getElementById("codeViewer"), {
                lineNumbers: true,
                readOnly: true,
                autofocus: false,
                mode: "application/json"
            });
            function autoFormat() {
                var totalLines = codeMirror.lineCount();
                var totalChars = codeMirror.getTextArea().value.length;
                codeMirror.autoFormatRange({line: 0, ch: 0}, {line: totalLines, ch: totalChars});
            }
            autoFormat();
            codeMirror.scrollTo(0, 0);
        </script>
    </jsp:body>
</t:masterpage>
