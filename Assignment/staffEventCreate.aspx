<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="staffEventCreate.aspx.cs" Inherits="Assignment.staffEventCreate" %>

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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div cssclass="content">
        <table class="table">
            <tr>
                <th colspan="3" class="auto-style3">
                    <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" OnClientClick='window.location.replace("/staffEvent.aspx");return false;'><i class="fa fa-angle-double-left" style="font-size:36px;color:black;"></i></asp:LinkButton>

                    <asp:Label ID="lblTitle" runat="server" CssClass="staffTitle" Text="Event Registration Form"></asp:Label>
                </th>
            </tr>
            <tr>
                <td colspan="3" class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6">
                    <asp:Label CssClass="label" ID="lblEventName" runat="server" Text="Name : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="input" ID="txtEventName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEventName" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtEventName" ErrorMessage="Name only can accept 5-30 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&,%#.\s]{5,30}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td class="auto-style6">

                    <asp:Label CssClass="label" ID="lblEventDescription" runat="server" Text="Description : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="input" ID="txtEventDescription" runat="server" TextMode="MultiLine"></asp:TextBox>

                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEventDescription" ErrorMessage="Description cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
           <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtEventDescription" ErrorMessage="Description only can accept 10-350 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&,%#.\s]{10,350}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventStatus" runat="server" Text="Status : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:DropDownList CssClass="list" ID="ddlEventStatus" runat="server">
                        <asp:ListItem>Upcoming</asp:ListItem>
                        <asp:ListItem>Open for Registration</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventDate" runat="server" Text="Date : "></asp:Label>
                </td>
                <td colspan="2" class="auto-style5">
                    <asp:TextBox CssClass="input" ID="txtEventStartDate" runat="server" TextMode="Date"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEventStartDate"  ErrorMessage="Date cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:Label ID="Label1" runat="server" Text="To"></asp:Label>
                </td>
                <td colspan="2" class="cal2">
                    <asp:TextBox CssClass="input" ID="txtEventEndDate" runat="server" Width="75%" TextMode="Date"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtEventEndDate" ErrorMessage="Date cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtEventStartDate" ControlToValidate="txtEventEndDate" ErrorMessage="End Date must be greater than or equal to Start Date" ForeColor="Red" Operator="GreaterThanEqual" Text="*"></asp:CompareValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventTime" runat="server" Text="Time : "></asp:Label>
                </td>
                <td colspan="2" class="auto-style5">
                    <asp:TextBox CssClass="input" ID="txtEventStartTime" runat="server" TextMode="Time"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtEventStartTime"  ErrorMessage="Time cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:Label ID="Label2" runat="server" Text="To"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="input" ID="txtEventEndTime" runat="server" TextMode="Time" Width="75%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEventEndTime" ErrorMessage="Time cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventAddress" runat="server" Text="Venue : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="input" ID="txtEventAddress" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtEventAddress" ErrorMessage="Venue cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtEventAddress" ErrorMessage="Venue only can accept 5-300 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@,%&#.\s]{5,300}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
           
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventCategory" runat="server" Text="Category : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:DropDownList CssClass="list" ID="ddlEventCategory" runat="server" DataSourceID="SqlDataSource1" DataTextField="category" DataValueField="categoryID">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlEventCategory" ErrorMessage="Category cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="Label3" runat="server" Text="Senior"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="Label13" runat="server" Text="Quantity: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="seniorQty" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="seniorQty" ErrorMessage="Quantity cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="seniorQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="label" ID="Label8" runat="server" Text="Price: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="SeniorPrice" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ControlToValidate="SeniorPrice" ErrorMessage="Price cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="SeniorPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label CssClass="label" ID="Label4" runat="server" Text="Kid"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="Label14" runat="server" Text="Quantity: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="kidQty" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="kidQty" ErrorMessage="Quantity cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="kidQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="label" ID="Label5" runat="server" Text="Price: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="kidPrice" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="kidPrice" ErrorMessage="Price cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="kidPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label CssClass="label" ID="Label6" runat="server" Text="Student"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="Label15" runat="server" Text="Quantity: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="studentQty" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="studentQty" ErrorMessage="Quantity cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="studentQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="label" ID="Label7" runat="server" Text="Price: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="studentPrice" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="studentPrice" ErrorMessage="Price cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="studentPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label CssClass="label" ID="Label9" runat="server" Text="Adult"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="Label16" runat="server" Text="Quantity: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="adultQty" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="adultQty" ErrorMessage="Quantity cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="adultQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="label" ID="Label10" runat="server" Text="Price: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="adultPrice" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="adultPrice" ErrorMessage="Price cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="adultPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label CssClass="label" ID="Label11" runat="server" Text="OKU"></asp:Label>
                </td>
                <td class="auto-style5">
                    <asp:Label CssClass="label" ID="Label17" runat="server" Text="Quantity: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="okuQty" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="okuQty" ErrorMessage="Quantity cannot be empty"  Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ControlToValidate="okuQty" ErrorMessage="Invalid Quantity" ForeColor="Red" ValidationExpression="^[0-9]+$|^0$ " Text="*"></asp:RegularExpressionValidator>
                </td>
                <td>
                    <asp:Label CssClass="label" ID="Label12" runat="server" Text="Price: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox CssClass="input" ID="okuPrice" runat="server">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="okuPrice" ErrorMessage="Price cannot be empty"  Text="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server" ControlToValidate="okuPrice" ErrorMessage="Invalid Price" ForeColor="Red" ValidationExpression="^\d+(\.\d{1,2})?$" Text="*"></asp:RegularExpressionValidator>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lbEventOrganizer" runat="server" Text="Organizer : "></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox CssClass="input" ID="txtEventOrganizer" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtEventOrganizer" ErrorMessage="Organizer cannot be empty" ForeColor="Red" Text="*"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtEventOrganizer" ErrorMessage="Organizer only can accept 5-100 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@&#.\s]{5,100}$" Text="*"></asp:RegularExpressionValidator>

                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label CssClass="label" ID="lblEventImage" runat="server" Text="Image :"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:FileUpload CssClass="upload" ID="fuImage" runat="server" />
                    &nbsp;<asp:Button CssClass="btnUpload" ID="btnImageUpload" runat="server" Text="UPLOAD" OnClick="btnImageUpload_Click" />
                    <br />
                    <br />
                    <asp:Image ID="imgEvent" runat="server" Height="86px" Width="119px" />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Button CssClass="btnAdd" ID="btnEvent" runat="server" Text="Add" OnClick="btnEventAdd_Click" />
                    &nbsp;<asp:Button CssClass="btnReset" ID="btnEventReset" runat="server" OnClick="btnEventReset_Click" OnClientClick='window.location.replace("/staffEventCreate.aspx");return false;' Text="Reset" />
                    <br />
                    <br />
                </td>
            </tr>
        </table>

    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [category], [categoryID] FROM [Category]"></asp:SqlDataSource>

<asp:validationsummary showmessagebox="true" showsummary="false" forecolor="Red" runat="server" id="validationSummary">
</asp:validationsummary>  
</asp:Content>


