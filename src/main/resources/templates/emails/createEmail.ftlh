<#import "../layout.ftlh" as main>
<@main.layout>
<div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
    <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">

    <h2 class="text-center">Create Email</h2>

        <#if error??>
            <div id="confirm-message" class="alert alert-danger transparent" role="alert">
                ${error}
                <button type="button" class="btn btn-primary" onclick="hideConfirmMessage()">OK</button>
            </div>
        </#if>


        <form id="emailForm" action="/emails/create" method="post" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" class="form-control transparent" id="email" name="email" required>
                <div class="invalid-feedback">
                    Please provide a valid email address.
                </div>
            </div>

            <div class="mt-2 d-flex justify-content-center gap-2">
<#--                <button type="submit" class="btn btn-primary">Create</button>-->
<#--                <a href="/emails/all" class="btn btn-secondary mx-3">Cancel</a>-->
                <button type="submit" class="btn-add">Create</button>
                <a href="/emails/all" class="btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            const form = document.getElementById('emailForm');
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');

                const emailInput = document.getElementById('email');
                const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(emailInput.value)) {
                    emailInput.setCustomValidity('Invalid email address');
                    event.preventDefault();
                    event.stopPropagation();
                } else {
                    emailInput.setCustomValidity('');
                }
            }, false);
        });

        function hideConfirmMessage() {
            document.getElementById('confirm-message').style.display = 'none';
        }
    </script>

    <script src="/static/main.js"></script>

</@main.layout>
