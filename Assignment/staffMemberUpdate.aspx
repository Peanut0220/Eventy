<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffMemberUpdate.aspx.cs" Inherits="Assignment.staffMemberUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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
            margin-left: 10%;
        }

        .input {
            border-radius: 10px;
            font-size: 20px;
            text-align: center;
            width: 65%;
            transition: all 0.5s ease-out;
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
            padding: 2%;
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

        .table-content td {
            padding: 12px 15px;
        }

        .table-content th {
            padding: 12px 10px;
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div cssclass="content">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <HeaderTemplate>
                <table class="table">
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <th colspan="2">
                        <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" OnClientClick='window.location.replace("/staffMember.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>
                        <asp:Label CssClass="staffTitle" ID="lblMemberTitle" runat="server" Text="Member Update Form"></asp:Label>

                    </th>
                </tr>
                <tr>
                    <td colspan="2" class="auto-style4"></td>
                </tr>
                <tr>
                    <td class="auto-style5">

                        <asp:Label CssClass="label" ID="lblMemberName" runat="server" Text="Name : "></asp:Label>
                        <asp:Label CssClass="label" ID="Label1" runat="server" Style="display: none;" Text='<%#Eval("memberID") %>'></asp:Label>

                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtMemberNameUpdate" runat="server" Text='<%# Eval("name")%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMemberNameUpdate" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtMemberNameUpdate" ErrorMessage="Name only can accept 5-20 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{5,20}$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:Label CssClass="label" ID="lblIC" runat="server" Text="IC(without '-') : "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtIC" runat="server" Text='<%# Eval("IC")%>' Enabled="false"></asp:TextBox>
                        <asp:Label CssClass="label" ID="Label4" runat="server" Style="display: none;" Text='<%#Eval("IC") %>'></asp:Label>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtIC" ErrorMessage="IC cannot be empty" ForeColor="Red" Text="<br/>IC cannot be empty"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtIC" ErrorMessage="IC only can accept only 12 digit" ForeColor="Red" ValidationExpression="^\d{12}$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">

                        <asp:Label CssClass="label" ID="lblMemberPhoneNo" runat="server" Text="Phone No : "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtMemberPhoneNoUpdate" runat="server" Text='<%# Eval("phoneNo")%>'></asp:TextBox>
                        <asp:Label CssClass="label" ID="Label2" runat="server" Style="display: none;" Text='<%#Eval("phoneNo") %>'></asp:Label>

                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMemberPhoneNoUpdate" ErrorMessage="Phone No cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtMemberPhoneNoUpdate" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>

                        &nbsp;

                    </td>
                </tr>
                <tr>
                    <td class="auto-style5">
                        <asp:Label CssClass="label" ID="lblMemberEmail" runat="server" Text="Email : "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtMemberEmailUpdate" runat="server" Text='<%# Eval("email")%>' Enabled="false"></asp:TextBox>
                        <asp:Label CssClass="label" ID="Label3" runat="server" Style="display: none;" Text='<%#Eval("email") %>'></asp:Label>

                      
                    </td>
                </tr>

                <tr>
                    <td class="auto-style5">
                        <asp:Label CssClass="label" ID="lblAddress" runat="server" Text="Address : "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtAddress" runat="server" Text='<%# Eval("address")%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address only can accept 10-250 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&,#.\s]{10,250}$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>

                <tr>
                    <td class="auto-style5">
                        <asp:Label CssClass="label" ID="lblEmergencyContact" runat="server" Text="Emergency Contact : "></asp:Label>
                    </td>
                    <td class="auto-style6">
                        <asp:TextBox CssClass="input" ID="txtEmergencyContact" runat="server" Text='<%# Eval("emergencyContact")%>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEmergencyContact" ErrorMessage="Emergency Contact cannot be empty" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtEmergencyContact" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>

                    </td>
                </tr>


            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>

        </asp:Repeater>
        <asp:Button CssClass="btnUpdate" ID="btnStaffUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
        <asp:validationsummary showmessagebox="true" showsummary="false" forecolor="Red" runat="server" id="validationSummary">
</asp:validationsummary>  
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Member] WHERE ([memberID] = @memberID)">
            <SelectParameters>
                <asp:QueryStringParameter Name="memberID" QueryStringField="memberID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>


