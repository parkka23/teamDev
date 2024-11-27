

<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Create Service</h2>-->

<#--        <form action="/services/create" method="post" class="needs-validation">-->
<#--            <div class="form-group">-->
<#--                <label for="name">Name:</label>-->
<#--                <input type="text" class="form-control" id="name" name="name" required>-->
<#--            </div>-->
<#--            <div class="form-group">-->
<#--                <label for="sendTo">Send to:</label>-->
<#--                <select class="form-control" id="sendTo" name="sendTo" required>-->
<#--                    <option value="Telegram">Telegram</option>-->
<#--                    <option value="Email">Email</option>-->
<#--                    <option value="All">All</option>-->
<#--                </select>-->
<#--            </div>-->

<#--            <div class="form-group">-->
<#--                <label>Chats:</label>-->
<#--                <#list allChats as chat>-->
<#--                    <div class="form-check">-->
<#--&lt;#&ndash;                        <input type="checkbox" class="form-check-input" id="chat${chat.chatId}" name="chats" value="${chat.chatId}">&ndash;&gt;-->

<#--                        <input type="checkbox" class="form-check-input" id="chat${chat.chatId}" name="chats" value="${chat.chatId?c}">-->
<#--                        <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="form-group">-->
<#--                <label>Emails:</label>-->
<#--                <#list allEmails as email>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                        <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="mt-2">-->
<#--                <button type="submit" class="btn btn-primary">Create</button>-->
<#--                <a href="/services/all" class="btn btn-secondary mx-3">Cancel</a>-->
<#--            </div>-->
<#--        </form>-->
<#--    </div>-->
<#--</@main.layout>-->

<#------------------------------------------------------------------->
<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Create Service</h2>-->

<#--        <form action="/services/create" method="post" class="needs-validation">-->
<#--            <div class="form-group">-->
<#--                <label for="name">Name:</label>-->
<#--                <input type="text" class="form-control" id="name" name="name" required>-->
<#--            </div>-->
<#--            <div class="form-group">-->
<#--                <label for="sendTo">Send to:</label>-->
<#--                <select class="form-control" id="sendTo" name="sendTo" required>-->
<#--                    <option value="All">All</option>-->
<#--                    <option value="Telegram">Telegram</option>-->
<#--                    <option value="Email">Email</option>-->
<#--                </select>-->
<#--            </div>-->

<#--            <div class="form-group" id="chatOptions" style="display: none;">-->
<#--                <label>Chats:</label>-->
<#--                <#list allChats as chat>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input chatCheckbox" id="chat${chat.chatId}" name="chats" value="${chat.chatId?c}">-->
<#--                        <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="form-group" id="emailOptions" style="display: none;">-->
<#--                <label>Emails:</label>-->
<#--                <#list allEmails as email>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input emailCheckbox" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                        <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="mt-2">-->
<#--                <button type="submit" class="btn btn-primary">Create</button>-->
<#--                <a href="/services/all" class="btn btn-secondary mx-3">Cancel</a>-->
<#--            </div>-->
<#--        </form>-->
<#--    </div>-->

<#--    <script>-->
<#--        document.getElementById('sendTo').addEventListener('change', function () {-->
<#--            var sendTo = this.value;-->
<#--            var chatOptions = document.getElementById('chatOptions');-->
<#--            var emailOptions = document.getElementById('emailOptions');-->
<#--            var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--            var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->

<#--            // Reset all selected chat checkboxes-->
<#--            chatCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            // Reset all selected email checkboxes-->
<#--            emailCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            if (sendTo === 'Telegram') {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'none';-->
<#--            } else if (sendTo === 'Email') {-->
<#--                chatOptions.style.display = 'none';-->
<#--                emailOptions.style.display = 'block';-->
<#--            } else {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'block';-->
<#--            }-->
<#--        });-->
<#--    </script>-->
<#--</@main.layout>-->



<#---------------------------------------------------------default All send to-->

<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Create Service</h2>-->

<#--        <form action="/services/create" method="post" class="needs-validation">-->
<#--            <div class="form-group">-->
<#--                <label for="name">Name:</label>-->
<#--                <input type="text" class="form-control" id="name" name="name" required>-->
<#--            </div>-->
<#--            <div class="form-group">-->
<#--                <label for="sendTo">Send to:</label>-->
<#--                <select class="form-control" id="sendTo" name="sendTo" required>-->
<#--                    <option value="All" selected>All</option>-->
<#--                    <option value="Telegram">Telegram</option>-->
<#--                    <option value="Email">Email</option>-->
<#--                </select>-->
<#--            </div>-->

<#--            <div class="form-group" id="chatOptions" style="display: none;">-->
<#--                <label>Chats:</label>-->
<#--                <#list allChats as chat>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input chatCheckbox" id="chat${chat.chatId}" name="chats" value="${chat.chatId?c}">-->
<#--                        <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="form-group" id="emailOptions" style="display: none;">-->
<#--                <label>Emails:</label>-->
<#--                <#list allEmails as email>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input emailCheckbox" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                        <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="mt-2">-->
<#--                <button type="submit" class="btn btn-primary">Create</button>-->
<#--                <a href="/services/all" class="btn btn-secondary mx-3">Cancel</a>-->
<#--            </div>-->
<#--        </form>-->
<#--    </div>-->

<#--    <script>-->
<#--        document.getElementById('sendTo').addEventListener('change', function () {-->
<#--            var sendTo = this.value;-->
<#--            var chatOptions = document.getElementById('chatOptions');-->
<#--            var emailOptions = document.getElementById('emailOptions');-->
<#--            var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--            var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->

<#--            // Reset all selected chat checkboxes-->
<#--            chatCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            // Reset all selected email checkboxes-->
<#--            emailCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            if (sendTo === 'Telegram') {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'none';-->
<#--            } else if (sendTo === 'Email') {-->
<#--                chatOptions.style.display = 'none';-->
<#--                emailOptions.style.display = 'block';-->
<#--            } else {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'block';-->
<#--            }-->
<#--        });-->

<#--        // Trigger change event to initialize visibility based on default value-->
<#--        document.getElementById('sendTo').dispatchEvent(new Event('change'));-->
<#--    </script>-->
<#--</@main.layout>-->



<#--  -------------------------------------------------  default send to   none required -->
<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="container mt-5">-->
<#--        <h2>Create Service</h2>-->

<#--        <form action="/services/create" method="post" class="needs-validation">-->
<#--            <div class="form-group">-->
<#--                <label for="name">Name:</label>-->
<#--                <input type="text" class="form-control" id="name" name="name" required>-->
<#--            </div>-->
<#--            <div class="form-group">-->
<#--                <label for="sendTo">Send to:</label>-->
<#--                <select class="form-control" id="sendTo" name="sendTo" required>-->
<#--                    <option value="" selected>Select an option</option>-->
<#--                    <option value="All">All</option>-->
<#--                    <option value="Telegram">Telegram</option>-->
<#--                    <option value="Email">Email</option>-->
<#--                </select>-->
<#--            </div>-->

<#--            <div class="form-group" id="chatOptions" style="display: none;">-->
<#--                <label>Chats:</label>-->
<#--                <#list allChats as chat>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input chatCheckbox" id="chat${chat.chatId}" name="chats" value="${chat.chatId?c}">-->
<#--                        <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="form-group" id="emailOptions" style="display: none;">-->
<#--                <label>Emails:</label>-->
<#--                <#list allEmails as email>-->
<#--                    <div class="form-check">-->
<#--                        <input type="checkbox" class="form-check-input emailCheckbox" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                        <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                    </div>-->
<#--                </#list>-->
<#--            </div>-->

<#--            <div class="mt-2">-->
<#--                <button type="submit" class="btn btn-primary">Create</button>-->
<#--                <a href="/services/all" class="btn btn-secondary mx-3">Cancel</a>-->
<#--            </div>-->
<#--        </form>-->
<#--    </div>-->

<#--    <script>-->
<#--        document.getElementById('sendTo').addEventListener('change', function () {-->
<#--            var sendTo = this.value;-->
<#--            var chatOptions = document.getElementById('chatOptions');-->
<#--            var emailOptions = document.getElementById('emailOptions');-->
<#--            var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--            var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->

<#--            // Reset all selected chat checkboxes-->
<#--            chatCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            // Reset all selected email checkboxes-->
<#--            emailCheckboxes.forEach(function (checkbox) {-->
<#--                checkbox.checked = false;-->
<#--            });-->

<#--            if (sendTo === 'Telegram') {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'none';-->
<#--            } else if (sendTo === 'Email') {-->
<#--                chatOptions.style.display = 'none';-->
<#--                emailOptions.style.display = 'block';-->
<#--            } else if (sendTo === 'All') {-->
<#--                chatOptions.style.display = 'block';-->
<#--                emailOptions.style.display = 'block';-->
<#--            } else {-->
<#--                chatOptions.style.display = 'none';-->
<#--                emailOptions.style.display = 'none';-->
<#--            }-->
<#--        });-->

<#--        // Trigger change event to initialize visibility based on default value-->
<#--        document.getElementById('sendTo').dispatchEvent(new Event('change'));-->
<#--    </script>-->
<#--</@main.layout>-->



<#-- not required -->
<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-1" >
        <div class="col-md-10 col-lg-8 col-xl-6 p-4 shadow-lg rounded transparent">

            <h2 class="text-center">Create Service</h2>

            <form id="createServiceForm" action="/services/create" method="post" class="needs-validation">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control transparent" id="name" name="name" required>
                    <div class="invalid-feedback" id="nameError" style="display: none;">Enter valid name.</div>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea class="form-control transparent-textarea" id="description" name="description" style="height: 150px;" required></textarea>
                </div>
                <div class="form-group">
                    <label for="sendTo">Send to:</label>
                    <select class="form-control transparent-select" id="sendTo" name="sendTo">
                        <option value="" selected>None</option>
                        <option value="All">All</option>
                        <option value="Telegram">Telegram</option>
                        <option value="Email">Email</option>
                    </select>
                </div>

                <div class="form-group" id="chatOptions" style="display: none;">
                    <label>Chats:</label>
                    <#list allChats as chat>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chats" value="${chat.chatId?c}">
                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>
                        </div>
                    </#list>
                </div>

                <div class="form-group" id="emailOptions" style="display: none;">
                    <label>Emails:</label>
                    <#list allEmails as email>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">
                            <label class="form-check-label" for="email${email.email}">${email.email}</label>
                        </div>
                    </#list>
                </div>

                <div class="mt-2 d-flex justify-content-center gap-2">
                    <button type="submit" class="btn-add">Create</button>
                    <a href="/services/all" class="btn-cancel">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        document.getElementById('sendTo').addEventListener('change', function () {
            var sendTo = this.value;
            var chatOptions = document.getElementById('chatOptions');
            var emailOptions = document.getElementById('emailOptions');
            var chatCheckboxes = document.querySelectorAll('.chatCheckbox');
            var emailCheckboxes = document.querySelectorAll('.emailCheckbox');

            // Reset all selected chat checkboxes
            chatCheckboxes.forEach(function (checkbox) {
                checkbox.checked = false;
            });

            // Reset all selected email checkboxes
            emailCheckboxes.forEach(function (checkbox) {
                checkbox.checked = false;
            });

            if (sendTo === 'Telegram') {
                chatOptions.style.display = 'block';
                emailOptions.style.display = 'none';
            } else if (sendTo === 'Email') {
                chatOptions.style.display = 'none';
                emailOptions.style.display = 'block';
            } else if (sendTo === 'All') {
                chatOptions.style.display = 'block';
                emailOptions.style.display = 'block';
            } else {
                chatOptions.style.display = 'none';
                emailOptions.style.display = 'none';
            }
        });

        // Trigger change event to initialize visibility based on default value
        document.getElementById('sendTo').dispatchEvent(new Event('change'));

        // Form validation
        document.getElementById('createServiceForm').addEventListener('submit', function(event) {
            var nameInput = document.getElementById('name');
            var nameError = document.getElementById('nameError');

            if (!nameInput.value.trim()) {
                nameError.style.display = 'block';
                nameInput.classList.add('is-invalid');
                event.preventDefault();
            } else {
                nameError.style.display = 'none';
                nameInput.classList.remove('is-invalid');
            }
        });
    </script>
    <script src="/static/main.js"></script>
</@main.layout>

