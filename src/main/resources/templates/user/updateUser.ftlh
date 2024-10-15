<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-sm bg-white rounded">
            <h2 class="text-center">Update Profile</h2>

            <#if updateError?exists>
                <div class="alert alert-danger " role="alert">
                    ${updateError}
                </div>
            </#if>

            <form action="/user/profile/update" method="post" id="updateProfileForm" class="needs-validation d-flex flex-column align-items-center" novalidate>
                <div class="form-floating mb-3 w-100">
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${user.fullName}" placeholder="Full Name" required>
                    <label for="fullName">Full Name</label>
                    <div class="invalid-feedback">
                        Please enter your full name.
                    </div>
                </div>

                <div class="form-floating mb-3 w-100">
                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" placeholder="name@example.com" required readonly>
                    <label for="email">Email address</label>
                    <div class="invalid-feedback">
                        Please enter a valid email address.
                    </div>
                </div>

                <div class="form-floating mb-3 position-relative w-100">
                    <input type="password" class="form-control" id="password" name="password" placeholder="New Password" style="padding-right: 2.5rem;">
                    <label for="password">New Password</label>
                    <div class="invalid-feedback" id="passwordError">
                        Password must contain at least one uppercase letter, one number, and be alphanumeric. Length must be between 4 and 24 characters.
                    </div>
                </div>

                <div class="form-floating mb-3 position-relative w-100">
                    <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm New Password" style="padding-right: 2.5rem;">
                    <label for="confirmPassword">Confirm New Password</label>
                    <div class="invalid-feedback" id="confirmPasswordError">
                        Passwords do not match.
                    </div>
                </div>

                <div class="form-group w-100">
                    <label for="roles">Roles:</label>
                    <div id="rolesErrorMessage" class="text-danger"></div>
                    <#list roles as role>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="roleIds" id="role_${role.name}" value="${role.name}" <#if role.name?seq_contains(user.roles??)>checked</#if>>
                            <label class="form-check-label" for="role_${role.name}">
                                ${role.name}
                            </label>
                        </div>
                    </#list>
                    <div class="invalid-feedback" id="rolesError" style="font-size: 0.875rem;">
                        Please select at least one role.
                    </div>
                </div>

                <div class="mt-2 d-flex justify-content-center w-100">
                    <button type="submit" class="btn btn-outline-primary">Update Profile</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.getElementById('updateProfileForm');
            const fullName = document.getElementById('fullName');
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordError = document.getElementById('passwordError');
            const confirmPasswordError = document.getElementById('confirmPasswordError');
            const rolesErrorMessage = document.getElementById('rolesErrorMessage');
            const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{4,24}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            form.addEventListener('submit', function (event) {
                let isValid = true;

                // Clear previous custom validity messages
                fullName.setCustomValidity("");
                email.setCustomValidity("");
                password.setCustomValidity("");
                confirmPassword.setCustomValidity("");
                rolesErrorMessage.textContent = "";

                // Full name validation
                if (fullName.value.trim() === "") {
                    fullName.setCustomValidity("Please enter your full name.");
                    isValid = false;
                }

                // Email validation
                if (email.value.trim() === "" || !emailRegex.test(email.value)) {
                    email.setCustomValidity("Please enter a valid email address.");
                    isValid = false;
                }

                // Password validation
                if (password.value && !passwordRegex.test(password.value)) {
                    password.setCustomValidity("Password must contain at least one uppercase letter, one number, and be alphanumeric. Length must be between 4 and 24 characters.");
                    isValid = false;
                }

                // Confirm password validation
                if (password.value && password.value !== confirmPassword.value) {
                    confirmPassword.setCustomValidity("Passwords do not match.");
                    isValid = false;
                }

                // Roles validation
                const checkboxes = document.getElementsByName("roleIds");
                let isChecked = false;
                for (let checkbox of checkboxes) {
                    if (checkbox.checked) {
                        isChecked = true;
                        break;
                    }
                }
                if (!isChecked) {
                    rolesErrorMessage.textContent = "Please select at least one role.";
                    isValid = false;
                }

                // Show validity messages for invalid fields
                if (!isValid) {
                    event.preventDefault();
                    form.classList.add('was-validated');
                } else {
                    form.classList.add('was-validated');
                }
            });

            // Toggle password visibility
            document.getElementById('togglePassword').addEventListener('click', function () {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('bi-eye');
                this.classList.toggle('bi-eye-slash');
            });

            document.getElementById('toggleConfirmPassword').addEventListener('click', function () {
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                this.classList.toggle('bi-eye');
                this.classList.toggle('bi-eye-slash');
            });
        });
    </script>
</@main.layout>
