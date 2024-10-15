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

            <form action="/user/update/password" method="post" id="updatePasswordForm" class="needs-validation" novalidate>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control transparent" id="oldPassword" name="oldPassword" placeholder="Old Password" required style="padding-right: 2.5rem;">
                    <label for="oldPassword">Old Password</label>
                    <div class="invalid-feedback" id="oldPasswordError">
                        Please enter old password.
                    </div>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control transparent" id="newPassword" name="newPassword" placeholder="New Password" required style="padding-right: 2.5rem;">
                    <label for="newPassword">New Password</label>
                    <div class="invalid-feedback" id="newPasswordError">
                        Password must contain at least one uppercase letter, one number, and be alphanumeric. Length must be between 4 and 24 characters.
                    </div>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" class="form-control transparent" id="confirmPassword" placeholder="Confirm Password" required style="padding-right: 2.5rem;">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="invalid-feedback" id="confirmPasswordError">
                        Passwords do not match.
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
            const form = document.getElementById('updatePasswordForm');
            const oldPassword = document.getElementById('oldPassword');
            const newPassword = document.getElementById('newPassword');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{4,24}$/;

            form.addEventListener('submit', function(event) {
                let isValid = true;
                oldPassword.setCustomValidity("");
                confirmPassword.setCustomValidity("");
                newPassword.setCustomValidity("");

                // Old password validation
                if (oldPassword.value.trim() === "") {
                    oldPassword.setCustomValidity("Please enter old password.");
                    isValid = false;
                }

                // New password validation
                if (!passwordRegex.test(newPassword.value)) {
                    newPassword.setCustomValidity("Password must contain at least one uppercase letter, one number, and be alphanumeric. Length must be between 4 and 24 characters.");
                    isValid = false;
                }

                // Confirm password validation
                if (newPassword.value !== confirmPassword.value) {
                    confirmPassword.setCustomValidity("Passwords do not match.");
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                    form.classList.add('was-validated');
                } else {
                    form.classList.add('was-validated');
                }
            });
        });
    </script>
</@main.layout>
