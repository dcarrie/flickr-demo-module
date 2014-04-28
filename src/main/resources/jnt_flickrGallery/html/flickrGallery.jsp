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

<c:if test="${not renderContext.editMode}">
    <template:addResources type="javascript" resources="jquery.min.js,jquery.fancybox.js,jquery.fancybox.load.js"/>
    <template:addResources type="css" resources="jquery.fancybox.css"/>
</c:if>

Whahahaha !!
<h2>${currentNode.properties['jcr:title'].string}</h2>

${currentNode.properties.body.string}

<p>
    <c:forEach items="${flickrGalleryPhotos}" var="pic">
        <c:choose>
            <c:when test="${not renderContext.editMode}">
                <script language = "javascript">
                    function viewDetail_${fn:replace(pic.id, "-", "_")} () {
                        $('#form_${fn:replace(pic.id, "-", "_")}').submit();
                    }
                </script>
                <div style="display:none">
                    <template:tokenizedForm>
                        <form id="form_${fn:replace(pic.id, "-", "_")}" action="${url.base}${currentNode.path}.addPhoto.do" method="post">
                            <input type="hidden" name="photoID" value="${pic.id}"/>
                            <input type="hidden" name="copyPhoto" value="${currentNode.properties.copyPhotosBinary.boolean}"/>
                            <input type="hidden" name="photoTitle" value="${pic.title}"/>
                            <input type="hidden" name="photoURL" value="${pic.url}"/>
                            <input type="hidden" name="jcrRedirectTo" value="${url.base}${currentNode.path}/${pic.id}"/>
                            <input type="hidden" name="jcrNewNodeOutputFormat" value="html"/>

                            <input type="submit" value="OK">
                        </form>
                    </template:tokenizedForm>
                </div>

                <a class="zoom" rel="group"
                   title="${pic.title}  - <strong><a style='color:#FFF' href='javascript:viewDetail_${fn:replace(pic.id, "-", "_")}()'>View details</a></strong>"
                   href="${pic.url}">
                    <c:url value="${pic.thumbnailUrl}" var="imgUrl" />
                    <img src="${imgUrl}" alt="${pic.title}"/>
                </a>
            </c:when>
            <c:otherwise>
                <c:url value="${pic.thumbnailUrl}" var="imgUrl" />
                <img src="${imgUrl}" alt="${pic.title}"/>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</p>
