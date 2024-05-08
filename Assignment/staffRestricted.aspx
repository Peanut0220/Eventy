<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffRestricted.aspx.cs" Inherits="Assignment.staffRestricted" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .center{
            text-align:center;
            vertical-align:middle;
            margin-top:20%;
         
        }
    </style>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="center">
        <i class="fa fa-ban" aria-hidden="true" style="color:Red;font-size:36px;"></i>
        <h1> You are Not Allowed to view this page!</h1>
    </div>
    
</asp:Content>
