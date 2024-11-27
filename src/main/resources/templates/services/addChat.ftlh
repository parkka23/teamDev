<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Add Chats to Service</h2>-->

<#--        <form action="/services/${service.id}/add-chat" method="post">-->
<#--            <div class="form-group">-->
<#--                <label for="selectedChats">Select Chats to Add:</label><br>-->
<#--                <#list chats as chat>-->
<#--                    <input type="checkbox" id="chat${chat.chatId}" name="selectedChats" value="${chat.chatId}">-->
<#--                    <label for="chat${chat.chatId}">${chat.chatName}</label><br>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <button type="submit" class="btn btn-primary">Confirm</button>-->
<#--            <a href="/services/${service.id}" class="btn btn-secondary mx-3">Cancel</a>-->
<#--        </form>-->
<#--    </div>-->
<#--</@main.layout>a-->

<#import "../layout.ftlh" as main>
<@main.layout >
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
            <h2 class="text-center">Add Chats to Service</h2>

            <form action="/services/${service.id}/add-chat" method="post">
                <div class="form-check">
<#--                    <label for="selectedChats">Select Chats to Add:</label><br>-->
                    <#list chats as chat>
                        <input class="form-check-input transparent" type="checkbox" id="chat${chat.chatId}" name="selectedChats" value="${chat.chatId}">
                        <label for="chat${chat.chatId}">${chat.chatName}</label><br>
                    </#list>
                </div>


                <div class="mt-2 d-flex justify-content-center gap-2">

                    <#--            <button type="submit" class="btn btn-primary">Confirm</button>-->
                    <#--            <a href="/services/${service.id}" class="btn btn-secondary mx-3">Cancel</a>-->
                    <button type="submit" class="btn-add">Confirm</button>
                    <a href="/services/${service.id}" class="btn-cancel">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</@main.layout>