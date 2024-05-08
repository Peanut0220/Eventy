<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberRegister.aspx.cs" Inherits="Assignment.memberRegister" %>

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
            background-image: linear-gradient(rgba(0, 0, 0, 0.527),rgba(0, 0, 0, 0.5)), url("images/staffLogin.jpg");
            background-size: cover;
            height: 130vh;
            overflow: hidden;
            animation: fadeIn 3s;
            font-family: "Kanit";
        }

        .sentence {
            color: white;
            position: absolute;
            top: 40%;
            left: 5%;
            margin-left: auto;
            margin-right: auto;
            display: block;
            word-wrap: break-word;
        }

            .sentence > h1 {
                font-weight: lighter;
            }

                .sentence > h1 > span {
                    font-size: 50px;
                }

            .sentence > h3 {
                font-weight: lighter;
            }

        .right {
            margin-left: auto;
            margin-right: auto;
            display: block;
            position: absolute;
            top: 50%;
            left: 80%;
            transform: translate(-50%,-50%);
            width: 400px;
            background-color: transparent;
            border-radius: 40px;
            padding: 30px;
        }

            .right h1 {
                text-align: center;
                padding: 0 0 20px 0;
                font-weight: lighter;
                color: white;
                padding: 0 20px 0 20px;
                box-sizing: border-box;
                margin: 20px 0px 20px 0px;
            }

        .txt_field {
            position: relative;
            border-bottom: 2px solid #adadad;
            margin-top: 30px;
            margin-bottom: 5px;
            margin-left: 0px;
            margin-right: 0px;
        }

            .txt_field input {
                width: 80%;
                padding: 0 5px;
                height: 40px;
                font-size: 16px;
                border: none;
                background: none;
                outline: none;
                color: white;
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

        .input::placeholder {
            opacity: 0;
            transition: all 0.5s;
        }

        .input:focus::placeholder,
        .input:hover::placeholder {
            transition: all 1s;
            opacity: 1;
        }

        .input:hover ~ .label,
        .input:focus ~ .label {
            color: blue;
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
            display: block;
            text-decoration: none;
            text-align: center;
            padding: 10px 0px 10px 0;
            margin-top: 15px;
        }

            .button:hover {
                background: #0F1E69;
                transition: all 0.3s;
            }

        i {
            position: absolute;
            color: white;
            right: 0%;
            top: 40%;
            cursor: pointer;
        }

        .signup_link {
            margin: 5px 0;
            text-align: center;
            font-size: 14px;
            color: #666666;
        }

        .a {
            color: #2691d9;
            text-decoration: none;
            transition: all 0.3s ease-in-out;
        }

            .a:hover {
                text-decoration: none;
                color: #0E399E;
                transition: all 0.3s ease-in-out;
            }

        .logo {
            padding: 20px;
        }

        .pass {
            margin: 0px 0px 15px 0px;
            color: white;
            cursor: pointer;
            display: inline-block;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
</head>
<body>


    <form id="form1" runat="server" defaultbutton="LinkButton1">
        <asp:ImageButton ID="logo" runat="server" Height="98px" ImageUrl="~/images/logo.png" Width="252px" CssClass="logo" PostBackUrl="~/userHome.aspx" />
        <div class="sentence">
            <h1>JOIN OUR COMMUNITY NOW TO OBTAIN YOUR
                <br />
                ACCOUNT </h1>
            <h3>Any kind of events are all over here on Eventy.
                <br />
                Connect with us and use this event platform start from now.</h3>
        </div>
        <div class="right">

            <h1>Join The Community</h1>

            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="TextBox1" runat="server"></asp:TextBox>
            

                <asp:Label CssClass="label" ID="Label1" runat="server" Text="Name"></asp:Label>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="TextBox1" ErrorMessage="Name only can accept 5-20 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{5,20}$" Text="*"></asp:RegularExpressionValidator>



            </div>


            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="TextBox2" runat="server"></asp:TextBox>
           
                <asp:Label CssClass="label" ID="Label2" runat="server" Text="Email"></asp:Label>

         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2" ErrorMessage="Email cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
 <asp:regularexpressionvalidator id="RegularExpressionValidator1" errormessage="Email must include '@' and '.'" Text="*" ForeColor="Red" controltovalidate="TextBox2" runat="server" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
             </asp:regularexpressionvalidator>
            </div>


            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="TextBox3" runat="server"></asp:TextBox>
            
                <asp:Label CssClass="label" ID="Label3" runat="server" Text="IC"></asp:Label>
<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox3" ErrorMessage="IC cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox3" ErrorMessage="IC only can accept only 12 digit" ForeColor="Red" ValidationExpression="^\d{12}$" Text="*"></asp:RegularExpressionValidator>
     

            </div>
               <div class="txt_field">
       <asp:TextBox CssClass="input" ID="TextBox5" runat="server"></asp:TextBox>
  
       <asp:Label CssClass="label" ID="Label5" runat="server" Text="Phone No"></asp:Label>
<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox5" ErrorMessage="Phone No cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox5" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>


   </div>
            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="TextBox6" runat="server"></asp:TextBox>
            
                <asp:Label CssClass="label" ID="Label6" runat="server" Text="Emergency Contact"></asp:Label>
<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox6" ErrorMessage="Emergency Contact cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="TextBox6" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>
    

            </div>

         
            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="TextBox7" runat="server"></asp:TextBox>
                 
                <asp:Label CssClass="label" ID="Label7" runat="server" Text="Address"></asp:Label>
   <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox7" ErrorMessage="Address cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="TextBox7" ErrorMessage="Address only can accept 20-100 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@,&#.\s]{20,100}$" Text="*"></asp:RegularExpressionValidator>


            </div>




            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="password" TextMode="Password" runat="server"></asp:TextBox>
               <asp:Label CssClass="label" ID="Label4" runat="server" Text="Password"></asp:Label><i id="icon" class="fa-solid fa-eye " onclick="myFunction()"></i>
      <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="password" ErrorMessage="Password cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
      <asp:regularexpressionvalidator id="RegularExpressionValidator4" errormessage="Password must be between 6 and 20 characters and contain one uppercase letter, one lowercase letter, one digit and one special character." Text="*" ForeColor="Red" controltovalidate="password" runat="server" validationexpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$">
             </asp:regularexpressionvalidator>          
            </div>
            <div class="txt_field">
                <asp:TextBox CssClass="input" ID="confirmPassword" TextMode="Password" runat="server"></asp:TextBox>

                <asp:Label CssClass="label" ID="Label8" runat="server" Text="Confirm Password"></asp:Label><i id="icon1" class="fa-solid fa-eye " onclick="myFunction1()"></i>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="confirmPassword" ErrorMessage="Password cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>

            </div>

            <asp:LinkButton CssClass="button" ID="LinkButton1" runat="server" OnClientClick="return confirmSubmit()" OnClick="LinkButton1_Click" >Submit</asp:LinkButton>
             <asp:validationsummary showmessagebox="true" showsummary="false" forecolor="Red" runat="server" id="validationSummary">
             </asp:validationsummary>
            <div class="signup_link">
                Already have an Account?
                <asp:HyperLink CssClass="a" ID="HyperLink1" runat="server" NavigateUrl="~/memberLogin.aspx">Back to Login</asp:HyperLink>
            </div>
        </div>
    </form>
    <script>
        function myFunction() {
            var x = document.getElementById("password");

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

            var y = document.getElementById("confirmPassword");

            var j = document.getElementById("icon1");

            if (y.type === "password") {
                y.type = "text";
                j.className = "fa-solid fa-eye-slash";
            } else {
                y.type = "password";
                j.className = "fa-solid fa-eye";
            }
        }


        function confirmSubmit() {
            var x = document.getElementById('<%=password.ClientID%>');
            var y = document.getElementById('<%=confirmPassword.ClientID%>');
            if (x.value == y.value) {

                return true;
            } else {
                alert("Password and Confirm Password should be the same!");
                return false;
            }




        }
    </script>
</body>
</html>
