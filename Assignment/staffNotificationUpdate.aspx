<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffNotificationUpdate.aspx.cs" Inherits="Assignment.staffNotificationUpdate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <style>
        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }


        body {
            font-family: Impact;
        }


        .staffTitle {
            font-size: 40px;
            text-align: center;
            width: 100%;
        }

        .table {
            width: 60%;
            margin: 2% 15% 5% 20%;
        }

        .label {
            font-size: 25px;
            width: 20%;
            margin-left: 5%;
        }

        .input {
            border-radius: 10px;
            width: 65%;
            transition: all 0.5s ease-out;
            font-size: 20px;
            text-align: center;
        }

            .input:hover {
                transform: scale(1.1);
                border: 3px solid rgba(0, 0, 255, 0.6);
                transition: all 0.5s ease-out;
            }

        .list {
            width: 30%;
            border-radius: 10px;
        }

        tr, td {
            padding: 1%;
            color: black;
        }

        th {
            border-bottom: 2px dotted;
            border-color: rgba(0, 0, 255, 0.6);
        }


        .btnUpdate {
            margin-left: 32%;
            cursor: pointer;
            color: black;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 17px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
            width: 17%;
            margin-bottom: 5%;
        }

            .btnUpdate:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }



        .auto-style3 {
            height: 80px;
        }

        .auto-style4 {
            height: 9px;
        }



        .rbl {
            width: 40%;
            font-size: 20px;
        }

        h1 {
            position: relative;
            margin-left: 40px;
            margin-right: 10px;
            font-size: 40px;
        }



        table {
            width: 95%;
            border-collapse: collapse;
            margin-top: 2%;
            margin-left: auto;
            margin-right: auto;
            font-size: 1.0em;
            border-radius: 5px 5px 0 0;
            overflow: hidden;
            /* text-align: center;*/
        }

        .table-content thead tr {
            background-color: #112363;
            color: #ffffff;
            text-align: left;
            font-size: 16px;
            text-align: center;
        }

        .table-content th, td {
            padding: 12px 15px;
        }

        .btnBack {
            margin-left: -10%;
            margin-right: 8%;
        }


        .auto-style5 {
            width: 40%;
            font-size: 20px;
            margin-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div cssclass="content">
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Notification] WHERE ([notifyID] = @notifyID)">
         <SelectParameters>
             <asp:QueryStringParameter Name="notifyID" QueryStringField="notifyID" Type="Int32" />
         </SelectParameters>
     </asp:SqlDataSource>
     <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
         <HeaderTemplate>
             <table class="table">
         </HeaderTemplate>
         <ItemTemplate>
             <tr>
                 <th colspan="2" class="auto-style3">
                     <asp:LinkButton CssClass="btnBack" ID="btnBack" runat="server" OnClientClick='window.location.replace("/staffNotification.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>

                     <asp:Label CssClass="staffTitle" ID="lblStaffTitle" runat="server" Text="Notification Update Form"></asp:Label>

                 </th>
             </tr>
             <tr>
                 <td colspan="2" class="auto-style4"></td>
             </tr>
             <tr>
                 <td>
                     <asp:Label CssClass="label" ID="lblTitle" runat="server" Text="Title : "></asp:Label>
                     <asp:Label CssClass="label" ID="Label1" runat="server" Style="display: none;" Text='<%#Eval("notifyID") %>'></asp:Label>
                     <asp:Label CssClass="label" ID="Label2" runat="server" Style="display: none;" Text='<%#Eval("title") %>'></asp:Label>

                 </td>
                 <td>
                     <asp:TextBox CssClass="input" ID="txtTitle" runat="server" Text='<%#Eval("title") %>'></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title only can accept 5-50 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&%,#.\s]{5,50}$" Text="*"></asp:RegularExpressionValidator>
                    
                 </td>
             </tr>
             <tr>
                 <td>
                     <asp:Label CssClass="label" ID="lblDesc" runat="server" Text="Description: "></asp:Label>
                 </td>
                 <td>
                     <asp:TextBox CssClass="input" ID="txtDesc" runat="server" TextMode="MultiLine" Text='<%#Eval("description") %>'></asp:TextBox> 
               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDesc" ErrorMessage="Description cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDesc" ErrorMessage="Description only can accept 10-100 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@%,&#.\s]{10,100}$" Text="*"></asp:RegularExpressionValidator>

                 </td>
             </tr>


             <tr>
                 <td colspan="2">
                     <br />
                     <asp:Button CssClass="btnUpdate" ID="btnStaffAdd" runat="server" Text="Update" OnClick="btnEventUpdate_Click" />
                     <br />
        <asp:validationsummary showmessagebox="true" showsummary="false" forecolor="Red" runat="server" id="validationSummary">
</asp:validationsummary>                       <br />
                 </td>
             </tr>
         </ItemTemplate>
         <FooterTemplate>
             </table>
         </FooterTemplate>

     </asp:Repeater>
 </div>
</asp:Content>
