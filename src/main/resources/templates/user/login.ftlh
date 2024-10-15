<#import "../layout.ftlh" as main>
<@main.layout>
    <section class="d-flex align-items-center" style="margin-top: 30px;">
        <div class="container">
            <div class="d-flex justify-content-center align-items-center vh-80">
                <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg  rounded transparent" >
                    <h2 class="text-center">Login</h2>

                     <#if loginError??>
                            <div class="alert alert-danger transparent" role="alert">
                                ${loginError}
                            </div>
                        </#if>
                    <form action="/user/login" method="post" id="loginForm" class="needs-validation" novalidate>
                        <div class="form-floating mb-3 w-100 ">
                            <input type="email" name="username" id="form1Example13" required class="form-control transparent" placeholder="name@example.com">
                            <label for="form1Example13">Email address</label>
                            <div class="invalid-feedback">
                                Please enter a valid email address.
                            </div>
                        </div>

                        <div class="form-floating mb-3 w-100 ">
                            <input type="password" name="password" id="form1Example23" required class="form-control transparent" placeholder="Password">
                            <label for="form1Example23">Password</label>
                            <div class="invalid-feedback">
                                Please enter your password.
                            </div>
                        </div>
                        <div class="mt-2 d-flex justify-content-center w-100">
<#--                            <button type="submit" class="btn btn-outline-primary" style="text-decoration: none">Login</button>-->
                            <button type="submit" class="btn-secondary ">Login</button>

                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.getElementById('loginForm').addEventListener('submit', onLoginHandler)

            function onLoginHandler(event) {
                let form = event.target
                let userFormData = new FormData(form)
                let user = Object.fromEntries(userFormData)
                saveUser(user)
            }

            function saveUser(user) {
                let userAsJson = JSON.stringify(user);
                localStorage.setItem('user', userAsJson);
            }

        </script>
    </section>
</@main.layout>


