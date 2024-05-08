<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberLogin.aspx.cs" Inherits="Assignment.memberLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }

        body {
            margin: 0;
            padding: 0;
            background-image: linear-gradient(rgba(0, 0, 0, 0.527),rgba(0, 0, 0, 0.5)), url("images/memberLogin.jpg");
            background-size: cover;
            height: 100vh;
            overflow: hidden;
            animation: fadeIn 3s;
            font-family: "Kanit";
        }

        .center {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%,-50%);
            width: 400px;
            background: #1F1B1D;
            border-radius: 40px;
            padding: 20px;
        }

            .center h1 {
                text-align: center;
                padding: 0 0 20px 0;
                font-weight: lighter;
                color: white;
            }

        form .txt_field {
            position: relative;
            border-bottom: 2px solid #adadad;
            margin: 30px 0;
        }

        .input {
            width: 100%;
            padding: 0 5px;
            height: 40px;
            font-size: 16px;
            border: none;
            background: none;
            outline: none;
            color: white;
        }

            .input:hover ~ .label,
            .input:focus ~ .label {
                color: blue;
            }

        .label {
            position: absolute;
            top: 50%;
            left: 5px;
            color: white;
            transform: translateY(-50%);
            font-size: 16px;
            pointer-events: none;
            transition: .5s;
            top: -5px;
        }

        .logo {
            padding: 20px;
        }

        .forgot {
            font-size: 13px;
            text-decoration: none;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        .pass {
            margin: 0px 0px 15px 0px;
            color: white;
            cursor: pointer;
            display: inline-block;
        }

        .forgot:hover {
            text-decoration: none;
            color: #0E399E;
            transition: all 0.3s ease-in-out;
        }

        .button {
            width: 100%;
            height: 30px;
            border: 3px solid #1F1B1D;
            background: #0E399E;
            border-radius: 25px;
            font-size: 18px;
            color: #e9f4fb;
            font-weight: 700;
            cursor: pointer;
            outline: none;
            transition: all 0.3s;
            display:block;
            text-decoration:none;
            text-align:center;
          padding:10px 0px 10px 0;
        }
     
            .button:hover {
                border-color: #0E399E;
                transition: all 0.3s;
            }

        .signup_link {
            margin-top:20px;
            text-align: center;
            font-size: 16px;
            color: #666666;
        }

        .register {
            color: #2691d9;
            text-decoration: none;
            transition: all 0.3s ease-in-out;
        }

            .register:hover {
                text-decoration: none;
                color: #0E399E;
                transition: all 0.3s ease-in-out;
            }

        i {
            position: absolute;
            color: white;
            right: 0%;
            top: 40%;
            cursor: pointer;
        }

        .switch {
            text-align: center;
            border: 0px;
            background-color: transparent;
            color: #2691d9;
            transition: all 0.3s ease-in-out;
            margin-top:10px;
        }

            .switch:hover {
                color: #0E399E;
            }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
</head>
<body>
  


        
        <form id="form1" runat="server" DefaultButton="LinkButton1">
             <asp:ImageButton ID="logo" runat="server" Height="98px" ImageUrl="~/images/logo.png" Width="252px" CssClass="logo" PostBackUrl="~/userHome.aspx" />
                <div class="center">
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                <asp:View ID="View1" runat="server">
                    <h1>MEMBER LOGIN</h1>
                    <div class="txt_field">
                        <asp:TextBox CssClass="input" ID="TextBox1" runat="server"></asp:TextBox>

                        <asp:Label CssClass="label" ID="Label1" runat="server" Text="Email"></asp:Label>
                    </div>
                    <div class="txt_field">
                        <asp:TextBox CssClass="input" TextMode="Password" ID="TextBox2" runat="server"></asp:TextBox>
                        <asp:Label CssClass="label" ID="Label2" runat="server" Text="Password"></asp:Label><i id="icon" class="fa-solid fa-eye" onclick="myFunction()"></i>

                    </div>
                    <div class="pass">
                        <asp:HyperLink CssClass="forgot" ID="HyperLink1" runat="server" NavigateUrl="~/resetPass.aspx">Forgot Password?</asp:HyperLink>
                    </div>
                    <asp:LinkButton CssClass="button" ID="LinkButton1" runat="server"  OnClick="LinkButton1_Click" >Login</asp:LinkButton>
            
                    <div class="signup_link">
                        Not a member?
                    <asp:HyperLink CssClass="register" ID="HyperLink2" runat="server" NavigateUrl="~/memberRegister.aspx">Register Now</asp:HyperLink>
                    </div>

                    <div class="switch">
                        <asp:Button CssClass="switch" ID="Button3" runat="server" Text="Switch to Staff Login" OnClick="Button3_Click" />
                    </div>
                </asp:View>
                <asp:View ID="View2" runat="server">
                    <h1>STAFF LOGIN</h1>
                    <div class="txt_field">
                        <asp:TextBox CssClass="input" ID="TextBox3" runat="server"></asp:TextBox>

                        <asp:Label CssClass="label" ID="Label3" runat="server" Text="Email"></asp:Label>
                    </div>
                    <div class="txt_field">
                        <asp:TextBox CssClass="input" TextMode="Password" ID="TextBox4" runat="server"></asp:TextBox>
                        <asp:Label CssClass="label" ID="Label4" runat="server" Text="Password"></asp:Label><i id="icon" class="fa-solid fa-eye" onclick="myFunction1()"></i>

                    </div>
                    <div class="pass">
                        <asp:HyperLink CssClass="forgot" ID="HyperLink3" runat="server" NavigateUrl="~/resetPass.aspx">Forgot Password?</asp:HyperLink>
                    </div>
                    <asp:LinkButton CssClass="button" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">Login</asp:LinkButton>
                    <div class="switch">
                        <asp:Button CssClass="switch" ID="Button4" runat="server" Text="Switch to Member Login" OnClick="Button4_Click"  />
                    </div>
                </asp:View>
            </asp:MultiView>





</div>
        </form>
    
    <script>
        function myFunction() {
            var x = document.getElementById("TextBox2");
            var i = document.getElementById("icon");
            if (x.type === "password") {
                x.type = "text";
                i.className = "fa-solid fa-eye-slash";
            } else {
                x.type = "password";
                i.className = "fa-solid fa-eye";
            }
        }
        function myFunction1() {
            var x = document.getElementById("TextBox4");
            var i = document.getElementById("icon");
            if (x.type === "password") {
                x.type = "text";
                i.className = "fa-solid fa-eye-slash";
            } else {
                x.type = "password";
                i.className = "fa-solid fa-eye";
            }
        }

      

        
    </script>
</body>
</html>
