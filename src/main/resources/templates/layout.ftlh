<#macro layout>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"
              name="viewport">
        <meta content="ie=edge" http-equiv="X-UA-Compatible">
        <title>Http server Index page</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
              crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
        <link href="/static/css/style.css" rel="stylesheet">
    </head>

    <body >

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <li class="nav-wrapper__item">
            <a style="font-size: 24px" class="nav-wrapper__item-link" href="/home">
                <i class="bi bi-bell-fill orange-icon glow-orange"></i>
                <#--                <span class="gradient-text">NotifyMe</span>-->
                <i class="bi bi-bell-fill blue-icon glow-blue"></i><!-- Notification icon -->
            </a>
        </li>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto" id="buttons">
                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/home">Home</a>
                </li>

                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/services/all">Services</a>
                </li>

                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/chats/all">Telegram chats</a>
                </li>

                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/emails/all">Emails</a>
                </li>

                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/message/send">Message</a>
                </li>

                <li class="nav-wrapper__item">
                    <a class="nav-wrapper__item-link" href="/user/list">Users</a>
                </li>


            </ul>

            <ul class="navbar-nav ms-auto" id="auth-buttons-container">
            </ul>
        </div>
    </nav>

    <i class="m-5"></i>
    <div style="padding: 20px 55px;min-height: 300px">
        <#nested>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            function getUserFromLocalStorage() {
                const userData = localStorage.getItem('user');
                return userData ? JSON.parse(userData) : null;
            }
            // function fetchUserRoles() {
            //     fetch('/user/roles')
            //         .then(response => response.json())
            //         .then(data => {
            //             if (data.includes('ADMIN')) {
            //                 addUsersButton();
            //             }
            //         })
            //         .catch(error => console.error('Error fetching user roles:', error));
            // }

            function addUsersButton() {
                let usersButton = document.createElement('li');
                usersButton.className = 'nav-wrapper__item';
                usersButton.innerHTML = '<a class="nav-wrapper__item-link" id=users href="/user/list">Users</a>';
                let navbarNav = document.getElementById('buttons'); // Adjust this selector based on your HTML structure
                navbarNav.appendChild(usersButton);
            }
            let authButtonsContainer = document.getElementById('auth-buttons-container');

            // function addLogoutButton() {
            //     let logoutButton = document.createElement('li');
            //     logoutButton.className = 'nav-item';
            //     logoutButton.innerHTML = '<a class="btn-primary m-2" id="logout" href="#">Logout</a>';
            //     authButtonsContainer.appendChild(logoutButton);
            //     logoutButton.addEventListener('click', function (event) {
            //         event.preventDefault();
            //         if (confirm("Are you sure you want to logout?")) {
            //             localStorage.removeItem('user');
            //             window.location.href = "/logout";
            //         }
            //     });
            // }

            function addProfileButton() {
                let profileButton = document.createElement('li');
                profileButton.className = 'nav-item';
                // profileButton.innerHTML = '<a class="nav-link btn btn-outline-info m-2" id="profile" href="#">Profile</a>';
                profileButton.innerHTML = '<a class="btn-primary m-2" id="profile" href="/user/details">Profile</a>';
                //
                authButtonsContainer.appendChild(profileButton);
                profileButton.addEventListener('click', function (event) {
                    event.preventDefault();

                    window.location.href = "/user/details";

                });
            }

            let user = getUserFromLocalStorage();
            if (user) {
                // User is logged in
                // fetchUserRoles();
                // addLogoutButton();
                addProfileButton()
                console.log('Welcome, ' + user.username);
            }
            // else {
            //     // User is not logged in
            //     let loginButton = document.createElement('li');
            //     loginButton.className = 'nav-item';
            //     loginButton.innerHTML = '<a class="btn-primary m-2" href="/user/login">Login</a>';
            //     authButtonsContainer.appendChild(loginButton);
            //
            //     // let registerButton = document.createElement('li');
            //     // registerButton.className = 'nav-item';
            //     // registerButton.innerHTML = '<a class="btn-primary m-2" href="/user/register">Register</a>';
            //     // authButtonsContainer.appendChild(registerButton);
            //
            //     console.log('User not logged in');
            // }
        });

        function adjustBackgroundHeight() {
            var bodyHeight = document.body.scrollHeight + 'px';
            document.body.style.minHeight = bodyHeight;
        }

        // Call the function on page load and resize events
        window.onload = adjustBackgroundHeight;
        window.onresize = adjustBackgroundHeight;


    </script>
    </body>
    </html>
</#macro>



<#--<#macro layout>-->
<#--    <!DOCTYPE html>-->
<#--    <html lang="en">-->
<#--    <head>-->
<#--        <meta charset="UTF-8">-->
<#--        <meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"-->
<#--              name="viewport">-->
<#--        <meta content="ie=edge" http-equiv="X-UA-Compatible">-->
<#--        <title>Http server Index page</title>-->
<#--        <!-- Bootstrap CSS &ndash;&gt;-->
<#--        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">-->

<#--        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"-->
<#--              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"-->
<#--              crossorigin="anonymous">-->
<#--        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"-->
<#--                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"-->
<#--                crossorigin="anonymous"></script>-->
<#--        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">-->
<#--        <link href="/static/css/style.css" rel="stylesheet">-->
<#--    </head>-->

<#--    <body >-->

<#--    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">-->
<#--        <li class="nav-wrapper__item">-->
<#--            <a style="font-size: 24px" class="nav-wrapper__item-link" href="/home">-->
<#--                <i class="bi bi-bell-fill orange-icon glow-orange"></i>-->
<#--                 <i class="bi bi-bell-fill blue-icon glow-blue"></i><!-- Notification icon &ndash;&gt;-->
<#--            </a>-->
<#--        </li>-->
<#--        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"-->
<#--                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">-->
<#--            <span class="navbar-toggler-icon"></span>-->
<#--        </button>-->

<#--        <div class="collapse navbar-collapse" id="navbarSupportedContent">-->
<#--            <ul class="navbar-nav mr-auto" id="buttons">-->
<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/home">Home</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/services/all">Services</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/chats/all">Telegram chats</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/emails/all">Emails</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/message/send">Message</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/user/list">Users</a>-->
<#--                </li>-->

<#--                <li class="nav-wrapper__item">-->
<#--                    <a class="nav-wrapper__item-link" href="/emails/all">Emails</a>-->
<#--                </li>-->

<#--            </ul>-->

<#--            <ul class="navbar-nav ms-auto" id="auth-buttons-container">-->
<#--            </ul>-->
<#--        </div>-->
<#--    </nav>-->

<#--    <i class="m-5"></i>-->
<#--    <div style="padding: 20px 55px;min-height: 300px">-->
<#--        <#nested>-->
<#--    </div>-->

<#--    <script>-->
<#--        document.addEventListener('DOMContentLoaded', function () {-->
<#--            function getUserFromLocalStorage() {-->
<#--                const userData = localStorage.getItem('user');-->
<#--                return userData ? JSON.parse(userData) : null;-->
<#--            }-->

<#--            function addUsersButton() {-->
<#--                let usersButton = document.createElement('li');-->
<#--                usersButton.className = 'nav-wrapper__item';-->
<#--                usersButton.innerHTML = '<a class="nav-wrapper__item-link" id=users href="/user/list">Users</a>';-->
<#--                let navbarNav = document.getElementById('buttons'); // Adjust this selector based on your HTML structure-->
<#--                navbarNav.appendChild(usersButton);-->
<#--            }-->
<#--            let authButtonsContainer = document.getElementById('auth-buttons-container');-->

<#--            function addProfileButton() {-->
<#--                let profileButton = document.createElement('li');-->
<#--                profileButton.className = 'nav-item';-->
<#--                 profileButton.innerHTML = '<a class="btn-primary m-2" id="profile" href="/user/details">Profile</a>';-->

<#--                authButtonsContainer.appendChild(profileButton);-->
<#--                profileButton.addEventListener('click', function (event) {-->
<#--                    event.preventDefault();-->

<#--                    window.location.href = "/user/details";-->

<#--                });-->
<#--            }-->

<#--            let user = getUserFromLocalStorage();-->
<#--            if (user) {-->
<#--                addProfileButton()-->
<#--                console.log('Welcome, ' + user.username);-->
<#--            }-->
<#--        });-->

<#--        function adjustBackgroundHeight() {-->
<#--            var bodyHeight = document.body.scrollHeight + 'px';-->
<#--            document.body.style.minHeight = bodyHeight;-->
<#--        }-->

<#--        // Call the function on page load and resize events-->
<#--        window.onload = adjustBackgroundHeight;-->
<#--        window.onresize = adjustBackgroundHeight;-->


<#--    </script>-->
<#--    </body>-->
<#--    </html>-->
<#--</#macro>-->

