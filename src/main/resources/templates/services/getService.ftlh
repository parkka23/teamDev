<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Service Details</h2>-->

<#--        <div class="card-body">-->
<#--            <p class="card-text">-->
<#--                <strong>ID:</strong> ${service.id}<br>-->
<#--                <strong>Name:</strong> ${service.name}<br>-->
<#--                <strong>Send to:</strong>  <#if service.sendTo??>-->
<#--                ${service.sendTo}-->
<#--            <#else>-->
<#--                N/A-->
<#--                </#if><br>-->
<#--            </p>-->
<#--        </div>-->

<#--        <div class="mt-3">-->
<#--&lt;#&ndash;            <a href="/services/all" class="btn btn-primary">Back to Service List</a>&ndash;&gt;-->
<#--            <a href="/services/${service.id}/edit" class="btn btn-warning mx-2">Update</a>-->
<#--            <a href="/services/${service.id}/delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>-->
<#--        </div>-->


<#--            <div class="mt-3" style="display: flex; gap: 10px;">-->
<#--                <form action="/services/${service.id}/message-success" method="post">-->
<#--                    <input type="hidden" name="serviceId" value="${service.id}">-->
<#--                    <button type="submit" class="btn btn-success">Send Success Message</button>-->
<#--                </form>-->

<#--                <form action="/services/${service.id}/message-error" method="post">-->
<#--                    <input type="hidden" name="serviceId" value="${service.id}">-->
<#--                    <button type="submit" class="btn btn-danger">Send Error Message</button>-->
<#--                </form>-->
<#--            </div>-->

<#--        <div class="mt-5">-->
<#--            <h3>Chats</h3>-->
<#--            <a href="/services/${service.id}/add-chat" class="btn btn-primary">Add Chat</a>-->
<#--            <table class="table table-striped">-->
<#--                <thead>-->
<#--                <tr>-->
<#--                    <th>Chat ID</th>-->
<#--                    <th>Chat Name</th>-->
<#--                    <th>Action</th>-->
<#--                </tr>-->
<#--                </thead>-->
<#--                <tbody>-->
<#--                <#list service.chats as chat>-->
<#--                    <tr>-->
<#--                        <td>${chat.chatId}</td>-->
<#--                        <td>${chat.chatName}</td>-->
<#--                        <td>-->
<#--                            <form action="/services/${service.id}/delete-chat" method="post" style="display:inline;">-->
<#--                                <input type="hidden" name="chatId" value="${chat.chatId}">-->
<#--                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this chat?')">Delete</button>-->
<#--                            </form>-->
<#--                        </td>-->
<#--                    </tr>-->
<#--                </#list>-->
<#--                </tbody>-->
<#--            </table>-->
<#--        </div>-->

<#--        <div class="mt-5">-->
<#--            <h3>Emails</h3>-->
<#--            <a href="/services/${service.id}/add-email" class="btn btn-primary">Add Email</a>-->
<#--            <table class="table table-striped">-->
<#--                <thead>-->
<#--                <tr>-->
<#--                    <th>Email Address</th>-->
<#--                    <th>Action</th>-->
<#--                </tr>-->
<#--                </thead>-->
<#--                <tbody>-->
<#--                <#list service.emails as email>-->
<#--                    <tr>-->
<#--                        <td>${email.email}</td>-->
<#--                        <td>-->
<#--                            <form action="/services/${service.id}/delete-email" method="post" style="display:inline;">-->
<#--                                <input type="hidden" name="email" value="${email.email}">-->
<#--                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this email?')">Delete</button>-->
<#--                            </form>-->
<#--                        </td>-->
<#--                    </tr>-->
<#--                </#list>-->
<#--                </tbody>-->
<#--            </table>-->
<#--        </div>-->
<#--    </div>-->
<#--</@main.layout>-->


<#import "../layout.ftlh" as main>
<@main.layout>
<#--    <div class="container mt-5">-->
        <h2>Service Details</h2>

        <div class="card-body">
            <p class="card-text">
                <strong>ID:</strong> ${service.id}<br>
                <strong>Name:</strong> ${service.name}<br>
                <strong>Description:</strong> <#if service.description??> ${service.description}

                </#if><br>
                <strong>Send to:</strong>  <#if service.sendTo??>
                ${service.sendTo}

                </#if>
                <br>
            </p>
        </div>

         <#if userRoles?seq_contains("ADMIN")>
        <div class="mt-2">
<#--            <a href="/services/${service.id}/edit" class="btn btn-warning mx-2">Update</a>-->
<#--            <a href="/services/${service.id}/delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>-->
            <a href="/services/${service.id}/edit" class="btn-update mx-2">Update</a>
            <a href="/services/${service.id}/delete" class="btn-delete" onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>
        </div>
        </#if>

         <#--<#if userRoles?seq_contains("ADMIN")>
        <div class="mt-3" style="display: flex; gap: 10px;">
            <form action="/services/${service.id}/message-success" method="post">
                <input type="hidden" name="serviceId" value="${service.id}">
                <button type="submit" class="btn btn-success">Send Success Message</button>
            </form>

            <form action="/services/${service.id}/message-error" method="post">
                <input type="hidden" name="serviceId" value="${service.id}">
                <button type="submit" class="btn btn-danger">Send Error Message</button>
            </form>
        </div>
        </#if>-->


            <div class="mt-5">
                <h3>Chats</h3>
                 <#if userRoles?seq_contains("ADMIN")>
                <div class="mt-3 mb-3">
<#--                <a href="/services/${service.id}/add-chat" class="btn btn-primary">Add Chat</a>-->
                     <a href="/services/${service.id}/add-chat" class="btn-add">Add Chat</a>
                </div>
                </#if>
                <#if service.chats?size gt 0>
                <table class="table table-striped custom-table">
                    <thead>
                    <tr>
                        <th>Chat ID</th>
                        <th>Chat Name</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#list service.chats as chat>
                        <tr>
                            <td>${chat.chatId}</td>
                            <td>${chat.chatName}</td>
                            <td>
                                <form action="/services/${service.id}/delete-chat" method="post" style="display:inline;">
                                    <input type="hidden" name="chatId" value="${chat.chatId}">
                                     <#if userRoles?seq_contains("ADMIN")>
<#--                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this chat?')">Delete</button>-->
                                         <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this chat?')">Delete</button>

                                     </#if>
                                </form>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </#if>


            <div class="mt-5">
                <h3>Emails</h3>
                 <#if userRoles?seq_contains("ADMIN")>
                <div class="mt-3 mb-3">
<#--                <a href="/services/${service.id}/add-email" class="btn btn-primary">Add Email</a>-->
                     <a href="/services/${service.id}/add-email" class="btn-add">Add Email</a>
                </div>
                </#if>
                <#if service.emails?size gt 0>
                <table class="table table-striped custom-table">
                    <thead>
                    <tr>
                        <th>Email Address</th>
                         <#if userRoles?seq_contains("ADMIN")>
                        <th>Action</th>
                        </#if>
                    </tr>
                    </thead>
                    <tbody>
                    <#list service.emails as email>
                        <tr>
                            <td>${email.email}</td>
                            <td>
                                <form action="/services/${service.id}/delete-email" method="post" style="display:inline;">
                                    <input type="hidden" name="email" value="${email.email}">
                                     <#if userRoles?seq_contains("ADMIN")>
<#--                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this email?')">Delete</button>-->
                                         <button type="submit" class="btn-delete" onclick="return confirm('Are you sure you want to delete this email?')">Delete</button>
                                     </#if>
                                </form>
                            </td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </#if>
<#--    </div>-->
</@main.layout>
