<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-sm bg-white rounded">-->
<#--            <h2 class="text-center">Update Email</h2>-->
<#--            <#if updateError?exists>-->
<#--                <div class="alert alert-danger" role="alert">-->
<#--                    ${updateError}-->
<#--                </div>-->
<#--            </#if>-->

<#--            <form action="/user/update/email" method="post" id="updateEmailForm" class="needs-validation" novalidate>-->
<#--                <div class="form-floating mb-3">-->
<#--                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" placeholder="New Email Address" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">-->
<#--                    <label for="email">New Email Address</label>-->
<#--                    <div class="invalid-feedback">-->
<#--                        Please enter a valid email address.-->
<#--                    </div>-->
<#--                </div>-->
<#--                <div class="mt-2 d-flex justify-content-center">-->
<#--                    <button type="submit" class="btn btn-outline-primary">Update Email</button>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->
<#--    <script>-->
<#--        document.addEventListener('DOMContentLoaded', () => {-->
<#--            const form = document.getElementById('updateEmailForm');-->
<#--            const email = document.getElementById('email');-->
<#--            const emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/i;-->

<#--            form.addEventListener('submit', function(event) {-->
<#--                if (!emailRegex.test(email.value)) {-->
<#--                    email.setCustomValidity('Please enter a valid email address.');-->
<#--                } else {-->
<#--                    email.setCustomValidity('');-->
<#--                }-->

<#--                if (!form.checkValidity()) {-->
<#--                    event.preventDefault();-->
<#--                    form.classList.add('was-validated');-->
<#--                } else {-->
<#--                    form.classList.add('was-validated');-->
<#--                }-->
<#--            });-->
<#--        });-->
<#--    </script>-->
<#--</@main.layout>-->


<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
            <h2 class="text-center">Update Email</h2>
            <#if updateError?exists>
                <div class="alert alert-danger transparent" role="alert">
                    ${updateError}
                </div>
            </#if>

            <form action="/user/update/email" method="post" id="updateEmailForm" class="needs-validation" novalidate>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control transparent" id="email" name="email" value="${user.email!''}" placeholder="New Email Address" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                    <label for="email">New Email Address</label>
                    <div class="invalid-feedback">
                        Please enter a valid email address.
                    </div>
                </div>
                <div class="mt-2 d-flex justify-content-center gap-2">
                    <button type="submit" class="btn-add">Update</button>
                    <a href="/user/details" class="btn-cancel">Cancel</a>

                </div>
            </form>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.getElementById('updateEmailForm');
            const email = document.getElementById('email');
            const emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/i;

            form.addEventListener('submit', function(event) {
                if (!emailRegex.test(email.value)) {
                    email.setCustomValidity('Please enter a valid email address.');
                } else {
                    email.setCustomValidity('');
                }

                if (!form.checkValidity()) {
                    event.preventDefault();
                    form.classList.add('was-validated');
                } else {
                    form.classList.add('was-validated');
                }
            });
        });
    </script>
</@main.layout>
