<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
            <h2 class="text-center">Update Roles</h2>
            <form action="/user/update/roles/${user.id}" method="post" id="updateRolesForm" class="needs-validation" novalidate>
                <div class="form-group w-100">
                    <label for="roles">Roles:</label>
                    <#list roles as role>
                        <div class="form-check">
                            <input
                                    style="accent-color: var(--dark-grey)"
                                    class="form-check-input transparent"
                                    type="checkbox"
                                    name="roleIds"
                                    id="role_${role.name}"
                                    value="${role.name}"
                                    <#if user.roleIds?seq_contains(role.name)>checked</#if>>
                            <label class="form-check-label" for="role_${role.name}">
                                ${role.name}
                            </label>
                        </div>

                    </#list>
                    <div class="invalid-feedback" id="rolesErrorMessage">
                        Please select at least one role.
                    </div>
                </div>
                <div class="mt-2 d-flex justify-content-center gap-2">
                    <button type="submit" class="btn-add">Update</button>
                    <a href="/user/${user.id}" class="btn-cancel">Cancel</a>

                </div>
            </form>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.getElementById('updateRolesForm');
            const rolesErrorMessage = document.getElementById('rolesErrorMessage');

            form.addEventListener('submit', function(event) {
                let isValid = true;
                rolesErrorMessage.classList.remove('d-block');
                rolesErrorMessage.textContent = "";

                const checkboxes = document.getElementsByName("roleIds");
                let isChecked = false;
                for (let checkbox of checkboxes) {
                    if (checkbox.checked) {
                        isChecked = true;
                        break;
                    }
                }
                if (!isChecked) {
                    rolesErrorMessage.classList.add('d-block');
                    rolesErrorMessage.textContent = "Please select at least one role.";
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                    form.classList.add('was-validated');
                } else {
                    form.classList.add('was-validated');
                }

                // if (!form.checkValidity()) {
                //     event.preventDefault();
                //     form.classList.add('was-validated');
                // } else {
                //     form.classList.add('was-validated');
                // }
            });
        });
    </script>
</@main.layout>




