<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberProfile.aspx.cs" Inherits="Assignment.memberProfile" %>

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
            color: white;
        }



        .memberTitle {
            font-size: 40px;
            text-align: center;
            margin-left: 3%;
            color: blue;
            width: 60%;
            margin-right: 15%;
        }

        .table {
            width: 60%;
            margin: 2% 15% 5% 20%;
        }

        .label {
            font-size: 25px;
            width: 10%;
            margin-left: 30%;
        }

        .input {
            border-radius: 10px;
            width: 65%;
            color: black;
            font-size: 20px;
            text-align: center;
            transition: all 0.5s ease-out;
        }


        .input2 {
            border-radius: 10px;
            width: 65%;
            color: lightgrey;
            font-size: 20px;
            text-align: center;
            transition: all 0.5s ease-out;
        }

        .input1 {
            color: lightgrey;
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
            color: white;
        }

        th {
            width: 40%;
            margin-bottom: 2%;
            border-color: rgba(0, 0, 255, 0.6);
        }


        .btnUpdate {
            margin-left: 33%;
            cursor: pointer;
            color: white;
            background-color: rgba(0, 0, 255, 0.6);
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

            .btnUpdate:hover {
                transform: scale(1.1);
                transition: all 0.25s;
            }

        .btnReset {
            width: 15%;
            cursor: pointer;
            color: white;
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
                color: black;
            }



        .auto-style3 {
            height: 80px;
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
            padding: 8px 12px;
        }

        .btnBack {
            margin-left: -10%;
            margin-right: 5%;
        }



        .auto-style5 {
            width: 40%;
            font-size: 20px;
            margin-left: 0px;
        }

        .iconEdit:hover {
            transform: scale(1.2);
            transition: all 0.5s ease-out;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <div class="layout">

                <div class="right">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        <HeaderTemplate>

                            <table style="width: 95%; margin-left: 10%;">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <th colspan="2" class="auto-style4">
                                    <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" Visible="False" PostBackUrl="~/memberProfile.aspx"><i class="fa fa-angle-double-left" style="font-size:36px;color:white;"></i></asp:LinkButton>

                                    <asp:Label CssClass="memberTitle" ID="title" runat="server" Text="Persona Details"></asp:Label>
                                    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><i class="fas fa-edit" style="font-size:28px;color:white;"></i></asp:LinkButton>
                                    <%--                        <asp:ImageButton CssClass="iconEdit" ID="imgEdit" runat="server" Height="25px" OnClick="ImageButton1_Click" Width="31px" ImageUrl="~/images/edit-icon.png" />--%>
                                    <br></br>
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>

                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberProfileName" runat="server" Text="Name :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtMemberProfileName2" runat="server" Enabled="False" Width="380px" OnTextChanged="txtMemberProfileName2_TextChanged" Text='<%#Eval("name") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblIC" runat="server" Text="IC :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtIC" runat="server" Enabled="False" Width="380px" Text='<%#Eval("IC") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberProfilePhoneNo" runat="server" Text="Phone No : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtMemberProfilePhoneNo" runat="server" Enabled="False" Width="380px" Text='<%#Eval("phoneNo") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberProfileEmail2" runat="server" Text="Email :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtMemberProfileEmail2" runat="server" Enabled="False" Width="380px" Text='<%#Eval("email") %>'></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberEmergencyContact" runat="server" Text="Emergency Contact : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtMemberEmergencyContact" runat="server" Enabled="False" Width="380px" Text='<%#Eval("emergencyContact") %>'></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberAddress" runat="server" Text="Address : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtMemberAddress" runat="server" Enabled="False" Width="380px" Text='<%#Eval("address") %>'></asp:TextBox>
                                </td>
                            </tr>


                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblDate" runat="server" Text="Joined Date : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input2" ID="txtDate" runat="server" Enabled="False" Width="380px" Text='<%#Eval("joinedDate","{0:dd/MM/yyyy}") %>' TextMode="DateTime"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <br />

                                    <asp:Button CssClass="btnUpdate" ID="btnChange" runat="server" Text="Change Password" OnClick="btnChange_Click" Visible="True" />
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>

                        </FooterTemplate>

                    </asp:Repeater>
                </div>
            </div>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div class="layout">

                <div class="right">
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
                        <HeaderTemplate>

                            <table style="width: 95%; margin-left: 10%;">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <th colspan="2" class="auto-style4">
                                    <asp:LinkButton ID="btnBack" CssClass="btnBack" runat="server" Visible="True" OnClientClick='window.location.replace("/memberProfile.aspx");return false;'  OnClick="ImageBack1_Click"><i class="fa fa-angle-double-left" style="font-size:36px;color:white;"></i></asp:LinkButton>

                                    <asp:Label CssClass="memberTitle" ID="title" runat="server" Text="Persona Details"></asp:Label>
                                    &nbsp;
                            <br></br>
                                </th>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>

                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberProfileName" runat="server" Text="Member Name :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input" ID="txtMemberProfileName2" runat="server" Enabled="True" Width="380px" OnTextChanged="txtMemberProfileName2_TextChanged" Text='<%#Eval("name") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMemberProfileName2" ErrorMessage="Name cannot be empty" ForeColor="Red" Text="<br/>Name cannot be empty"></asp:RequiredFieldValidator>

                                    <asp:Label CssClass="label" ID="Label1" runat="server" Style="display: none;" Text='<%#Eval("memberID") %>'></asp:Label>

                                </td>
                            </tr>
                           
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberProfilePhoneNo" runat="server" Text="Phone No : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input" ID="txtMemberProfilePhoneNo" runat="server" Enabled="True" Width="380px" Text='<%#Eval("phoneNo") %>'></asp:TextBox>
                                    <asp:Label CssClass="label" ID="Label4" runat="server" Style="display: none;" Text='<%#Eval("phoneNo") %>'></asp:Label>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMemberProfilePhoneNo" ErrorMessage="Phone No cannot be empty" ForeColor="Red" Text="<br/>Phone No cannot be empty"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtMemberProfilePhoneNo" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>

                                </td>
                            </tr>


                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberEmergencyContact" runat="server" Text="Emergency Contact : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input" ID="txtMemberEmergencyContact" runat="server" Enabled="True" Width="380px" Text='<%#Eval("emergencyContact") %>'></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtMemberEmergencyContact" ErrorMessage="Emergency Contact cannot be empty" ForeColor="Red" Text="<br/>Emergency Contact cannot be empty"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtMemberEmergencyContact" ErrorMessage="Invalid phoneNo(Only accept start with '01' and start with '011'have 11 digit else 10 digit)" ForeColor="Red" ValidationExpression="(^011\d{8}|^01\d{8})$" Text="*"></asp:RegularExpressionValidator>

                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style3">
                                    <asp:Label CssClass="label" ID="lblMemberAddress" runat="server" Text="Address : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input" ID="txtMemberAddress" runat="server" Enabled="True" Width="380px" Text='<%#Eval("address") %>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMemberAddress" ErrorMessage="Address cannot be empty" ForeColor="Red" Text="<br/>Address cannot be empty"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtMemberAddress" ErrorMessage="Address only can accept 20-100 character" ForeColor="Red" ValidationExpression="^[a-zA-Z0-9'@,&#.\s]{20,100}$" Text="*"></asp:RegularExpressionValidator>

                                </td>
                            </tr>



                            <tr>
                                <td colspan="2">
                                    <br />

                                    <asp:Button CssClass="btnUpdate" ID="btnChange" runat="server" Text="Update" OnClick="btnUpdate_Click" Visible="True" />
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>

                        </FooterTemplate>

                    </asp:Repeater>
                </div>
            </div>
        </asp:View>
    </asp:MultiView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Member] WHERE ([memberID] = @memberID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="" Name="memberID" SessionField="memberID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>