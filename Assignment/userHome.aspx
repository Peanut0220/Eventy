<%@ Page Title="" Language="C#" MasterPageFile="~/user.Master" AutoEventWireup="true" CodeBehind="userHome.aspx.cs" Inherits="Assignment.userHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css" />
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
                transform: translateX(-500px);
            }

            100% {
                transform: translateX(0);
            }
        }

        @font-face {
            font-family: "Kanit";
            src: url("Kanit-Regular.ttf");
        }

        * {
            font-family: "Kanit";
        }
       
     

 @media (prefers-reduced-motion: no-preference) {
     .image-animation {
         animation: enter-animation 3s 1;
     }
      
 }


        body {
            margin: 0;
            padding: 0;
            background-color: black;
            color: white;
            animation: 1.5s fadeIn;
        }

        .hero-section {
            margin-top: 50%;
            margin-bottom: 20%;
            position: relative;
            text-align: center;
            color: #fff;
            overflow: hidden;
            padding: 70px 0;
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

            .hero-content h1 {
                font-size: 3em;
                margin-bottom: 20px;
            }

            .hero-content p {
                font-size: 1.2em;
                margin-bottom: 30px;
            }

        .meet-section {
            background-color: rgb(7, 8, 23) !important;
            padding: 50px 0 50px 0;
            margin-bottom: 30px;
        }

        .meet-content {
            margin: 0 8%;
        }

            .meet-content h1 {
                font-size: 50px;
                margin-bottom: 0;
            }

            .meet-content p {
                font-size: 20px;
                margin-bottom: 30px;
                margin-top: 0;
            }

        .member-container {
            background-color: black;
            display: inline-block;
            padding: 30px;
            margin-right: 15px;
            border-radius: 30px;
        }

        .member-container-even {
            background-color: black;
            display: inline-block;
            padding: 30px;
            margin-right: 15px;
            border-radius: 30px;
            transform: translateY(60px);
        }

        .member-container-last {
            background-color: black;
            display: inline-block;
            padding: 30px;
            transform: translateY(60px);
            border-radius: 30px;
        }

        .member-img {
            width: 235px;
            height: 235px;
            border-radius: 20px;
            transition: all 0.5s;
        }

            .member-img:hover {
               transform: translateY(-60px);
                transition: all 0.5s;
            }

        .btn {
            display: block;
            text-align: center;
            margin: 9% auto 0% auto;
            font-size: 20px;
            border-radius: 20px;
            padding: 15px 25px;
            cursor: pointer;
            background-color: #020470;
            color: white;
            border: 0px;
            transition: all 0.5s;
        }

            .btn:hover {
                transform: translateY(-10px);
                transition: all 0.5s;
            }



        .slider-ctr {
            width: 1500px;
            height: 550px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -220px;
            margin-left: -750px;
            border-radius: 5px;
            overflow: hidden;
            animation: 2s enter-animation;
        }

            .slider-ctr:after {
                content: "";
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                pointer-events: none;
                z-index: 9;
            }

        .slide {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            transition: 0.45s all cubic-bezier(0.65, 0.05, 0.36, 1);
            clip-path: inset(0 0 0 0);
        }

            .slide:before {
                content: "";
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                left: 0;
                background: rgba(0, 0, 0, 0.125);
            }

            .slide.slide-on {
                clip-path: inset(0 100% 0 0);
            }

            .slide.text-on .title {
                transition: 0.3s all cubic-bezier(0.65, 0.05, 0.36, 1) 0.45s;
                clip-path: inset(0 0 0 0);
            }

            .slide.text-on .author {
                transition: 0.3s all cubic-bezier(0.65, 0.05, 0.36, 1) 0.6s;
                clip-path: inset(0 0 0 0);
            }

            .slide .imgg {
                display: block;
                width: 1600px;
                height: 550px;
            }

            .slide figcaption {
                position: absolute;
                top: 30px;
                left: 30px;
            }

            .slide .title {
                font-size: 50px;
                margin-bottom: 2px;
                color: white;
                transition: 0.3s all cubic-bezier(0.65, 0.05, 0.36, 1) 0.45s;
                clip-path: inset(0 0 0 100%);
                font-weight: 400;
                letter-spacing: 10px;
                text-transform: uppercase;
                position: relative;
            }


            .slide .author {
                font-size: 16px;
                color: white;
                opacity: .8;
                transition: 0.3s all cubic-bezier(0.65, 0.05, 0.36, 1) 0.45s;
                clip-path: inset(0 0 0 100%);
                font-weight: 300;
                letter-spacing: 3px;
                position: relative;
                z-index: 9;
            }



        .slider-control {
            position: absolute;
            right: 60px;
            bottom: 30px;
            width: 80px;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 3px 3px 3px rgba(0, 0, 0, 0.15);
            z-index: 99;
        }

            .slider-control .control:hover {
                background: #0031b7;
            }

            .slider-control .control {
                width: 50%;
                height: 40px;
                display: block;
                float: left;
                text-align: center;
                line-height: 40px;
                cursor: pointer;
                transition: .3s all ease;
                background: white;
            }

                .slider-control .control .icon {
                    color: black;
                    pointer-events: none;
                    transition: .3s all ease;
                }

                .slider-control .control.disabled {
                    pointer-events: none;
                    background: #ddd;
                }

                    .slider-control .control.disabled .icon {
                        opacity: .5;
                    }

        /*top button*/
        .topbtn {
            display: none; /* Hidden by default */
            position: fixed;
            bottom: 100px;
            right: 35px;
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: transparent;
            color: white;
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 10px;
            border-radius: 75%;
            transition: all 0.5s ease;
        }

            .topbtn:hover {
                padding-bottom: 25px;
            }

        /*down button*/
        .downbtn {
            transform: rotate(180deg);
            display: none; /* Hidden by default */
            position: fixed;
            bottom: 45px;
            right: 35px;
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: transparent;
            color: white;
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 10px;
            border-radius: 75%;
            transition: all 0.5s ease;
            padding-top: 20px;
        }

            .downbtn:hover {
                padding-top: 0px;
            }

        #arrow {
            font-size: 35px;
        }

        .event-container {
            margin: 0 8%;
            padding-top: 5%;
            padding-bottom: 13%;
        }

        .word-content {
            display: inline-block;
            width: 43%;
            margin-right: 10%;
            transform: translateY(-160px);
        }

        .image-content {
            display: inline-block;
            width: 45%;
        }

        .contentImg {
            transition: all 0.5s;
        }

            .contentImg:hover {
                opacity: 70%;
                transition: all 0.5s;
            }



        .title-and-map {
            background-color: rgb(7, 8, 23) !important;
            padding: 100px 0 100px 0;
        }

        .contentMap {
            margin: 0 8%;
        }

        .map {
            display: inline-block;
            width: 40%;
        }

        .titleWord {
            display: inline-block;
            width: 40%;
            transform: translateY(-80px);
        }

        .map {
            width: 50%;
            text-align: center;
        }

            .map iframe {
                border-radius: 11%;
                border: none;
            }


        .titleWord h1 {
            font-size: 60px;
            text-align: center;
        }

            .titleWord h1::after {
                content: '';
                display: block;
                background-color: white;
                height: 3px;
                width: 52.5%;
                margin: 0 auto; /* always in middle*/
            }

        .titleWord .content3-subtitle {
            width: 90%;
            padding-left: 18%;
            margin-top: 5%;
        }

            .titleWord .content3-subtitle p {
                font-size: 32px;
            }

        .contact-us {
            margin-top: 2%;
        }

        .content3-subtitle .contact-us a {
            margin: 2%;
            text-decoration: none;
            color: white;
            font-weight: normal;
            display: inline-block;
            font-size: 18px;
        }

            .content3-subtitle .contact-us a::after {
                content: '';
                display: block;
                width: 0%;
                height: 3px;
                transition: 0.47s;
                margin-top: 1%;
            }

            .content3-subtitle .contact-us a:hover::after {
                width: 64%;
                background-color: rgb(19, 78, 144);
            }

        .content3-subtitle .contact-us i {
            margin-top: 4%;
        }

        .map {
            width: 50%;
            text-align: center;
        }

            .map iframe {
                border-radius: 11%;
                border: none;
            }

            .joinus{
                 margin: 0 8%;
                 padding: 150px 0;
            }

            .joinus-word{
                display:inline-block;
                width:55%;
            }
            .joinusImg{
                width:40%;
            }
    </style>
    <asp:LinkButton CssClass="topbtn" ID="topbtn" runat="server" ClientIDMode="static" OnClientClick="topFunction();return false"><i id="arrow" class="fa-solid fa-chevron-up"></i></asp:LinkButton>
    <asp:LinkButton CssClass="downbtn" ID="downbtn" runat="server" ClientIDMode="static" OnClientClick="downFunction();return false"><i id="arrow" class="fa-solid fa-chevron-up"></i></asp:LinkButton>
    <div class="slider-ctr container">
        <figure class="slide">
            <asp:Image ID="Image5" runat="server" ImageUrl="~/images/slide4.jpg" CssClass="imgg" />
            <figcaption>
                <div class="title" style="color: white; background-color: #3535359b;">Sport</div>
                <div class="author" style="color: white; background-color: #3535359b;">Feel the Thrill of Sporting</div>
            </figcaption>
        </figure>
        <figure class="slide">
            <asp:Image ID="Image4" runat="server" ImageUrl="~/images/slide3.jpg" CssClass="imgg" />
            <figcaption>
                <div class="title">Learn</div>
                <div class="author">Knowledge is the Key</div>
            </figcaption>
        </figure>
        <figure class="slide">
            <asp:Image ID="Image6" runat="server" ImageUrl="~/images/slide2.jpg" CssClass="imgg" />
            <figcaption>
                <div class="title">Party</div>
                <div class="author">Word Hard Play Hard</div>
            </figcaption>
        </figure>
        <figure class="slide text-on">
            <asp:Image ID="Image7" runat="server" ImageUrl="~/images/slide1.jpg" CssClass="imgg" />
            <figcaption>
                <div class="title">Listen</div>
                <div class="author">Do more listening than talking</div>
            </figcaption>
        </figure>
        <div class="slider-control">
            <div class="control prev disabled">
                <div class="icon ion-chevron-left"><i class="fa fa-arrow-left" aria-hidden="true"></i></div>
            </div>
            <div class="control next">
                <div class="icon ion-chevron-right"><i class="fa fa-arrow-right" aria-hidden="true"></i></div>
            </div>
        </div>
    </div>
    <div class="hero-section container">

        <div class="hero-content">
            <h1>EVENTY. Event Management | All about event</h1>
            <p>Explore the world and join us in exciting events and activities!</p>
        </div>
    </div>

    <div class="meet-section container">

        <div class="meet-content">
            <h1>Meet Our Team</h1>
            <p>The Initiator of Everything</p>
            <div class="member-container">

                <asp:Image CssClass="member-img" ID="Image1" runat="server" ImageUrl="~/images/member0.jpg" />
                <h2>Ng Chong Jian</h2>
                <p>Founder & CEO</p>
            </div>
            <div class="member-container-even">

                <asp:Image CssClass="member-img" ID="Image2" runat="server" ImageUrl="~/images/member111.jpg" />
                <h2>Lim Yi Jie</h2>
                <p>Chief Operating Officer</p>
            </div>

            <div class="member-container">

                <asp:Image CssClass="member-img" ID="Image8" runat="server" ImageUrl="~/images/member12.jpg" />
                <h2>Yew Zi Yu</h2>
                <p>Chief Technology Officer</p>
            </div>
            <div class="member-container-last">

                <asp:Image CssClass="member-img" ID="Image3" runat="server" ImageUrl="~/images/member13.jpg" />
                <h2>Lim Shi Lei</h2>
                <p>Chief Technology Officer</p>
            </div>


        </div>
        <asp:Button CssClass="btn" ID="Button1" runat="server" Text="Learn More" PostBackUrl="~/userAboutUs.aspx" />
    </div>
    <div class="event-container container">
        <div class="word-content">

            <h1 style="font-size: 35px;">Browse and Enjoy your Event Now!</h1>
            <p>Any kind of Events you can ever thought of.</p>
            <asp:Button CssClass="btn word-btn" ID="Button2" runat="server" Text="Browse" PostBackUrl="~/userEvent.aspx" />
        </div>
        <div class="image-content">
            <asp:Image CssClass="contentImg" ID="Image9" runat="server" ImageUrl="~/images/contentImg1.jpg" />
            <asp:Image CssClass="contentImg" ID="Image10" runat="server" ImageUrl="~/images/contentImg2.jpg" />
            <asp:Image CssClass="contentImg" ID="Image11" runat="server" ImageUrl="~/images/contentImg3.jpg" />
            <asp:Image CssClass="contentImg" ID="Image12" runat="server" ImageUrl="~/images/contentImg4.jpg" />
            <asp:Image CssClass="contentImg" ID="Image13" runat="server" ImageUrl="~/images/contentImg5.jpg" />
        </div>
    </div>

    <div class="content3 ">

        <div class="container">
        <div class="title-and-map">
            <div class="contentMap">
                <div class="map">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1254.7362970560062!2d101.72766104472474!3d3.214909704189882!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31cc3843bfb6a031%3A0x2dc5e067aae3ab84!2sTunku%20Abdul%20Rahman%20University%20College%20(TAR%20UC)!5e0!3m2!1sen!2smy!4v1660827650587!5m2!1sen!2smy"
                        width="425" height="425" style="" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
                <div class="titleWord">
                    <h1>Find Us Here</h1>
                    <div class="content3-subtitle">
                        <p>Contact Us Now :</p>
                        <div class="contact-us">
                            <i class="fa-solid fa-envelope"></i>
                            <a href="mailto:eventyofficial@gmail.com">eventyofficial@gmail.com</a>
                            <br>
                            <i class="fa-solid fa-phone"></i>
                            <a href="tel:+60149034682">+60149034682</a>
                        </div>
                    </div>
                </div>
                </div>
            </div>

        </div>
    </div>
    <div class="joinus container">
            <asp:Image CssClass="joinusImg" ID="Image14" runat="server" ImageUrl="~/images/joinus.jpg" />
        <div class="joinus-word">
        <h1>What are you waiting for? Get Your Account Right Now!</h1>
                  
          
            <asp:Button CssClass="btn word-btn" ID="Button3" runat="server" Text="Register" PostBackUrl="~/memberRegister.aspx" />
         </div>
       
      
            
    </div>


    <script>

        // buttons
        var sliderControl = document.querySelector(".slider-control");
        // slides informations
        var slides = document.querySelectorAll(".slide"),
            slidesLength = slides.length;
        // slides array
        var slidesArr = [].slice.call(slides);
        // reverse array sorting
        slidesArr = slidesArr.reverse();
        // slide current
        var slideCurrent = 0;
        sliderControl.addEventListener("click", function (e) {
            target = e.target;

            // get next button
            if (target.classList.contains("next")) {
                next = e.target,
                    prev = next.previousElementSibling,
                    nextSlide = slidesArr[slideCurrent + 1],
                    slide = slidesArr[slideCurrent];

                slide.classList.add("slide-on");
                slide.classList.remove("text-on");
                nextSlide.classList.add("text-on");

                slideCurrent += 1;

                if (slideCurrent > 0) {
                    prev.classList.remove("disabled");
                }

                if (slideCurrent === slidesLength - 1) {
                    next.classList.add("disabled");
                }
            }

            // get prev button
            if (target.classList.contains("prev")) {

                slideCurrent -= 1;

                prev = e.target,
                    next = prev.nextElementSibling,
                    prevSlide = slidesArr[slideCurrent + 1],
                    slide = slidesArr[slideCurrent];

                prevSlide.classList.remove("text-on");
                slide.classList.remove("slide-on");
                slide.classList.add("text-on");

                if (slideCurrent === slidesLength - 2) {
                    next.classList.remove("disabled");
                }
                if (slideCurrent === 0) {
                    prev.classList.add("disabled");
                }

            }
        });



        var topbtn = document.getElementById("topbtn");
        var downbtn = document.getElementById("downbtn");

        window.onscroll = function () {
            scrollFunction();
        };

        function scrollFunction() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                topbtn.style.display = "none";
                downbtn.style.display = "block";
            }

            if ((document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) && (document.body.scrollTop < 4000 || document.documentElement.scrollTop < 4000)) {
                topbtn.style.display = "block";
                downbtn.style.display = "block";
            }


            if (document.body.scrollTop > 4000 || document.documentElement.scrollTop > 4000) {
                topbtn.style.display = "block";
                downbtn.style.display = "none";
            }



        }

        function topFunction() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function downFunction() {
            window.scrollTo({ top: 7000, behavior: 'smooth' });
        }

       
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
