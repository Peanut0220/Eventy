<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberEvent.aspx.cs" Inherits="Assignment.memberEvent" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @keyframes fadeIn {
            0% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @keyframes enter-animation {
            0% {
                transform: translateX(500px);
            }

            100% {
                transform: translateX(0);
            }
        }


        @media (prefers-reduced-motion: no-preference) {
            .image-animation {
                animation: enter-animation 1.5s 1;
            }
        }

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }


        body {
            background-color: black;
            color: white;
            animation: 1.5s fadeIn;
        }

        .container {
            padding-top: 4%;
            margin-left: 8%;
            margin-right: 8%;
            padding-bottom: 5%;
        }


        .left {
            display: inline-block;
            width: 50%;
        }

        .right {
            display: inline-block;
            width: 40%;
        }

        .rightbottom {
            display: block;
            padding-top: 20px;
            padding-left: 25%;
        }

        .button {
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
        }

            .button:hover {
                background-color: rgba(0, 0, 255, 0.6);
                transition: all 0.25s;
                color: lightblue;
            }

        .button2 {
            color: white;
            
            border-radius: 20px;
            padding: 10px 20px;
            display: inline-block;
            font-size: 17px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s;
        }

            .button2:hover {
                transition: all 0.25s;
                color: blue;
            }

        .searchContainer {
            padding-top: 3%;
            margin-left: 8%;
            margin-right: 8%;
            padding-bottom: 3%;
            text-align: center;
        }

        .filterContainer {
            margin-left: 5%;
            margin-right: 5%;
            padding-bottom: 3%;
            text-align: center;
        }

        .searchBar {
            width: 75%;
            height: 30px;
            border: 0px;
            border-radius: 40px;
            padding: 10px;
            background-color: rgb(7, 8, 40);
            color: white;
            font-size: 17px;
            line-height: 20px;
            margin-right: 5px;
            padding-left: 25px;
            transition: all 0.6s;
        }

            .searchBar::placeholder {
                color: gray;
            }

            .searchBar:hover {
                background-color: rgb(7, 8, 50);
            }

        .ddl {
            padding: 0px 20px;
            margin-right: 33px;
            height: 40px;
            border: 0px;
            border-radius: 40px;
            background-color: rgb(7, 8, 40);
            color: white;
            font-size: 17px;
            transition: all 0.6s;
            color-scheme: dark;
        }

            .ddl:hover {
                background-color: rgb(7, 8, 60);
                transition: all 0.6s;
            }

        .total {
            margin-left: 8%;
            margin-bottom: 2%;
            font-size: 25px;
        }



        .btnPage {
            color: white;
            font-size: 20px;
            margin-left: 15px;
            transition: all 0.5s;
        }

        .paging {
            text-align: center;
            display: flex;
            justify-content: center;
            margin: 3% 0% 3% 0%;
        }

        .btnPage:hover {
            color: blue;
            transform: translateY(-3px);
            transition: all 0.5s;
        }

        .btnPage:active {
            color: blue;
        }

        .currPage {
            font-size: 40px;
            color: #3c7dce;
            padding-top: 10px;
        }

        .event {
            float: left;
            display: block;
            position: relative;
            margin-bottom: 20%;
            overflow: hidden;
            margin-left: 5%;
            width: 380px;
            transition: all 0.65s;
            border-radius: 40px;
            border-collapse: collapse;
        }

            .event:hover {
                transform: scale(1.1);
                transition: all 0.65s;
                border: none;
            }



        .img {
            display: block;
            width: 380px;
            height: 250px;
        }




        .eventNameRows {
            text-align: center;
            font-size: 25px;
            color: rgb(16, 20, 82);
            font-weight: bolder;
            background-color: rgb(255,255,255);
            text-align: center;
        }

        .eventStatusRows {
            text-align: center;
            font-size: 15px;
            color: rgb(16, 20, 82);
            font-weight: bolder;
            background-color: rgb(255,255,255);
            text-align: center;
        }



        .buttonRows {
            background-color: rgb(255,255,255);
            text-align:center;
        }

        .btnViewDetails {
            color: white;
            background-color: rgb(16, 20, 82);
            border-radius: 20px;
            font-size: 15px;
            width: 50%;
            padding: 3%;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.65s;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            margin-bottom: 5%;
        }

            .btnViewDetails:hover {
                transform: scale(1.2);
                transition: all 0.65s;
            }




        tr, td {
            padding: 2%;
        }

        table {
            border-collapse: separate;
        }

        .imgRows {
            padding: 0%;
            width: 380px;
            height: 250px;
        }

        .containerEventList {
            display: inline-block;
            margin-right: 3%;
        }

        .upcoming {
            color: #c36c00;
        }

        .open {
            color: green;
        }

        .false{
            color:gray;
        }

        .false:hover{
    color:gray;
    transform: scale(1);
transition: all 0.65s;

}

        .eventDate{
              text-align: center;
  font-size: 15px;
  color: rgb(16, 20, 82);
  font-weight: bolder;
  background-color: rgb(255,255,255);
  text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Event] WHERE ( eventStatus = @status1 OR eventStatus = @status2 ) and isArchive=0">
        <SelectParameters>
            <asp:Parameter DefaultValue="Open for Registration" Name="status1" />
            <asp:Parameter DefaultValue="Upcoming" Name="status2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT COUNT(eventID) AS count FROM [Event] WHERE ( eventStatus = @status1 OR eventStatus = @status2 ) and isArchive=0">
        <SelectParameters>
            <asp:Parameter DefaultValue="Open for Registration" Name="status1" />
            <asp:Parameter DefaultValue="Upcoming" Name="status2" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="searchContainer">
        <asp:TextBox CssClass="searchBar" ID="TextBox1" runat="server" placeholder="Search For Event" BorderStyle="None"></asp:TextBox>
        <asp:LinkButton ID="linkBtn" CssClass="button2" runat="server" OnClick="linkBtn_Click"><i class="fa fa-search" aria-hidden="true"></i></asp:LinkButton>
        <%--  <asp:Button CssClass="button" ID="Button2" runat="server" Text="Search" />--%>
    </div>
    <div class="filterContainer">
        <asp:Label ID="Label1" runat="server" Text="Event Categories :"></asp:Label>
        <asp:DropDownList CssClass="ddl" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="category" DataValueField="categoryID" AppendDataBoundItems="true">
            <asp:ListItem Selected="True">-- Select One --</asp:ListItem>
        </asp:DropDownList>
        <asp:Label ID="Label2" runat="server" Text="Event Start Date :"></asp:Label>
        <asp:TextBox CssClass="ddl" ID="TextBox3" runat="server" TextMode="Date"></asp:TextBox>
        <asp:Label ID="Label4" runat="server" Text="Event End Date :" ></asp:Label>
          <asp:TextBox CssClass="ddl" ID="TextBox2" runat="server" TextMode="Date"></asp:TextBox>
        <asp:LinkButton CssClass="button2" ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><i class="fa fa-filter" aria-hidden="true"></i></asp:LinkButton>
         <asp:LinkButton CssClass="button2" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click"><i class="fa fa-refresh" aria-hidden="true"></i></asp:LinkButton>
    </div>

     <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource3">
     <ItemTemplate>
          <asp:Label CssClass="total" ID="Label3" runat="server" Text='<%# Eval("count") +" result(s)"%>'>></asp:Label>
     </ItemTemplate>
 </asp:Repeater>
   
    <div class="container">
        <asp:Repeater ID="eventRpt" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>



                <div class="containerEventList">

                    <table class="event">

                        <tr>
                            <td class="imgRows">
                                <asp:Image CssClass="img" ID="Image1" runat="server" ImageUrl='<%# Eval("eventImage")%>' />

                            </td>
                        </tr>
                        <tr class="eventNameRows">

                            <td class="eventName"><%# Eval("eventName") %></td>
                        </tr><tr class="eventNameRows">

    <td class="eventDate"><%# Eval("eventStartDate","{0:dd/M/yyyy}") %> - <%# Eval("eventEndDate","{0:dd/M/yyyy}") %></td>
</tr>
                        <tr class="eventStatusRows">

                            <td><%string status = status1();
                                    if (status.Equals("Open for Registration"))
                                    {%>
                                <asp:Label CssClass="open" ID="Label1" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                                    </td>
</tr>
<tr class="buttonRows">
    <td>
        <asp:Button CssClass="btnViewDetails" ID="Button1" runat="server" Text="Buy for Pass" OnClick="Button1_Click" PostBackUrl='<%# "~/memberEventDetail.aspx?eventID=" +  Eval("eventID")%>' />
    </td>
</tr>
                                <%}
                                    else if (status.Equals("Upcoming"))
                                    {%>
                                <asp:Label CssClass="upcoming" ID="Label2" runat="server" Text='<%#Eval("eventStatus") %>'></asp:Label>
                            </td>
</tr>
<tr class="buttonRows">
    <td>
        <asp:Button CssClass="btnViewDetails false" ID="Button2" runat="server" Text="Buy for Pass" OnClick="Button1_Click" Enabled="false" PostBackUrl='<%# "~/memberEventDetail.aspx?eventID=" +  Eval("eventID")%>' />
    </td>
</tr>
                                <%}
                                %>   

                           

                    </table>

                </div>



            </ItemTemplate>
        </asp:Repeater>
    </div>
    <hr />
    <div class="paging">
        <asp:Label CssClass="currPage" ID="Label5" runat="server" Text=""></asp:Label>
        <asp:Repeater ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand">
            <ItemTemplate>

                <asp:LinkButton ID="btnPage"
                    CssClass="btnPage"
                    CommandName="Page" CommandArgument="<%# Container.DataItem %>"
                    runat="server" Font-Bold="True">
    <%# Container.DataItem %>
                </asp:LinkButton>

            </ItemTemplate>
        </asp:Repeater>
    </div>

    <script>
        const observer = new IntersectionObserver(entries => {

            // Loop over the entries
            entries.forEach(entry => {

                // If the element is visible
                if (entry.isIntersecting) {
                    // Add the animation class
                    entry.target.classList.add('image-animation');

                }
            });
        });

        const viewbox = document.querySelectorAll('.container');
        viewbox.forEach(image => {
            observer.observe(image);
        });

    </script>

</asp:Content>

