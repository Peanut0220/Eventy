<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="userAboutUs.aspx.cs" Inherits="Assignment.userAboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <style>

            @keyframes fadeIn {
       0% {
           opacity: 0;
       }

       100% {
           opacity: 1;
       }
   }
                 @font-face {
    font-family: "Kanit";
    src: url("Kanit-Regular.ttf");
}
                        @keyframes enter-animation {
           0% {
               transform: translateX(-500px);
           }

           100% {
               transform: translateX(0);
           }
       }

                                         @keyframes enter-animation {
    0% {
        transform: translateX(-500px);
    }

    100% {
        transform: translateX(0);
    }
}

@media (prefers-reduced-motion: no-preference) {
    .image-animation {
        animation: enter-animation 3s 1;
    }
     
}
* {
    font-family: "Kanit";
}
     body {
         
         color: #fff;
        animation: 2s fadeIn;
         margin: 0;
         padding: 0;
     }
    

     .details {
         display: flex;
         justify-content: space-around;
         margin: 20px;
         border-radius: 10px;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
         overflow: hidden;
     }

         .details div {
             flex: 1;
             text-align: center;
             padding: 20px;
         }

             .details div:last-child {
                 border-right: none;
             }

     .vision-mission-container {
         display: flex;
           background-color: rgb(7, 8, 23) !important;
        
         border-radius: 10px;
       
         overflow: hidden;
       
     }

     .vision, .mission {
         flex: 1;
         padding: 40px;
         text-align: center;
         border-right: 1px solid #fff;
         border-right-style: ridge;
     }

         .vision:last-child, .mission:last-child {
             border-right: none;
         }

     .hero-section {
         position: relative;
         text-align: center;
         color: #fff;
         overflow: hidden;
         padding: 80px 0;
         height: 150px;
         background-color:black;
     }

     .hero-background {
         width: 100%;
         position: absolute;
         top: 0;
         left: 0;
         z-index: -1;
     }

     .hero-content {
         position: relative;
         z-index: 1;

     }

     .team-members {
         display: flex;
         flex-wrap: wrap;
         justify-content: space-around;
         margin: 20px;
         padding-top: 20px;
     }

     .team-member {
         flex-basis: calc(25% - 20px);
         margin-bottom: 20px;
         text-align: center;
     }

         .team-member img {
             border-radius: 50%;
             max-width: 100%;
             height: 150px;
         }

     .company-history {
       background-color: rgb(7, 8, 23) !important;
      
         border-radius: 10px;
      
         overflow: hidden;
         margin: 20px;
         padding: 22px;
     }

     .partnerships {
        
       
         border-radius: 10px;
      
         overflow: hidden;
         margin: 20px;
         padding: 22px;
     }

     .partnership-logos {
         display: flex;
         flex-wrap: wrap;
         justify-content: space-around;
     }

     .partnership-logo {
         max-width: 100%;
         height: auto;
         margin: 10px;
         display: flex;
         flex-direction: column;
         align-items: center;
     }

         .partnership-logo img {
             max-width: 100%;
             height: auto;
             max-height: 100px;
             margin: 0 auto;
             display: block;
         }

         .year, .office, .employee, .event{
             transition:all 1s;
         }
          .year:hover, .office:hover, .employee:hover, .event:hover{
              transform:translateY(-30px);
              transition:all 1s;
 }

 </style>

 <div class="hero-section container">
     
     <div class="hero-content">
         <h1 style="font-size:50px;">Welcome to Eventy</h1>
         <h2 style="font-size:20px;">Where Every Event Tells a Unique Story</h2>
     </div>
 </div>

 <div class="details container">
     <div class="year">
         <h1>10</h1>
         <p>Years of Experience</p>
     </div>
     <div class="office">
         <h1>5</h1>
         <p>Global Offices</p>
     </div>
     <div class="employee">
         <h1>1000+</h1>
         <p>Passionate Employees</p>
     </div>
     <div class="event">
         <h1>300+</h1>
         <p>Successfully Organized Events</p>
     </div>
 </div>

 <div class="vision-mission-container container">
     <div class="vision">
         <h1>Our Vision</h1>
         <p>Empower individuals and organizations to create seamless, immersive experiences that leave a lasting impact on the world.</p>
     </div>
     <div class="mission">
         <h1>Our Mission</h1>
         <p>Provide a cutting-edge, user-centric platform that simplifies the event management process and transforms ideas into unforgettable events.</p>
     </div>
 </div>

 <div class="team-members container">
     <div class="team-member">
         <asp:Image ID="Image1" runat="server" ImageUrl="~/images/member0.jpg" />
         <h3>Ng Chong Jian</h3>
         <p>Founder & CEO</p>
     </div>
     <div class="team-member">
         <asp:Image ID="Image2" runat="server" ImageUrl="~/images/member111.jpg" />
         <h3>Lim Yi Jie</h3>
         <p>Chief Operating Officer</p>
     </div>
     <div class="team-member">
         <asp:Image ID="Image3" runat="server" ImageUrl="~/images/member12.jpg" />
         <h3>Yew Zi Yu</h3>
         <p>Chief Technology Officer</p>
     </div>
     <div class="team-member">
         <asp:Image ID="Image4" runat="server" ImageUrl="~/images/member13.jpg" />
         <h3>Lim Shi Lei</h3>
         <p>Chief Technology Officer</p>
     </div>
 </div>

 <div class="company-history container">
     <h2>Our Journey</h2>
     <p>
         Founded in 2012, Eventy has evolved from a small startup to a leading event management company. Our journey has been marked by innovation, dedication, and a commitment to creating memorable experiences for our clients.
     </p>
     <p>
         Over the years, we've expanded our reach globally, opening offices in key cities and establishing ourselves as pioneers in the event industry. Each milestone has strengthened our resolve to deliver excellence in every event we undertake.
     </p>
 </div>

 <div class="partnerships container">
     <h2>Collaborations / Sponsorships</h2>
     <div class="partnership-logos">
         <div class="partnership-logo">
             <asp:Image ID="Image7" runat="server" ImageUrl="~/images/partnership1.png" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image8" runat="server" ImageUrl="~/images/partnership3.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image9" runat="server" ImageUrl="~/images/partnership4.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image10" runat="server" ImageUrl="~/images/partnership5.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image11" runat="server" ImageUrl="~/images/partnership6.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image12" runat="server" ImageUrl="~/images/partnership7.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image13" runat="server" ImageUrl="~/images/partnership8.jpg" />
         </div>
         <div class="partnership-logo">
             <asp:Image ID="Image14" runat="server" ImageUrl="~/images/partnership9.jpg" />
         </div>
     </div>
     <p>
         Eventy collaborates with industry leaders and strategic partners to enhance our event management services. These partnerships empower us to bring cutting-edge solutions and innovative ideas to our clients, ensuring unparalleled success in every event.
     </p>
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
