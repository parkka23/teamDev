<#import "layout.ftlh" as main>
<@main.layout >


<#--        <div class="container text-center" style="width: 70%;">-->
<#--                <#if username??>-->
<#--                        <h1 style="color: rgba(0, 0, 0, 0.4); font-size: 50px">Welcome, ${username}!</h1>-->
<#--                <#else>-->
<#--                        <h1 style="color: rgba(0, 0, 0, 0.4); font-size: 50px">Welcome!</h1>-->
<#--                        <li>-->
<#--                                <a class="btn-primary m-2" href="/user/login">Login</a>-->
<#--                        </li>-->
<#--                </#if>-->
<#--        </div>-->

        <div class="container text-center" style="width: 70%;">
                <#if username??>
                        <h1 style="color: rgba(0, 0, 0, 0.4); font-size: 50px; margin-bottom: 20px;">Welcome, ${username}!</h1>
                <#else>
                        <h1 style="color: rgba(0, 0, 0, 0.4); font-size: 50px; margin-bottom: 20px;">Welcome!</h1>
                        <ul class="list-unstyled">
                                <li style="margin-bottom: 10px;">
                                        <a class="btn btn-primary m-2" href="/user/login">Login</a>
                                </li>

<#--                                <li style="margin-bottom: 10px;">-->
<#--                                        <a class="btn btn-primary m-2" href="/user/register">Register</a>-->
<#--                                </li>-->
                        </ul>
                </#if>
        </div>
</@main.layout>