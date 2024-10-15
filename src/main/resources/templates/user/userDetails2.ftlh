<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
    <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
    <#if user??>
            <div >
                <h2 class="text-center">User Details</h2>
                <p><strong>Full Name:</strong> ${user.fullName}
<#--                    <a href="/user/update/fullName" class="btn-update mx-2">Update</a>-->
                </p>
                <p><strong>Email:</strong> ${user.email}
<#--                    <a href="/user/update/email" class="btn-update mx-2">Update</a>-->
                </p>
                <p><strong>Roles:</strong>
                        <#list user.roles as role>
                            ${role.name}<#if role_has_next>, </#if>
                        </#list>
                    <#if userRoles?seq_contains("ADMIN")>
                        <a href="/user/update/roles/${user.id}" class="btn-update mx-2">Update</a>
                        </#if>
                </p>
            </div>
        <#else>
            <p>User details not available.</p>
        </#if>
    </div>
    </div>
</@main.layout>