<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberHome.aspx.cs" Inherits="Assignment.memberHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
           @keyframes fadeIn {
       0% {
           opacity: 0;
       }

       100% {
           opacity: 1;
       }
   }


        body{
            color:white;
           animation:2s fadeIn;

        }
       .content1 {
        padding-top: 5%;
        margin-left: 8%;
        margin-right: 8%;
        padding-bottom:5%;
    }

    .content1 .content-title {
        display: flex;
        justify-content: space-between;
        background: url(images/memberHome.jpg) no-repeat;
        background-position: right;
        background-size: 50% 100%;
        height: 100vh;
    }

    .content-title .main-title h1{
        color: white;
        font-size: 95px;
        width: 50%;
        overflow-wrap: break-word;
        line-height: 95%;
    }

    .content-title .main-title p {
        font-size: 21px;
        width: 45%;
        overflow-wrap: break-word;
        color: rgb(104, 104, 104);
        margin-top: 4.5%;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
      <div class="content">
            <div class="content-background">
                <div class="content1">
                    <div class="content-title">
                        <div class="main-title">
                            <h1>Welcome</h1>
                            <asp:Label ID="lblMemberHomeName" runat="server" Text="Yi Jie" Font-Size="40px"></asp:Label>
                            <p>
                                Lorem ipsum dolor, sit amet consectetur adipisicing elit. Omnis assumenda quas suscipit eaque excepturi 
                                incidunt voluptates exercitationem aliquid architecto odio, officia, perferendis ipsum earum eveniet iure 
                                accusantium ad fugiat porro.Lorem ipsum dolor, sit amet consectetur adipisicing elit.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
      </div>
</asp:Content>
