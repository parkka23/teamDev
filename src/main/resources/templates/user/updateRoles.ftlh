<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-sm bg-white rounded">-->
<#--            <h2 class="text-center">Update User Roles</h2>-->
<#--            &lt;#&ndash;            <form action="/user/update/email" method="post" id="updateEmailForm" class="needs-validation" novalidate>&ndash;&gt;-->
<#--&lt;#&ndash;                <div class="form-floating mb-3">&ndash;&gt;-->
<#--&lt;#&ndash;                    <input type="email" class="form-control" id="email" name="email" placeholder="New Email Address" required>&ndash;&gt;-->
<#--&lt;#&ndash;                    <label for="email">New Email Address</label>&ndash;&gt;-->
<#--&lt;#&ndash;                    <div class="invalid-feedback">&ndash;&gt;-->
<#--&lt;#&ndash;                        Please enter a valid email address.&ndash;&gt;-->
<#--&lt;#&ndash;                    </div>&ndash;&gt;-->
<#--&lt;#&ndash;                </div>&ndash;&gt;-->
<#--&lt;#&ndash;                <div class="mt-2 d-flex justify-content-center">&ndash;&gt;-->
<#--&lt;#&ndash;                    <button type="submit" class="btn btn-outline-primary">Update Email</button>&ndash;&gt;-->
<#--&lt;#&ndash;                </div>&ndash;&gt;-->
<#--&lt;#&ndash;            </form>&ndash;&gt;-->


<#--&lt;#&ndash;            <form action="/update/roles" method="post">&ndash;&gt;-->
<#--&lt;#&ndash;                <div class="form-group w-100">&ndash;&gt;-->
<#--&lt;#&ndash;                    <label for="roles">Roles:</label>&ndash;&gt;-->
<#--&lt;#&ndash;                    <div class="invalid-feedback" id="rolesErrorMessage">&ndash;&gt;-->
<#--&lt;#&ndash;                        Please select at least one role.&ndash;&gt;-->
<#--&lt;#&ndash;                    </div>&ndash;&gt;-->
<#--&lt;#&ndash;                    <#list roles as role>&ndash;&gt;-->
<#--&lt;#&ndash;                        <div class="form-check">&ndash;&gt;-->
<#--&lt;#&ndash;                            <input style="accent-color: var(--dark-grey)" class="form-check-input transparent" type="checkbox" name="roleIds" id="role_${role.name}" value="${role.name}"&ndash;&gt;-->
<#--&lt;#&ndash;                                    <#if user.roles?seq_contains(role)>&ndash;&gt;-->
<#--&lt;#&ndash;                                        checked&ndash;&gt;-->
<#--&lt;#&ndash;                                    </#if>&ndash;&gt;-->
<#--&lt;#&ndash;                            >&ndash;&gt;-->
<#--&lt;#&ndash;                            <label class="form-check-label" for="role_${role.name}">&ndash;&gt;-->
<#--&lt;#&ndash;                                ${role.name}&ndash;&gt;-->
<#--&lt;#&ndash;                            </label>&ndash;&gt;-->
<#--&lt;#&ndash;                        </div>&ndash;&gt;-->
<#--&lt;#&ndash;                    </#list>&ndash;&gt;-->
<#--&lt;#&ndash;                </div>&ndash;&gt;-->
<#--&lt;#&ndash;                <button type="submit" class="btn-add">Update Roles</button>&ndash;&gt;-->
<#--&lt;#&ndash;            </form>&ndash;&gt;-->


<#--            <form action="/user/update/roles" method="post" id="updateRolesForm" class="needs-validation" novalidate>-->
<#--                <div class="form-group w-100">-->
<#--                    <label for="roles">Roles:</label>-->
<#--                    <div class="invalid-feedback" id="rolesErrorMessage">-->
<#--                        Please select at least one role.-->
<#--                    </div>-->
<#--                    <#list roles as role>-->
<#--                        <div class="form-check">-->
<#--                            <input-->
<#--                                    style="accent-color: var(--dark-grey)"-->
<#--                                    class="form-check-input transparent"-->
<#--                                    type="checkbox"-->
<#--                                    name="roleIds"-->
<#--                                    id="role_${role.name}"-->
<#--                                    value="${role.name}"-->
<#--                                    <#if role.name?seq_contains(user.roleIds)>checked</#if>>-->
<#--                            <label class="form-check-label" for="role_${role.name}">-->
<#--                                ${role.name}-->
<#--                            </label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div class="mt-2 d-flex justify-content-center">-->
<#--                    <button type="submit" class="btn-add">Update Roles</button>-->
<#--                </div>-->
<#--            </form>-->

<#--        </div>-->
<#--    </div>-->
<#--    <script>-->
<#--        document.addEventListener('DOMContentLoaded', () => {-->
<#--            const form = document.getElementById('updateRolesForm');-->

<#--            form.addEventListener('submit', function(event) {-->
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



<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">-->
<#--            <h2 class="text-center">Update Roles</h2>-->
<#--            <form action="/user/update/roles" method="post" id="updateRolesForm" class="needs-validation" novalidate>-->
<#--                <div class="form-group w-100">-->
<#--                    <label for="roles">Roles:</label>-->
<#--                    <div class="invalid-feedback" id="rolesErrorMessage">-->
<#--                        Please select at least one role.-->
<#--                    </div>-->
<#--                    <#list roleIds as roleId>-->
<#--                        <div class="form-check">-->
<#--                            <input-->
<#--                                    style="accent-color: var(--dark-grey)"-->
<#--                                    class="form-check-input transparent"-->
<#--                                    type="checkbox"-->
<#--                                    name="roleIds"-->
<#--                                    id="role_${roleId}"-->
<#--                                    value="${roleId}"-->
<#--                                    <#if user.roleIds?seq_contains(roleId)>checked</#if>>-->
<#--                            <label class="form-check-label" for="role_${roleId}">-->
<#--                                ${roleId}-->
<#--                            </label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div class="mt-2 d-flex justify-content-center">-->
<#--                    <button type="submit" class="btn-add">Update Roles</button>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->
<#--    <script>-->
<#--        document.addEventListener('DOMContentLoaded', () => {-->
<#--            const form = document.getElementById('updateRolesForm');-->

<#--            form.addEventListener('submit', function(event) {-->
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
            <h2 class="text-center">Update Roles</h2>
            <form action="/user/update/roles" method="post" id="updateRolesForm" class="needs-validation" novalidate>
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
                    <a href="/user/details" class="btn-cancel">Cancel</a>

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


















<#--&lt;#&ndash;<#import "../layout.ftlh" as main>&ndash;&gt;-->
<#--&lt;#&ndash;<@main.layout>&ndash;&gt;-->
<#--&lt;#&ndash;    <div class="container mt-5">&ndash;&gt;-->
<#--&lt;#&ndash;        <h2>Update User Roles</h2>&ndash;&gt;-->
<#--&lt;#&ndash;        <form action="/update/roles" method="post">&ndash;&gt;-->
<#--&lt;#&ndash;            <div class="form-group w-100">&ndash;&gt;-->
<#--&lt;#&ndash;                <label for="roles">Roles:</label>&ndash;&gt;-->
<#--&lt;#&ndash;                <div class="invalid-feedback" id="rolesErrorMessage">&ndash;&gt;-->
<#--&lt;#&ndash;                    Please select at least one role.&ndash;&gt;-->
<#--&lt;#&ndash;                </div>&ndash;&gt;-->
<#--&lt;#&ndash;                <#list roles as role>&ndash;&gt;-->
<#--&lt;#&ndash;                    <div class="form-check">&ndash;&gt;-->
<#--&lt;#&ndash;                        <input style="accent-color: var(--dark-grey)" class="form-check-input transparent" type="checkbox" name="roleIds" id="role_${role.name}" value="${role.name}"&ndash;&gt;-->
<#--&lt;#&ndash;                                <#if user.roles?seq_contains(role)>&ndash;&gt;-->
<#--&lt;#&ndash;                                    checked&ndash;&gt;-->
<#--&lt;#&ndash;                                </#if>&ndash;&gt;-->
<#--&lt;#&ndash;                        >&ndash;&gt;-->
<#--&lt;#&ndash;                        <label class="form-check-label" for="role_${role.name}">&ndash;&gt;-->
<#--&lt;#&ndash;                            ${role.name}&ndash;&gt;-->
<#--&lt;#&ndash;                        </label>&ndash;&gt;-->
<#--&lt;#&ndash;                    </div>&ndash;&gt;-->
<#--&lt;#&ndash;                </#list>&ndash;&gt;-->
<#--&lt;#&ndash;            </div>&ndash;&gt;-->
<#--&lt;#&ndash;            <button type="submit" class="btn btn-primary mt-3">Update Roles</button>&ndash;&gt;-->
<#--&lt;#&ndash;        </form>&ndash;&gt;-->
<#--&lt;#&ndash;    </div>&ndash;&gt;-->
<#--&lt;#&ndash;</@main.layout>&ndash;&gt;-->