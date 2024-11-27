<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">-->

<#--            <h2>Send Message</h2>-->

<#--            <#if success?? && success>-->
<#--                <div class="alert alert-success transparent mt-3">-->
<#--                    Message sent successfully!-->
<#--                </div>-->
<#--            </#if>-->
<#--            <form id="messageForm" action="/message/send" method="post" class="needs-validation" novalidate>-->
<#--                <div class="form-group">-->
<#--                    <label for="chats">Chats:</label>-->
<#--                    <#list chats as chat>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chatIds" value="${chat.chatId?c}">-->
<#--                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="emails">Emails:</label>-->
<#--                    <#list emails as email>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                            <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div id="selectError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                    Please select at least one chat recipient.-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="message">Message:</label>-->
<#--                    <textarea id="message" name="message" class="form-control transparent-textarea" required></textarea>-->
<#--                    <div id="messageError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                        The message cannot be empty or consist only of spaces.-->
<#--                    </div>-->
<#--                </div>-->

<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="submit" class="btn-add">Send</button>-->
<#--                    <a href="/home" class="btn-cancel">Cancel</a>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->

<#--    <script>-->
<#--        // Custom validation logic-->
<#--        (function() {-->
<#--            var form = document.getElementById('messageForm');-->

<#--            form.addEventListener('submit', function(event) {-->
<#--                if (!form.checkValidity()) {-->
<#--                    event.preventDefault();-->
<#--                    event.stopPropagation();-->
<#--                }-->

<#--                form.classList.add('was-validated');-->

<#--                // Check if at least one chat or email recipient is selected-->
<#--                var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--                var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->
<#--                var messageError = document.getElementById('messageError');-->
<#--                var selectError = document.getElementById('selectError');-->

<#--                var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                if (!isChatSelected && !isEmailSelected) {-->
<#--                    event.preventDefault();-->
<#--                    selectError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    selectError.style.display = 'none';-->
<#--                }-->

<#--                // Check message content-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message === '') {-->
<#--                    event.preventDefault();-->
<#--                    messageField.setCustomValidity('The message cannot be empty or consist only of spaces.');-->
<#--                    messageError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    messageField.setCustomValidity('');-->
<#--                    messageError.style.display = 'none';-->
<#--                }-->
<#--            }, false);-->

<#--            // Reset validation feedback on input-->
<#--            var messageField = document.getElementById('message');-->
<#--            var messageError = document.getElementById('messageError');-->
<#--            messageField.addEventListener('input', function() {-->
<#--                this.setCustomValidity('');-->
<#--                messageError.style.display = 'none';-->
<#--            });-->
<#--        })();-->
<#--    </script>-->
<#--</@main.layout>-->













<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">-->

<#--            <h2>Send Message</h2>-->

<#--            <#if success?? && success>-->
<#--                <div class="alert alert-success transparent mt-3">-->
<#--                    Message sent successfully!-->
<#--                </div>-->
<#--            </#if>-->
<#--            <form id="messageForm" action="/message/send" method="post" class="needs-validation" novalidate>-->
<#--                <div class="form-group">-->
<#--                    <label for="chats">Chats:</label>-->
<#--                    <#list chats as chat>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chatIds" value="${chat.chatId?c}">-->
<#--                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="emails">Emails:</label>-->
<#--                    <#list emails as email>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                            <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div id="selectError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                    Please select at least one chat recipient.-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="message">Message:</label>-->
<#--                    <textarea id="message" name="message" class="form-control transparent-textarea" required></textarea>-->
<#--                    <div id="messageError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                        The message cannot be empty or consist only of spaces.-->
<#--                    </div>-->
<#--                </div>-->

<#--                <!-- Button to transliterate message &ndash;&gt;-->
<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="button" class="btn btn-add" id="transliterateBtn">Transliterate Message</button>-->
<#--                </div>-->

<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="submit" class="btn-add">Send</button>-->
<#--                    <a href="/home" class="btn-cancel">Cancel</a>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->

<#--    <script>-->
<#--        // Custom validation logic-->
<#--        (function() {-->
<#--            var form = document.getElementById('messageForm');-->

<#--            form.addEventListener('submit', function(event) {-->
<#--                if (!form.checkValidity()) {-->
<#--                    event.preventDefault();-->
<#--                    event.stopPropagation();-->
<#--                }-->

<#--                form.classList.add('was-validated');-->

<#--                // Check if at least one chat or email recipient is selected-->
<#--                var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--                var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->
<#--                var messageError = document.getElementById('messageError');-->
<#--                var selectError = document.getElementById('selectError');-->

<#--                var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                if (!isChatSelected && !isEmailSelected) {-->
<#--                    event.preventDefault();-->
<#--                    selectError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    selectError.style.display = 'none';-->
<#--                }-->

<#--                // Check message content-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message === '') {-->
<#--                    event.preventDefault();-->
<#--                    messageField.setCustomValidity('The message cannot be empty or consist only of spaces.');-->
<#--                    messageError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    messageField.setCustomValidity('');-->
<#--                    messageError.style.display = 'none';-->
<#--                }-->
<#--            }, false);-->

<#--            // Reset validation feedback on input-->
<#--            var messageField = document.getElementById('message');-->
<#--            var messageError = document.getElementById('messageError');-->
<#--            messageField.addEventListener('input', function() {-->
<#--                this.setCustomValidity('');-->
<#--                messageError.style.display = 'none';-->
<#--            });-->

<#--            // Transliterate message and replace original message-->
<#--            var transliterateBtn = document.getElementById('transliterateBtn');-->

<#--            transliterateBtn.addEventListener('click', function() {-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message !== '') {-->
<#--                    // Call backend or use JavaScript service to transliterate-->
<#--                    fetch('/message/transliterate?text=' + encodeURIComponent(message))-->
<#--                        .then(response => response.text())-->
<#--                        .then(data => {-->
<#--                            // Replace original message with transliterated text-->
<#--                            messageField.value = data;-->
<#--                        })-->
<#--                        .catch(error => console.error('Error:', error));-->
<#--                } else {-->
<#--                    alert('Please enter a message before transliterating.');-->
<#--                }-->
<#--            });-->
<#--        })();-->
<#--    </script>-->
<#--</@main.layout>-->



<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">-->

<#--            <h2>Send Message</h2>-->

<#--            <#if success?? && success>-->
<#--                <div class="alert alert-success transparent mt-3">-->
<#--                    Message sent successfully!-->
<#--                </div>-->
<#--            </#if>-->
<#--            <form id="messageForm" action="/message/send" method="post" class="needs-validation" novalidate>-->
<#--                <div class="form-group">-->
<#--                    <label for="chats">Chats:</label>-->
<#--                    <#list chats as chat>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chatIds" value="${chat.chatId?c}">-->
<#--                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="emails">Emails:</label>-->
<#--                    <#list emails as email>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                            <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div id="selectError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                    Please select at least one chat recipient.-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="message">Message:</label>-->
<#--                    <textarea id="message" name="message" class="form-control transparent-textarea" required></textarea>-->
<#--                    <div id="messageError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                        The message cannot be empty or consist only of spaces.-->
<#--                    </div>-->
<#--                </div>-->

<#--                <!-- Button to transliterate message &ndash;&gt;-->
<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="button" class="btn btn-add" id="transliterateBtn">Transliterate Message</button>-->
<#--                    <button type="button" class="btn btn-cancel" id="revertBtn" style="display: none;">Undo</button>-->
<#--                </div>-->

<#--                <div class="mt-2 d-flex justify-content-center">-->
<#--                    <button type="submit" class="btn-secondary">Send</button>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->

<#--    <script>-->
<#--        // Custom validation logic-->
<#--        (function() {-->
<#--            var form = document.getElementById('messageForm');-->

<#--            form.addEventListener('submit', function(event) {-->
<#--                if (!form.checkValidity()) {-->
<#--                    event.preventDefault();-->
<#--                    event.stopPropagation();-->
<#--                }-->

<#--                form.classList.add('was-validated');-->

<#--                // Check if at least one chat or email recipient is selected-->
<#--                var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--                var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->
<#--                var messageError = document.getElementById('messageError');-->
<#--                var selectError = document.getElementById('selectError');-->

<#--                var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                if (!isChatSelected && !isEmailSelected) {-->
<#--                    event.preventDefault();-->
<#--                    selectError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    selectError.style.display = 'none';-->
<#--                }-->

<#--                // Check message content-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message === '') {-->
<#--                    event.preventDefault();-->
<#--                    messageField.setCustomValidity('The message cannot be empty or consist only of spaces.');-->
<#--                    messageError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    messageField.setCustomValidity('');-->
<#--                    messageError.style.display = 'none';-->
<#--                }-->
<#--            }, false);-->

<#--            // Reset validation feedback on input-->
<#--            var messageField = document.getElementById('message');-->
<#--            var messageError = document.getElementById('messageError');-->
<#--            messageField.addEventListener('input', function() {-->
<#--                this.setCustomValidity('');-->
<#--                messageError.style.display = 'none';-->
<#--            });-->

<#--            // Transliterate message and replace original message-->
<#--            var transliterateBtn = document.getElementById('transliterateBtn');-->
<#--            var revertBtn = document.getElementById('revertBtn');-->

<#--            transliterateBtn.addEventListener('click', function() {-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message !== '') {-->
<#--                    // Backup original message-->
<#--                    originalMessage = message;-->

<#--                    // Call backend or use JavaScript service to transliterate-->
<#--                    fetch('/message/transliterate?text=' + encodeURIComponent(message))-->
<#--                        .then(response => response.text())-->
<#--                        .then(data => {-->
<#--                            // Replace original message with transliterated text-->
<#--                            messageField.value = data;-->

<#--                            // Show revert button-->
<#--                            revertBtn.style.display = 'inline-block';-->
<#--                        })-->
<#--                        .catch(error => console.error('Error:', error));-->
<#--                } else {-->
<#--                    alert('Please enter a message before transliterating.');-->
<#--                }-->
<#--            });-->

<#--            // Revert to original message-->
<#--            revertBtn.addEventListener('click', function() {-->
<#--                var messageField = document.getElementById('message');-->
<#--                messageField.value = originalMessage;-->

<#--                // Hide revert button-->
<#--                revertBtn.style.display = 'none';-->
<#--            });-->

<#--        })();-->
<#--    </script>-->
<#--</@main.layout>-->












<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <div class="d-flex justify-content-center align-items-center vh-70" style="margin-top: 30px;">-->
<#--        <div class="col-md-8 col-lg-6 col-xl-4 p-4 shadow-lg rounded transparent">-->

<#--            <h2>Send Message</h2>-->

<#--            <#if success?? && success>-->
<#--                <div class="alert alert-success transparent mt-3">-->
<#--                    Message sent successfully!-->
<#--                </div>-->
<#--            </#if>-->
<#--            <form id="messageForm" action="/message/send" method="post" class="needs-validation" novalidate>-->
<#--                <div class="form-group">-->
<#--                    <label for="chats">Chats:</label>-->
<#--                    <#list chats as chat>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chatIds" value="${chat.chatId?c}">-->
<#--                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="emails">Emails:</label>-->
<#--                    <#list emails as email>-->
<#--                        <div class="form-check">-->
<#--                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">-->
<#--                            <label class="form-check-label" for="email${email.email}">${email.email}</label>-->
<#--                        </div>-->
<#--                    </#list>-->
<#--                </div>-->
<#--                <div id="selectError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                    Please select at least one chat recipient.-->
<#--                </div>-->

<#--                <div class="form-group">-->
<#--                    <label for="message">Message:</label>-->
<#--                    <textarea id="message" name="message" class="form-control transparent-textarea" required></textarea>-->
<#--                    <div id="messageError" class="invalid-feedback text-danger" style="display: none;">-->
<#--                        The message cannot be empty or consist only of spaces.-->
<#--                    </div>-->
<#--                </div>-->

<#--                <!-- Button to transliterate message &ndash;&gt;-->
<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="button" class="btn btn-add" id="transliterateBtn">Transliterate Message</button>-->
<#--                </div>-->

<#--                <div class="mt-2 d-flex justify-content-center gap-2">-->
<#--                    <button type="submit" class="btn-secondary">Send</button>-->
<#--                </div>-->
<#--            </form>-->
<#--        </div>-->
<#--    </div>-->

<#--    <script>-->
<#--        // Custom validation logic-->
<#--        (function() {-->
<#--            var form = document.getElementById('messageForm');-->

<#--            form.addEventListener('submit', function(event) {-->
<#--                if (!form.checkValidity()) {-->
<#--                    event.preventDefault();-->
<#--                    event.stopPropagation();-->
<#--                }-->

<#--                form.classList.add('was-validated');-->

<#--                // Check if at least one chat or email recipient is selected-->
<#--                var chatCheckboxes = document.querySelectorAll('.chatCheckbox');-->
<#--                var emailCheckboxes = document.querySelectorAll('.emailCheckbox');-->
<#--                var messageError = document.getElementById('messageError');-->
<#--                var selectError = document.getElementById('selectError');-->

<#--                var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {-->
<#--                    return checkbox.checked;-->
<#--                });-->

<#--                if (!isChatSelected && !isEmailSelected) {-->
<#--                    event.preventDefault();-->
<#--                    selectError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    selectError.style.display = 'none';-->
<#--                }-->

<#--                // Check message content-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message === '') {-->
<#--                    event.preventDefault();-->
<#--                    messageField.setCustomValidity('The message cannot be empty or consist only of spaces.');-->
<#--                    messageError.style.display = 'block';-->
<#--                    form.classList.remove('was-validated');-->
<#--                } else {-->
<#--                    messageField.setCustomValidity('');-->
<#--                    messageError.style.display = 'none';-->
<#--                }-->
<#--            }, false);-->

<#--            // Reset validation feedback on input-->
<#--            var messageField = document.getElementById('message');-->
<#--            var messageError = document.getElementById('messageError');-->
<#--            messageField.addEventListener('input', function() {-->
<#--                this.setCustomValidity('');-->
<#--                messageError.style.display = 'none';-->
<#--            });-->

<#--            // Transliterate message and allow undo with Ctrl+Z-->
<#--            var transliterateBtn = document.getElementById('transliterateBtn');-->

<#--            transliterateBtn.addEventListener('click', function() {-->
<#--                var messageField = document.getElementById('message');-->
<#--                var message = messageField.value.trim();-->

<#--                if (message !== '') {-->
<#--                    // Store current selection range-->
<#--                    var selectionStart = messageField.selectionStart;-->
<#--                    var selectionEnd = messageField.selectionEnd;-->

<#--                    // Call backend or use JavaScript service to transliterate-->
<#--                    fetch('/message/transliterate?text=' + encodeURIComponent(message))-->
<#--                        .then(response => response.text())-->
<#--                        .then(data => {-->
<#--                            // Simulate undoable edit operation-->
<#--                            messageField.focus();-->
<#--                            document.execCommand('selectAll', false, null);-->
<#--                            document.execCommand('insertText', false, data);-->

<#--                            // Restore previous selection range-->
<#--                            messageField.setSelectionRange(selectionStart, selectionEnd);-->
<#--                        })-->
<#--                        .catch(error => console.error('Error:', error));-->
<#--                } else {-->
<#--                    alert('Please enter a message before transliterating.');-->
<#--                }-->
<#--            });-->
<#--        })();-->
<#--    </script>-->
<#--</@main.layout>-->

<#import "../layout.ftlh" as main>
<@main.layout>
    <div class="d-flex justify-content-center align-items-center vh-100" style="margin-top: 1px;">
        <div class="col-md-10 col-lg-8 col-xl-6 p-4 shadow-lg rounded transparent">
            <h2 class="text-center">Send Message</h2>

            <#if success?? && success>
                <div class="alert alert-success transparent mt-3">
                    Message sent successfully!
                </div>
            </#if>
            <form id="messageForm" action="/message/send" method="post" class="needs-validation" novalidate>
                <div class="form-group">
                    <label for="chats">Chats:</label>
                    <#list chats as chat>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input chatCheckbox transparent" id="chat${chat.chatId}" name="chatIds" value="${chat.chatId?c}">
                            <label class="form-check-label" for="chat${chat.chatId}">${chat.chatName}</label>
                        </div>
                    </#list>
                </div>

                <div class="form-group">
                    <label for="emails">Emails:</label>
                    <#list emails as email>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input emailCheckbox transparent" id="email${email.email}" name="emails" value="${email.email}">
                            <label class="form-check-label" for="email${email.email}">${email.email}</label>
                        </div>
                    </#list>
                </div>
                <div id="selectError" class="invalid-feedback text-danger" style="display: none;">
                    Please select at least one chat or email.
                </div>

                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea id="message" name="message" class="form-control transparent-textarea" style="height: 150px;" required></textarea>
                    <div id="messageError" class="invalid-feedback text-danger" style="display: none;">
                        The message cannot be empty.
                    </div>
                </div>

                <div class="mt-2 d-flex justify-content-center gap-2">
                    <button type="submit" class="btn-secondary">Send</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Custom validation logic
        // (function() {
        //     var form = document.getElementById('messageForm');
        //
        //     form.addEventListener('submit', function(event) {
        //         if (!form.checkValidity()) {
        //             event.preventDefault();
        //             event.stopPropagation();
        //         }
        //
        //         form.classList.add('was-validated');
        //
        //         // Check if at least one chat or email recipient is selected
        //         var chatCheckboxes = document.querySelectorAll('.chatCheckbox');
        //         var emailCheckboxes = document.querySelectorAll('.emailCheckbox');
        //         var messageError = document.getElementById('messageError');
        //         var selectError = document.getElementById('selectError');
        //
        //         var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {
        //             return checkbox.checked;
        //         });
        //
        //         var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {
        //             return checkbox.checked;
        //         });
        //
        //         if (!isChatSelected && !isEmailSelected) {
        //             event.preventDefault();
        //             selectError.style.display = 'block';
        //             form.classList.remove('was-validated');
        //         } else {
        //             selectError.style.display = 'none';
        //         }
        //
        //         // Check message content
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value.trim();
        //
        //         if (message === '') {
        //             event.preventDefault();
        //             messageField.setCustomValidity('The message cannot be empty or consist only of spaces.');
        //             messageError.style.display = 'block';
        //             form.classList.remove('was-validated');
        //         } else {
        //             messageField.setCustomValidity('');
        //             messageError.style.display = 'none';
        //         }
        //     }, false);
        //
        //     // Reset validation feedback on input
        //     var messageField = document.getElementById('message');
        //     var messageError = document.getElementById('messageError');
        //     messageField.addEventListener('input', function() {
        //         this.setCustomValidity('');
        //         messageError.style.display = 'none';
        //     });
        //
        //     // Transliterate selected text and allow undo with Ctrl+Z
        //     function transliterateText(start, end) {
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value;
        //
        //         var selectedText = message.substring(start, end);
        //         if (selectedText.trim() !== '') {
        //             // Call backend or use JavaScript service to transliterate
        //             fetch('/message/transliterate?text=' + encodeURIComponent(selectedText))
        //                 .then(response => response.text())
        //                 .then(data => {
        //                     // Simulate undoable edit operation
        //                     document.execCommand('selectAll', false, null);
        //                     document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
        //
        //                     // Restore previous selection range
        //                     messageField.setSelectionRange(start, start + data.length);
        //                 })
        //                 .catch(error => console.error('Error:', error));
        //         } else {
        //             alert('Please select text before transliterating.');
        //         }
        //     }
        //
        //     // Add keydown event listener for Alt+T
        //     document.addEventListener('keydown', function(event) {
        //         if (event.altKey && event.code === 'KeyT') {
        //             event.preventDefault();
        //             var messageField = document.getElementById('message');
        //             var start = messageField.selectionStart;
        //             var end = messageField.selectionEnd;
        //             transliterateText(start, end);
        //         }
        //     });
        // })();

        (function() {
            var form = document.getElementById('messageForm');

            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }

                form.classList.add('was-validated');

                // Check if at least one chat or email recipient is selected
                var chatCheckboxes = document.querySelectorAll('.chatCheckbox');
                var emailCheckboxes = document.querySelectorAll('.emailCheckbox');
                var messageError = document.getElementById('messageError');
                var selectError = document.getElementById('selectError');

                var isChatSelected = Array.from(chatCheckboxes).some(function(checkbox) {
                    return checkbox.checked;
                });

                var isEmailSelected = Array.from(emailCheckboxes).some(function(checkbox) {
                    return checkbox.checked;
                });

                if (!isChatSelected && !isEmailSelected) {
                    event.preventDefault();
                    selectError.style.display = 'block';
                    form.classList.remove('was-validated');
                } else {
                    selectError.style.display = 'none';
                }

                // Check message content
                var messageField = document.getElementById('message');
                var message = messageField.value.trim();

                if (message === '') {
                    event.preventDefault();
                    messageField.setCustomValidity('The message cannot be empty.');
                    messageError.style.display = 'block';
                    form.classList.remove('was-validated');
                } else {
                    messageField.setCustomValidity('');
                    messageError.style.display = 'none';
                }
            }, false);

            // Reset validation feedback on input
            var messageField = document.getElementById('message');
            var messageError = document.getElementById('messageError');
            messageField.addEventListener('input', function() {
                this.setCustomValidity('');
                messageError.style.display = 'none';
            });

        //     // Transliterate selected text and allow undo with Ctrl+Z
        //     function transliterateTextRuToEn(start, end) {
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value;
        //
        //         var selectedText = message.substring(start, end);
        //         if (selectedText.trim() !== '') {
        //             // Call backend or use JavaScript service to transliterate
        //             fetch('/message/translitRuToEn?text=' + encodeURIComponent(selectedText))
        //                 .then(response => response.text())
        //                 .then(data => {
        //                     // Simulate undoable edit operation
        //                     document.execCommand('selectAll', false, null);
        //                     document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
        //
        //                     // Restore previous selection range
        //                     messageField.setSelectionRange(start, start + data.length);
        //                 })
        //                 .catch(error => console.error('Error:', error));
        //         } else {
        //             alert('Please select text before transliterating.');
        //         }
        //     }
        //
        //     function transliterateTextEnToRu(start, end) {
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value;
        //
        //         var selectedText = message.substring(start, end);
        //         if (selectedText.trim() !== '') {
        //             // Call backend or use JavaScript service to transliterate
        //             fetch('/message/translitEnToRu?text=' + encodeURIComponent(selectedText))
        //                 .then(response => response.text())
        //                 .then(data => {
        //                     // Simulate undoable edit operation
        //                     document.execCommand('selectAll', false, null);
        //                     document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
        //
        //                     // Restore previous selection range
        //                     messageField.setSelectionRange(start, start + data.length);
        //                 })
        //                 .catch(error => console.error('Error:', error));
        //         } else {
        //             alert('Please select text before transliterating.');
        //         }
        //     }
        //
        //     // Convert selected text from EN to RU
        //     function convertTextEnToRu(start, end) {
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value;
        //
        //         var selectedText = message.substring(start, end);
        //         if (selectedText.trim() !== '') {
        //             fetch('/message/convertEnToRu?text=' + encodeURIComponent(selectedText))
        //                 .then(response => response.text())
        //                 .then(data => {
        //                     document.execCommand('selectAll', false, null);
        //                     document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
        //                     messageField.setSelectionRange(start, start + data.length);
        //                 })
        //                 .catch(error => console.error('Error:', error));
        //         } else {
        //             alert('Please select text before converting.');
        //         }
        //     }
        //
        //     // Convert selected text from RU to EN
        //     function convertTextRuToEn(start, end) {
        //         var messageField = document.getElementById('message');
        //         var message = messageField.value;
        //
        //         var selectedText = message.substring(start, end);
        //         if (selectedText.trim() !== '') {
        //             fetch('/message/convertRuToEn?text=' + encodeURIComponent(selectedText))
        //                 .then(response => response.text())
        //                 .then(data => {
        //                     document.execCommand('selectAll', false, null);
        //                     document.execCommand('insertText', false, message.substring(0, start) + data + message.substring(end));
        //                     messageField.setSelectionRange(start, start + data.length);
        //                 })
        //                 .catch(error => console.error('Error:', error));
        //         } else {
        //             alert('Please select text before converting.');
        //         }
        //     }
        //
        //     // Add keydown event listener for shortcuts
        //     document.addEventListener('keydown', function(event) {
        //         var messageField = document.getElementById('message');
        //         var start = messageField.selectionStart;
        //         var end = messageField.selectionEnd;
        //
        //         // Alt+T for transliteration
        //         if (event.altKey && event.code === 'KeyT' && !event.shiftKey) {
        //             event.preventDefault();
        //             transliterateTextRuToEn(start, end);
        //         }
        //         // Alt+Shift+T for transliteration
        //         if (event.altKey && event.code === 'KeyT'&& event.shiftKey) {
        //             event.preventDefault();
        //             transliterateTextEnToRu(start, end);
        //         }
        //
        //         // Alt+R for EN to RU conversion
        //         if (event.altKey && event.code === 'KeyR' && !event.shiftKey) {
        //             event.preventDefault();
        //             convertTextEnToRu(start, end);
        //         }
        //         // Alt+Shift+R for RU to EN conversion
        //         if (event.altKey && event.code === 'KeyR' && event.shiftKey) {
        //             event.preventDefault();
        //             convertTextRuToEn(start, end);
        //         }
        //     });
        })();
    </script>
    <script src="/static/main.js"></script>
</@main.layout>

