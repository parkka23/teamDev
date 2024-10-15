<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
            <h2 class="text-center">Update Full Name</h2>
            <form action="/user/update/fullName" method="post" id="updateFullNameForm" class="needs-validation" novalidate>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control transparent" id="fullName" name="fullName" value="${user.fullName}" placeholder="Full Name" required>
                    <label for="fullName">Full Name</label>
                    <div class="invalid-feedback">
                        Please enter your full name.
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
            const fullNameField = document.getElementById('fullName');
            const updateFullNameForm = document.getElementById('updateFullNameForm');

            updateFullNameForm.addEventListener('submit', function (event) {
                if (fullNameField.value.trim() === "" || fullNameField.value.trim().length === 0) {
                    fullNameField.setCustomValidity("Please enter your full name.");
                    event.preventDefault();
                    event.stopPropagation();
                } else {
                    fullNameField.setCustomValidity("");
                }

                updateFullNameForm.classList.add('was-validated');
            });
        });
    </script>
</@main.layout>
