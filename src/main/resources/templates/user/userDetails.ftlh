<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
    <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">

    <#if user??>

            <div >
<#--                <div class="card-header">-->
                    <h2 class="text-center">User Details</h2>
<#--                </div>-->
<#--                <div class="card-body transparent">-->
                <p><strong>Full Name:</strong> ${user.fullName} <a href="/user/update/fullName" class="btn-update mx-2">Update</a></p>

                <p><strong>Email:</strong> ${user.email} <a href="/user/update/email" class="btn-update mx-2">Update</a></p>
<#--            <p><strong>Password:</strong> ****** <a href="/user/update/password" class="btn-update mx-2">Update</a></p>-->
                <p><strong>Roles:</strong>
                        <#list user.roles as role>
                            ${role.name}<#if role_has_next>, </#if>
                        </#list>
                    <#if userRoles?seq_contains("ADMIN")>
                        <a href="/user/update/roles" class="btn-update mx-2">Update</a>
                        </#if>
                </p>
<#--                <div class="mt-2 d-flex justify-content-center w-100">-->
<#--                      <a href="/user/update/password" >Change Password</a>-->
<#--                        <a class="btn-primary m-2" href="/logout">Logout</a>-->
<#--                </div>-->
                <div class="container text-center" style="width: 70%;">
                    <div class="mt-2 d-flex flex-column align-items-center">
                        <a href="/user/update/password" style="margin-bottom: 10px;">Change Password</a>
                        <a class="btn btn-primary m-2" href="/logout">Logout</a>
                    </div>
                </div>

                <#--                </div>-->
            </div>
        <#else>
            <p>User details not available.</p>
        </#if>
    </div>
    </div>
</@main.layout>