<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">
    <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">
    <h2 class="text-center">Add Emails to Service</h2>

        <form action="/services/${service.id}/add-email" method="post">
            <div class="form-check">
<#--                <label for="selectedEmails">Select Emails to Add:</label><br>-->
                <#list emails as email>
                    <input class="form-check-input transparent" type="checkbox" id="email${email.email}" name="selectedEmails" value="${email.email}">
                    <label for="email${email.email}">${email.email}</label><br>
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