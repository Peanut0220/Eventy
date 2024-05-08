<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="memberPaymentMessage.aspx.cs" Inherits="Assignment.memberPaymentMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.css" />
    <style>
        @keyframes fadeIn {
     0% {
         opacity: 0;
     }

     100% {
         opacity: 1;
     }
 }

               @keyframes changeColor {
    0% {
       color:white;
    }

    100% {
        color:green;
    }
}

                              @keyframes slidein {
    0% {
      transform: translateX(-500px);
    }

    100% {
        transform: translateX(0);
    }
}

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            box-sizing: border-box;
            font-family: "Kanit";
        }



        body {
            color: white;
            line-height: 1.4;
            background-color:#151515;
            animation: 1.5s fadeIn;
        }

        .container{
            margin:15% 8% 0% 8%;
            text-align:center;
            animation: 1.5s slidein;
        }
       
       .fa{
         animation :3s changeColor;
         color:green;
           font-size:70px;
           display:block;
       }
        
       .word{
           font-size:70px;
           display:block;
       }
          .word1{
       font-size:40px;
       display:block;
   }
                 .word2{
    font-size:20px;
    display:block;
}

                 .word3{
                       font-size:15px;
  display:block;
                 }
                  .btn {
                      margin:30px auto 0 auto;
  display:block;
     border-radius: 15px;
     border: 0;
     letter-spacing: 1px;
     color: #fff;
     background: black;
     padding: 20px 60px;
     white-space: nowrap;
     font-size: 16px;
     line-height: 1;
     width:20%;
     text-align:center;
     text-transform: uppercase;
     transition: all 0.3s ease;
     text-decoration: none;
     margin-bottom:10px;
 }

 

     .btn:hover {
         -webkit-transform: translateY(-2px);
         transform: translateY(-2px);
         background: #232323;
         transition: all 0.3s ease;
     }
    </style>
      
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Payment] WHERE ([paymentID] = @paymentID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="paymentID" QueryStringField="paymentID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                  <div class="container">
          <i class="fa fa-check-circle"></i>
            <asp:Label CssClass="word" ID="Label1" runat="server" Text="Payment Done"></asp:Label>
          <asp:Label CssClass="word1" ID="Label2" runat="server" Text="Enjoy The Event !"></asp:Label>
          <asp:Label CssClass="word2" ID="Label3" runat="server" Text='<%#"Payment ID: "+Eval("paymentID") %>'></asp:Label>

<asp:LinkButton CssClass="btn" ID="LinkButton1" runat="server" PostBackUrl="~/memberEvent.aspx">Done</asp:LinkButton>
                       <asp:Label CssClass="word3" ID="Label4" runat="server" Text="Check Your Email For The Payment Receipt"></asp:Label>
      </div>
      </ItemTemplate>
        </asp:Repeater>
      
    </form>
</body>
</html>
