<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffPromoCreate.aspx.cs" Inherits="Assignment.staffPromoCreate" %>

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
            width: 80%;
            margin: 2% 10% 5% 10%;
        }

        .label {
            font-size: 25px;
            width: 30%;
        }

        .input {
            border-radius: 10px;
            width: 65%;
            font-size: 15px;
            text-align: center;
            transition: all 0.5s ease-out;
        }

            .input:hover {
                transform: scale(1.1);
                border: 3px solid rgba(0, 0, 255, 0.6);
                transition: all 0.5s ease-out;
            }

        .list {
            width: 45%;
            border: 2px solid black;
            border-radius: 10px;
            font-size: 20px;
            margin-top: 3%;
            margin-bottom: 2%;
            text-align: center;
            transition: all 0.5s ease-out;
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
            width: 20%;
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
            width: 20%;
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
            border: 2px solid black;
            width: 40%;
            font-size: 16px;
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
            padding: 8px 4px;
        }

        .btnBack {
            margin-left: -10%;
            margin-right: 8%;
        }


        .auto-style5 {
            width: 110px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div cssclass="content">
        <table class="table">
            <tr>
                <th colspan="2" class="auto-style3">
                    <asp:LinkButton CssClass="btnBack" ID="btnBack" runat="server" OnClientClick='window.location.replace("/staffPromoCode.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>

                    <asp:Label CssClass="staffTitle" ID="lblStaffTitle" runat="server" Text="Promo Registration Form"></asp:Label>

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
                    <asp:TextBox CssClass="input" ID="txtName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtName" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>               
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtName" ErrorMessage="Promo Code only can accept 3-12 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{3,12}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblDiscount" runat="server" Text="Discount Rate: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="txtDiscount" runat="server"></asp:TextBox>
                    %
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Discount Rate cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Rate only can contains 1-100" ControlToValidate="txtDiscount" Text="*" Type="Integer" MaximumValue="100" MinimumValue="1" ForeColor="Red"></asp:RangeValidator>

                </td>
            </tr>


            <tr>
                <td colspan="2">
                    <br />
                    <asp:Button CssClass="btnAdd" ID="btnStaffAdd" runat="server" Text="Add" OnClick="btnEventAdd_Click" />
                    &nbsp;<asp:Button CssClass="btnReset" ID="btnEventReset" runat="server" OnClick="btnEventReset_Click" OnClientClick='window.location.replace("/staffPromoCreate.aspx");return false;' Text="Reset" />
                    <br />
                    <asp:ValidationSummary ShowMessageBox="true" ShowSummary="false" ForeColor="Red" runat="server" ID="validationSummary"></asp:ValidationSummary>
                    <br />
                </td>
            </tr>
        </table>

    </div>
</asp:Content>
