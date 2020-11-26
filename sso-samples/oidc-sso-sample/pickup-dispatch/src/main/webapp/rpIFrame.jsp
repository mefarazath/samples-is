<%@ page import="org.wso2.sample.identity.oauth2.SampleContextEventListener"%>
<%@ page import="org.wso2.sample.identity.oauth2.OAuth2Constants" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>OpenID Connect Session Management RP IFrame</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<%--    <script src="libs/jquery_3.3.1/jquery.min.js"></script>--%>
    <script language="JavaScript" type="text/javascript">
        var session_id = '<%=session.getAttribute("IDP_SESSION_KEY")%>';
        function check_session() {

            console.log("Refreshing session with session_identifier: "  + session_id);
            if (session_id != null) {
                $.ajax({
                    type: "GET",
                    url: "https://session-test.requestcatcher.com/session_id=" + session_id,
                    success: function (data) {
                        console.log("[RP] IDP session was refreshed")
                    },
                    cache: false
                });
            }
        }

        function setTimer() {
            check_session();
            setInterval("check_session()", 60 * 1000);
        }
    </script>
</head>
<body onload="setTimer()">
<iframe id="opIFrame"
        src="<%=
            SampleContextEventListener.getPropertyByKey(OAuth2Constants.OIDC_SESSION_IFRAME_ENDPOINT)
            + "?"
            + "client_id=" + SampleContextEventListener.getPropertyByKey(OAuth2Constants.CONSUMER_KEY)
            + "&redirect_uri="+ SampleContextEventListener.getPropertyByKey(OAuth2Constants.CALL_BACK_URL)
            %>"
        frameborder="0" width="0"
        height="0"></iframe>
</body>
</html>
