<%@ Page Title="" Language="C#" MasterPageFile="~/member.Master" AutoEventWireup="true" CodeBehind="memberEventDetail.aspx.cs" Inherits="Assignment.memberEventDetail" %>

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

        @keyframes slideinleft {
            0% {
                transform: translateX(-500px);
            }

            100% {
                transform: translateX(0);
            }
        }

        @keyframes slideinright {
            0% {
                transform: translateX(500px);
            }

            100% {
                transform: translateX(0);
            }
        }

        @keyframes enter-animation {
            0% {
                transform: translateX(100px);
                opacity: 0;
            }

            100% {
                transform: translateX(0);
                opacity: 1;
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
            color: white;
            animation: 1.5s fadeIn;
        }

        .container {
            padding-top: 4%;
            margin-left: 8%;
            margin-right: 8%;
            padding-bottom: 5%;
        }

        .eventName {
            font-size: 55px;
            display: flex;
            margin-left: 40px;
            position: absolute;
            top: 24%;
        }

        .eventDesc {
            display: flex;
            margin-left: 40px;
            position: absolute;
            top: 35%;
        }


        .left {
            display: inline-block;
            animation: 1.5s slideinleft;
        }

        .right {
            display: inline-block;
            animation: 1.5s fadeIn;
        }

        .image {
            display: flex;
            border-radius: 8px 8px 8px 8px;
        }

        .bottom {
            margin-top: 30px;
            animation: 1.5s slideinright;
        }

        .buttonCol {
            width: 20%;
        }

        .number {
            width: 20%;
            height: 30px;
            border: 0px;
            border-radius: 40px;
            padding: 10px;
            background-color: rgb(7, 8, 50);
            color: white;
            font-size: 17px;
            line-height: 20px;
            margin-right: 5px;
            transition: all 0.6s;
        }

            .number::placeholder {
                color: gray;
            }

            .number:hover {
                background-color: rgb(7, 8, 50);
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

        hr {
            margin: 20px 0px;
        }

        .commentLbl {
            font-size: 40px;
        }

        .comment {
            margin: 4% 0%;
        }

        .fa-star {
            color: yellow;
            border-color: yellow;
        }

        .lblName {
            font-size: 25px;
        }

        .lblDate {
            font-size: 13px;
        }

        .starContainer {
            margin-bottom: 2px;
        }

        .commentContainer {
            margin-bottom: 3%;
        }


        .priceContainer {
            display: block;
            width:70%;
            margin-right:0;
            margin-left:25%;
            margin-top:50px;
        }
        .priceCategory{
            font-size:20px;
        }
        .price-left{
            display:inline-block;
            width:70%;
        }

        .price-right{
            display:inline-block;
            width:20%;
            text-align:center;
            transform:translateY(-130px);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Event] INNER JOIN Category ON Event.categoryID = Category.categoryID Where Event.eventID = @eventID">
        <SelectParameters>
            <asp:QueryStringParameter Name="eventID" QueryStringField="eventID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Comment] INNER JOIN [Member] ON Comment.memberID = Member.memberID WHERE ([eventID] = @eventID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="eventID" QueryStringField="eventID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Event] INNER JOIN TicketPrice ON Event.eventID = TicketPrice.eventID INNER JOIN TicketCategory ON TicketCategory.ticketCategoryID = TicketPrice.ticketCategoryID INNER JOIN Category ON Event.categoryID = Category.categoryID Where Event.eventID = @eventID">
        <SelectParameters>
            <asp:QueryStringParameter Name="eventID" QueryStringField="eventID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <div class="container">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>

                <div class="left">
                    <asp:Image CssClass="image" ID="Image1" runat="server" ImageUrl='<%# Eval("eventImage")%>' Width="450" Height="250" />

                </div>
                <div class="right">
                       <asp:Label CssClass="eventName" ID="Label9" style="display:none;" runat="server" Text='<%# Eval("eventID") %> '></asp:Label>
                    <asp:Label CssClass="eventName" ID="Label1" runat="server" Text='<%# Eval("eventName") %> '></asp:Label>
                    <asp:Label CssClass="eventDesc" ID="Label2" runat="server" Text='<%# Eval("eventDescription") %> '></asp:Label>

                </div>

                <div class="bottom">

                    <table style="width: 100%;">


                        <tr>
                            <td>Event Status</td>
                            <td>:</td>
                            <td><%# Eval("eventStatus") %></td>
                           
                        </tr>
                        <tr>
                            <td>Event Duration</td>
                            <td>:</td>
                            <td><%# Eval("eventStartDate","{0:dd/M/yyyy}") %> - <%# Eval("eventEndDate","{0:dd/M/yyyy}") %></td>

                        </tr>
                        <tr>
                            <td>Event Time</td>
                            <td>:</td>
                            <td><%# Eval("eventStartTime") %> -  <%# Eval("eventEndTime") %></td>

                        </tr>
                        <tr>
                            <td>Event Venue</td>
                            <td>:</td>
                            <td><%# Eval("eventVenue") %> </td>
                        </tr>

                        <tr>
                            <td>Event Category</td>
                            <td>:</td>
                            <td><%# Eval("category") %></td>
                        </tr>





                    </table>
                </div>

            </ItemTemplate>
        </asp:Repeater>
        <div class="priceContainer">
            <div class="price-left">

    
       
          <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3" OnPreRender="Repeater3_PreRender">
      <HeaderTemplate>
          <table style="width: 100%;">
      </HeaderTemplate>
      <ItemTemplate>
          <tr>
              <td>
                  <asp:Label CssClass="priceCategory" ID="Label7" runat="server" Text='<%# Eval("ticketCategoryName") %> '></asp:Label></td>
              <td style="width:5%;">RM</td>
              <td>
                  <asp:Label CssClass="eventPrice" ID="Label3" runat="server" Text='<%# Eval("price","{0: 0.00}") %> '></asp:Label></td>
               <td style="width:13%;">
   QTY Left:</td>
               <td >
                  <asp:Label CssClass='<%# "eventQty " + Container.ItemIndex %>' ID="Label8" runat="server" Text='<%# Eval("quantityLeft") %>'></asp:Label></td>
              <td style="width:40%;">
                  <asp:LinkButton CssClass='<%#Container.ItemIndex%>' ID="LinkButton1" runat="server" OnClientClick="return minus(event)" ClientIDMode="Static"><i class='<%# "fa fa-minus " + Container.ItemIndex %>' aria-hidden="true"></i></asp:LinkButton>
                  <asp:TextBox CssClass='<%# "number " + Container.ItemIndex %>' ID="ticketNum" runat="server" type="number" value="0" />
              <asp:LinkButton CssClass='<%#Container.ItemIndex%>' ID="LinkButton2" runat="server" OnClientClick="return add1(event)" ClientIDMode="Static"><i class='<%# "fa fa-plus " + Container.ItemIndex %>' aria-hidden="true"></i></asp:LinkButton>
                  </td>
          </tr>

      </ItemTemplate>
      <FooterTemplate>
          </table>
      </FooterTemplate>
  </asp:Repeater>
                        </div>
            <div class="price-right">
                   <asp:Button CssClass="button" ID="Button1" runat="server" Text="Add To Cart" OnClientClick="return validate1()" />
               <asp:Button runat="server" ID="UploadButton" Text="" style="display:none;" OnClick="UploadButton_Click" ClientIDMode="Static" />

            </div>
          
        </div>
   

    
        <div class="comment">
            <asp:Label ID="Label6" runat="server" Text="" Visible="False"></asp:Label>
            <asp:Label CssClass="commentLbl" ID="Label4" runat="server" Text="Comment Section"></asp:Label><hr />
            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">

                <ItemTemplate>
                    <div class="commentContainer">
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("rating") %>' Visible="False"></asp:Label>
                        <asp:Label CssClass="lblName" ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>


                        <asp:Label CssClass="lblDate" ID="lblDate" runat="server" Text='<%# Eval("createdDate","{0:dd/MM/yyyy hh:mm}") %>'></asp:Label>
                        <div class="starContainer">
                            <%
                                int rating = rating1();
                                for (int i = 0; i < rating; i++)
                                {%>
                            <i class="fa fa-star"></i>
                            <%}
                                for (int i = 0; i < 5 - rating; i++)
                                {%>
                            <i class="far fa-star" aria-hidden="true"></i>
                            <% }
                            %>
                        </div>


                        <asp:Label CssClass="lblContent" ID="lblContent" runat="server" Text=' <%# Eval("content") %>'></asp:Label>
                    </div>
                </ItemTemplate>

            </asp:Repeater>
        </div>

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

        const viewbox = document.querySelectorAll('.commentContainer');
        viewbox.forEach(image => {
            observer.observe(image);
        });

       
        function validate1() {
            var elemArray = document.getElementsByClassName('number');
            var elemArray1 = document.getElementById('ticketNum');
            var count = 0;
            for (var i = 0; i < elemArray.length; i++) {
                var elem = elemArray[i].value;
                if (elem !=0) {
                    count = 1;
                }
            }
            if (count == 0) {
                alert("Please select at least 1 ticket.");
                return false;
            } else {
           
                document.getElementById("UploadButton").click();

                return false;
            }
         
        }

        function add1(e) {
          
            var elemArray = document.getElementsByClassName('number');
            var elemArray1 = document.getElementsByClassName('eventQty');
            var clickedElement = e.target;
      
            for (var i = 0; i < elemArray.length; i++) {

                if (elemArray[i].className.replace('number ','') == clickedElement.className.replace('fa fa-plus ','')) {
                    if (elemArray1[i].className.replace('eventQty ', '') == clickedElement.className.replace('fa fa-plus ', '')) {
                        if (Number(elemArray1[i].textContent) > elemArray[i].value) {
                            elemArray[i].value++;
                        } else {
                            alert('The Ticket Quantity Left is only ' + elemArray1[i].textContent);
                        }
                        
                    }
                   

                }
            }
            return false;
        }


        function minus(e) {

            var elemArray = document.getElementsByClassName('number');
            var clickedElement = e.target;

            for (var i = 0; i < elemArray.length; i++) {

                if (elemArray[i].className.replace('number ', '') == clickedElement.className.replace('fa fa-minus ', '')) {
                    if (elemArray[i].value != 0) {
                        elemArray[i].value--;
                    } else {

                    }
                 

                }
            }
            return false;
        }

       
     

     

       
    </script>

</asp:Content>
