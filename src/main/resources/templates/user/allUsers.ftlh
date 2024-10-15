<#import "../layout.ftlh" as main>
<@main.layout>
    <h2>User List</h2>

    <#if userRoles?seq_contains("ADMIN")>
        <div class="mt-3 mb-3">
            <a href="/user/register" class="btn-add">Registration</a>
        </div>
    </#if>

    <div class="mt-3 mb-3">
        <form action="/user/list" method="get">
            <input id="search-input" type="text" name="query" placeholder="Search by full name" class="form-control transparent" style="display: inline-block; width: auto;" value="${query}">
            <button type="submit" class="btn-add">Search</button>
            <button type="button" class="btn-cancel" onclick="clearSearch()">Clear</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-striped custom-table">
            <thead>
            <tr>
                <th>
                    Full Name
                    <i class="bi <#if sortField == "fullName" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('fullName')"></i>
                </th>
                <th>
                    Email
                    <i class="bi <#if sortField == "email" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('email')"></i>
                </th>
                <th>Roles</th>
                <#if userRoles?seq_contains("ADMIN")>
                    <th>Action</th>
                </#if>
            </tr>
            </thead>
            <tbody>
            <#list users as user>
                <tr>
                    <td><a href="/user/${user.id}">${user.fullName}</a></td>
                    <td>${user.email}</td>
                    <td>
                        <#list user.roles as role>
                            ${role.name}<#if role_has_next>, </#if>
                        </#list>

                    <#--                            <#list userRoles as role>-->
<#--                                        ${role}-->
<#--                            </#list>-->
                    </td>
                    <#if userRoles?seq_contains("ADMIN")>
                        <td>
<#--                            <a href="/user/${user.id}/update" class="btn-update">Update</a>-->
                            <a href="/user/${user.id}/delete" class="btn-delete" onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
                        </td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>

    <script>
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

            window.location.href = '/user/list?' + urlParams.toString();
        }
        function clearSearch() {
            window.location.href = '/user/list?clear=true';
        }
    </script>
    <script src="/static/main.js"></script>
</@main.layout>

