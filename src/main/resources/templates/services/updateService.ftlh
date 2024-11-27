<#import "../layout.ftlh" as main>
<@main.layout>
<div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
    <div class="col-md-10 col-lg-8 col-xl-6 p-4 shadow-lg rounded transparent">

    <h2 class="text-center">Update Service</h2>

        <form action="/services/${service.id}/edit" method="post" class="needs-validation" novalidate>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control transparent" id="name" name="name" value="${service.name}" required>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control transparent-textarea" id="description" name="description"  style="height: 200px;" required>${service.description?default('')}</textarea>
            </div>

            <div class="form-group">
                <label for="sendTo">Send to:</label>
                <select class="form-control transparent-select" id="sendTo" name="sendTo" required>
                    <option value="" <#if !service.sendTo?exists || service.sendTo == "">selected</#if>>None</option>
                    <option value="Telegram" <#if service.sendTo?exists && service.sendTo == "Telegram">selected</#if>>Telegram</option>
                    <option value="Email" <#if service.sendTo?exists && service.sendTo == "Email">selected</#if>>Email</option>
                    <option value="All" <#if service.sendTo?exists && service.sendTo == "All">selected</#if>>All</option>
                </select>
            </div>
            <div class="mt-2 d-flex justify-content-center gap-2">
<#--                <button type="submit" class="btn btn-primary">Update</button>-->
<#--                <a href="/services/${service.id}" class="btn btn-secondary mx-3">Cancel</a>-->
                <button type="submit" class=" btn-add">Update</button>
                <a href="/services/${service.id}" class="btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>
</@main.layout>

<script src="/static/main.js"></script>



<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Update Service</h2>-->

<#--        <form action="/services/${service.id}/edit" method="post" class="needs-validation">-->
<#--            <div class="form-group">-->
<#--                <label for="name">Name:</label>-->
<#--                <input type="text" class="form-control" id="name" name="name" value="${service.name}" required>-->
<#--            </div>-->

<#--            <div class="form-group">-->
<#--                <label>Chats:</label>-->
<#--                <#list allChats as chat>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input" id="chat${chat.chatId}" name="chats" value="${chat.chatId}" <#if service.chats?seq_contains(chat)>checked</#if>>-->
<#--                        <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="form-group">-->
<#--                <label>Emails:</label>-->
<#--                <#list allEmails as email>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input" id="email${email.email}" name="emails" value="${email.email}" <#if service.emails?seq_contains(email)>checked</#if>>-->
<#--                        <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="mt-2">-->
<#--                <button type="submit" class="btn btn-primary">Update</button>-->
<#--                <a href="/services/all" class="btn btn-secondary mx-3">Cancel</a>-->
<#--            </div>-->
<#--        </form>-->
<#--    </div>-->
<#--</@main.layout>-->
