<#import "../layout.ftlh" as main>
<@main.layout>
    <h2>Service List</h2>

    <#if userRoles?seq_contains("ADMIN")>
        <div class="mt-3 mb-3">
            <a href="/services/create" class="btn-add">Add Service</a>
        </div>
    </#if>

    <div class="mt-3 mb-3">
        <form action="/services/all" method="get">
            <input id="search-input" type="text" name="query" placeholder="Search by name" class="form-control transparent" style="display: inline-block; width: auto;" value="${query}">
            <button type="submit" class="btn-add">Search</button>
            <button type="button" class="btn-cancel" onclick="clearSearch()">Clear</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-striped custom-table">
            <thead>
            <tr>
                <th>
                    Name
                    <i class="bi <#if sortField == "name" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('name')"></i>
                </th>
                <th>Description</th>
                <th>
                    Send to
                    <i class="bi <#if sortField == "sendTo" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('sendTo')"></i>
                </th>
                <#if userRoles?seq_contains("ADMIN")>
                    <th>Action</th>
                </#if>
            </tr>
            </thead>
            <tbody>
            <#list services as service>
                <tr>
                    <td><a href="/services/${service.id}">${service.name}</a></td>
                    <td>
                        <#if service.description??>
                            ${service.description}
                        </#if>
                    </td>
                    <td>
                        <#if service.sendTo??>
                            ${service.sendTo}
                        </#if>
                    </td>
                    <#if userRoles?seq_contains("ADMIN")>
                        <td>
                            <a href="/services/${service.id}/edit" class="btn-update">Update</a>
                            <a href="/services/${service.id}/delete" class="btn-delete" onclick="return confirm('Are you sure you want to delete this service?')">Delete</a>
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

            window.location.href = '/services/all?' + urlParams.toString();
        }
        function clearSearch() {
            window.location.href = '/services/all?clear=true';
        }
    </script>
    <script src="/static/main.js"></script>
</@main.layout>

