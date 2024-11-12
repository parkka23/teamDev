<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <h2>Chat List</h2>-->
<#--&lt;#&ndash;    <div class="mt-3">&ndash;&gt;-->
<#--&lt;#&ndash;        <a href="/chats/create" class="btn btn-success">Add chat</a>&ndash;&gt;-->
<#--&lt;#&ndash;    </div>&ndash;&gt;-->


<#--    <div class="table-responsive">-->
<#--        <table class="table table-striped">-->
<#--            <thead>-->
<#--            <tr>-->
<#--                <th>ID</th>-->
<#--                <th>Name</th>-->
<#--                <th>Action</th>-->
<#--            </tr>-->
<#--            </thead>-->
<#--            <tbody>-->
<#--            <#list chats as chat>-->
<#--                <tr>-->
<#--                    <td>${chat.chatId}</td>-->
<#--                    <td>${chat.chatName}</td>-->
<#--                    <td>-->
<#--                        <a href="/chats/${chat.chatId?c}/delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this chat?')">Delete</a>-->

<#--                        &lt;#&ndash;                        <a href="/chats/${chat.chatId}/delete" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this chat?')">Delete</a>&ndash;&gt;-->
<#--                    </td>-->
<#--                </tr>-->
<#--            </#list>-->
<#--            </tbody>-->
<#--        </table>-->
<#--    </div>-->

<#--</@main.layout>-->




<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <h2>Chat List</h2>-->

<#--&lt;#&ndash; Alert message placeholder &ndash;&gt;-->
<#--    <div id="alert-message" class="alert alert-danger" role="alert" style="display: none;">-->
<#--        This chat cannot be deleted because it is connected to a service.-->
<#--    </div>-->

<#--    <div class="table-responsive">-->
<#--        <table class="table table-striped">-->
<#--            <thead>-->
<#--            <tr>-->
<#--                <th>ID</th>-->
<#--                <th>Name</th>-->
<#--                <th>Action</th>-->
<#--            </tr>-->
<#--            </thead>-->
<#--            <tbody>-->
<#--            <#list chats as chat>-->
<#--                <tr>-->
<#--                    <td>${chat.chatId}</td>-->
<#--                    <td>${chat.chatName}</td>-->
<#--                    <td>-->
<#--                        <button class="btn btn-danger" onclick="attemptDelete(${chat.chatId})">Delete</button>-->
<#--                    </td>-->
<#--                </tr>-->
<#--            </#list>-->
<#--            </tbody>-->
<#--        </table>-->
<#--    </div>-->

<#--    <script>-->
<#--        function attemptDelete(chatId) {-->
<#--            fetch(`/chats/${chatId}/canDelete`)-->
<#--                .then(response => response.json())-->
<#--                .then(data => {-->
<#--                    if (data.canDelete) {-->
<#--                        if (confirm('Are you sure you want to delete this chat?')) {-->
<#--                            window.location.href = `/chats/${chatId}/delete`;-->
<#--                        }-->
<#--                    } else {-->
<#--                        document.getElementById('alert-message').style.display = 'block';-->
<#--                    }-->
<#--                })-->
<#--                .catch(error => console.error('Error:', error));-->
<#--        }-->
<#--    </script>-->

<#--</@main.layout>-->




<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <h2>Chat List</h2>-->

<#--    <div id="alert-message" class="alert alert-danger" role="alert" style="display: none;">-->
<#--        This chat cannot be deleted because it is connected to a service.-->
<#--    </div>-->

<#--    <div class="table-responsive">-->
<#--        <table class="table table-striped">-->
<#--            <thead>-->
<#--            <tr>-->
<#--                <th>ID</th>-->
<#--                <th>Name</th>-->
<#--                <th>Action</th>-->
<#--            </tr>-->
<#--            </thead>-->
<#--            <tbody>-->
<#--            <#list chats as chat>-->
<#--                <tr>-->
<#--                    <td>${chat.chatId!}</td>-->
<#--                    <td>${chat.chatName!'No Name'}</td>-->
<#--                    <td>-->
<#--                        <button class="btn btn-danger" onclick="attemptDelete(${chat.chatId!})">Delete</button>-->
<#--                    </td>-->
<#--                </tr>-->
<#--            </#list>-->
<#--            </tbody>-->
<#--        </table>-->
<#--    </div>-->

<#--    <script>-->
<#--        function attemptDelete(chatId) {-->
<#--            fetch(`/chats/${chatId}/canDelete`)-->
<#--                .then(response => response.json())-->
<#--                .then(data => {-->
<#--                    if (data.canDelete) {-->
<#--                        if (confirm('Are you sure you want to delete this chat?')) {-->
<#--                            window.location.href = `/chats/${chatId}/delete`;-->
<#--                        }-->
<#--                    } else {-->
<#--                        document.getElementById('alert-message').style.display = 'block';-->
<#--                    }-->
<#--                })-->
<#--                .catch(error => console.error('Error:', error));-->
<#--        }-->
<#--    </script>-->

<#--</@main.layout>-->


<#import "../layout.ftlh" as main>
<@main.layout>
    <h2>Chat List</h2>

    <#if errorMessage??>
        <div id="confirm-message" class="alert alert-danger transparent" role="alert">
            ${errorMessage}
            <button type="button" class="btn btn-primary" onclick="hideConfirmMessage()">OK</button>
        </div>
    </#if>

    <div class="mt-3 mb-3">
        <form action="/chats/all" method="get">
            <input id="search-input" type="text" name="query" placeholder="Search by chat name" class="form-control transparent" style="display: inline-block; width: auto;" value="${query}">
            <button type="submit" class="btn-add">Search</button>
            <button type="button" class="btn-cancel" onclick="clearSearch()">Clear</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-striped custom-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>
                    Name
                    <i class="bi <#if sortField == "name" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('name')"></i>
                </th>
                <#if userRoles?seq_contains("ADMIN")>
                <th>Action</th>

                </#if>
            </tr>
            </thead>
            <tbody>
            <#list chats as chat>
                <tr>
                    <td>${chat.chatId}</td>
                    <td>${chat.chatName}</td>
                    <#if userRoles?seq_contains("ADMIN")>
                    <td>
<#--                        <a href="/chats/${chat.chatId?c}/delete" class="btn btn-danger" onclick="return confirmDelete()">Delete</a>-->
                                                <a href="/chats/${chat.chatId?c}/delete" class="btn-delete" onclick="return confirmDelete()">Delete</a>

                    </td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>

    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this chat?');
        }

        function hideConfirmMessage() {
            document.getElementById('confirm-message').style.display = 'none';
        }

        function sortTable(field) {
            let urlParams = new URLSearchParams(window.location.search);
            let sortField = urlParams.get('sortField');
            let sortDir = urlParams.get('sortDir');

            if (sortField === field) {
                if (sortDir === 'asc') {
                    urlParams.set('sortDir', 'desc'); // Second click - Descending
                } else if (sortDir === 'desc') {
                    urlParams.delete('sortField'); // Third click - No filter
                    urlParams.delete('sortDir');
                } else {
                    urlParams.set('sortDir', 'asc'); // First click - Ascending
                }
            } else {
                urlParams.set('sortField', field);
                urlParams.set('sortDir', 'asc'); // Default to Ascending when sorting a new field
            }

            window.location.href = '/chats/all?' + urlParams.toString();
        }
        function clearSearch() {
            window.location.href = '/chats/all?clear=true';
        }
    </script>
    <script src="/static/main.js"></script>
</@main.layout>
