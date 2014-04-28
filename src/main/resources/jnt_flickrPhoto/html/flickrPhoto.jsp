<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<jcr:nodeProperty node="${currentNode}" name="title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="photoURL" var="photoURL"/>

<c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:file')}" var="subnode">
    <c:if test="${subnode.name == 'binary'}">
        <c:set value="${subnode}" var="binary"/>
    </c:if>
</c:forEach>

<h2>${title.string}</h2>
<c:set value="${photoURL.string}" var="url"/>

<c:if test="${not empty binary}">
    <c:set value="${binary.url}" var="url"/>
</c:if>

<img src="${url}" alt="${title.string}" width="100%"/>
