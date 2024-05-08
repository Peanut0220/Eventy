<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffCreate.aspx.cs" Inherits="Assignment.staffCreate" %>

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
            font-size: 20px;
            text-align: center;
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
            padding: 1%;
            color: black;
        }

        th {
            border-bottom: 2px dotted;
            border-color: rgba(0, 0, 255, 0.6);
        }


        .btnAdd {
            margin-left: 28%;
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
        }

            .btnAdd:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .btnReset {
            width: 15%;
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
            margin-left: 7%;
        }

            .btnReset:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: white;
            }

        .btnUpload {
            width: 17%;
            margin-left: 5%;
            cursor: pointer;
            color: black;
            background-color: transparent;
            border: 3px rgba(0, 0, 255, 0.6) solid;
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 13px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
        }

            .btnUpload:hover {
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

        .upload {
            border-radius: 10px;
            border: 2px solid lightgrey;
            width: 65%;
        }

            .upload:hover {
                border-color: rgba(0, 0, 255, 0.6);
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
        <table class="table">
            <tr>
                <th colspan="2" class="auto-style3">
                    <asp:LinkButton CssClass="btnBack" ID="btnBack" runat="server" OnClientClick='window.location.replace("/staff.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>

                    <asp:Label CssClass="staffTitle" ID="lblStaffTitle" runat="server" Text="Staff Registration Form"></asp:Label>

                </th>
            </tr>
            <tr>
                <td colspan="2" class="auto-style4"></td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblStaffName" runat="server" Text="Name : "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="txtStaffName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStaffName" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtStaffName" ErrorMessage="Name only can accept 5-20 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{5,20}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="kbkStaffIC" runat="server" Text="IC(without '-' ) : "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="txtStaffIC" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtStaffIC" ErrorMessage="IC cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtStaffIC" ErrorMessage="IC only can accept only 12 digit" ForeColor="Red" ValidationExpression="^\d{12}$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>

                    <asp:Label CssClass="label" ID="lblStaffPhoneNo" runat="server" Text="Phone No : "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="txtStaffPhoneNo" runat="server"></asp:TextBox>

                    &nbsp;

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtStaffPhoneNo" ErrorMessage="Phone No cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtStaffPhoneNo" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblStaffEmail" runat="server" Text="Email : "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="txtStaffEmail" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtStaffEmail" ErrorMessage="Email cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ErrorMessage="Email must include '@' and '.'" Text="*" ForeColor="Red" ControlToValidate="txtStaffEmail" runat="server" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblStaffRole" runat="server" Text="Role : "></asp:Label>
                </td>
                <td>
                    <asp:RadioButtonList CssClass="auto-style5" ID="rblStaffRole" runat="server">
                        <asp:ListItem>Staff</asp:ListItem>
                        <asp:ListItem>Manager</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="rblStaffRole" ErrorMessage="Role cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="lblStaffJoinedDate" runat="server" Text="Joined Date : "></asp:Label>
                </td>
                <td class="auto-style6">
                    <asp:TextBox CssClass="input" ID="txtDate" runat="server" Enabled="False" OnTextChanged="txtDate_TextChanged"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="lblStaffAddress" runat="server" Text="Address : "></asp:Label>
                </td>
                <td class="auto-style6">
                    <asp:TextBox CssClass="input" ID="txtStaffAddress" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtStaffAddress" ErrorMessage="Address cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtStaffAddress" ErrorMessage="Address only can accept 20-250 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#,.\s]{20,250}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>



            <tr>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="lblStaffEmergencyContact" runat="server" Text="Emergency Contact : "></asp:Label>
                </td>
                <td class="auto-style6">
                    <asp:TextBox CssClass="input" ID="txtStaffEmergencyContact" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtStaffEmergencyContact" ErrorMessage="Emergency Contact cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtStaffEmergencyContact" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <br />
                    <asp:Button CssClass="btnAdd" ID="btnStaffAdd" runat="server" Text="Add" OnClick="btnEventAdd_Click" />
                    &nbsp;<asp:Button CssClass="btnReset" ID="btnEventReset" runat="server" OnClick="btnEventReset_Click" OnClientClick='window.location.replace("/staffCreate.aspx");return false;' Text="Reset" />
                    <br />
                    <asp:ValidationSummary ShowMessageBox="true" ShowSummary="false" ForeColor="Red" runat="server" ID="validationSummary"></asp:ValidationSummary>
                    <br />
                </td>
            </tr>
        </table>

    </div>
</asp:Content>

