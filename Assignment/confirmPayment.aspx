<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="confirmPayment.aspx.cs" Inherits="Assignment.confirmPayment" %>
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
        color:yellow;
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
         color:yellow;
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
     padding: 20px ;
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
       
      
                  <div class="container">
          <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
            <asp:Label CssClass="word" ID="Label1" runat="server" Text="One More Steps!"></asp:Label>


<asp:LinkButton CssClass="btn" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Confirm Purchase</asp:LinkButton>
                      
      </div>
    
      
    </form>
</body>
</html>

