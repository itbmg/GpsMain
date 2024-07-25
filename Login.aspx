<%@ Page Title="" Language="C#" MasterPageFile="~/LoginMaster.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(window).load(function () {
            $('#slider').nivoSlider();
        });
    </script>
    <style type="text/css">
        .foc
        {
            background:#ffffff !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="login" class="animate form">
        <br />
        <br />
        <br />
        <br />
        <h1>
            Log in</h1>
        <p>
            <label for="username" class="uname" data-icon="u">
                Your email or username
            </label>
            <asp:TextBox name="txtUserName" CssClass="foc"  type="text" ID="txtUserName" runat="server" placeholder="Enter Username" Text="" /><%--Text="vyshnavi"--%>
        </p>
        <p>
            <label for="password" class="youpasswd" data-icon="p">
                Your password
            </label>
            <asp:TextBox name="txtPassword" CssClass="foc" type="text" TextMode="password" runat="server" ID="txtPassword" placeholder="Enter Password" Text="" /><%--Text="vyshnavi@it"--%>
        </p>
        <div class="login_row">
            &nbsp;
            <p class="login button">
                <asp:Button ID="Button1" runat="server" CssClass="login button" OnClick="btnLogIn_Click"
                    Text="Login" />
            </p>
            <asp:Label Text="" runat="server" ID="lbl_validation"></asp:Label>
           <%-- <p class="change_link" TextMode="password">
                <a href="ForgetPassWord.aspx" class="to_register">Forget PassWord</a>
            </p>--%>
            <br />
            <br />


             <div >
               <a target="_blank" href='https://play.google.com/store/apps/details?id=io.cordova.myapp5ab0bd'><img alt='Get it on Google Play' style="width:210px;height:85px;" src="Images/googleplay.png" /></a>
                </div>
                <marquee ><a href="http://49.50.65.161/vyshnaviwebsite/" > <b  style="font-size:22px;color:White;"> Click Here for Beta version</b></a></marquee>
        </div>
    </div>
</asp:Content>
