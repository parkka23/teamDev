<#import "../layout.ftlh" as main>
<@main.layout>
    <h2>Email List</h2>
<#-- <#if userRole == "ADMIN">-->
 <#if userRoles?seq_contains("ADMIN")>
    <div class="mt-3 mb-3">
<#--        <a href="/emails/create" class="btn btn-success">Add Email</a>-->
        <a href="/emails/create" class="btn-add">Add Email</a>
    </div>
    </#if>

    <#if errorMessage??>
        <div id="confirm-message" class="alert alert-danger transparent" role="alert">
            ${errorMessage}
            <button type="button" class="btn btn-primary" onclick="hideConfirmMessage()">OK</button>
        </div>
    </#if>

    <div class="mt-3 mb-3">
        <form action="/emails/all" method="get">
            <input id="search-input" type="text" name="query" placeholder="Search by email" class="form-control transparent" style="display: inline-block; width: auto;" value="${query}">
            <button type="submit" class="btn-add">Search</button>
            <button type="button" class="btn-cancel" onclick="clearSearch()">Clear</button>
        </form>
    </div>

    <div class="table-responsive">
        <table class="table table-striped custom-table">
            <thead>
            <tr>
                <th>
                    Email address
                    <i class="bi <#if sortField == "email" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('email')"></i>
                </th>
                <#if userRoles?seq_contains("ADMIN")>
                <th>Action</th>
                </#if>
            </tr>
            </thead>
            <tbody>
            <#list emails as email>
                <tr>
                    <td>${email.email}</td>
                    <#if userRoles?seq_contains("ADMIN")>
                    <td>
<#--                        <a href="/emails/${email.email}/edit" class="btn btn-warning">Update</a>-->
<#--                        <a href="/emails/${email.email}/delete" class="btn btn-danger" onclick="return confirmDelete()">Delete</a>-->
                        <a href="/emails/${email.email}/edit" class="btn-update">Update</a>
                        <a href="/emails/${email.email}/delete" class="btn-delete" onclick="return confirmDelete()">Delete</a>

                    </td>
                    </#if>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>

    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this email?');
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

            window.location.href = '/emails/all?' + urlParams.toString();
        }
        function clearSearch() {
            window.location.href = '/emails/all?clear=true';
        }
    </script>
    <script src="/static/main.js"></script>
</@main.layout>




<#--<#import "../layout.ftlh" as main>-->
<#--<@main.layout>-->
<#--    <h2>Email List</h2>-->

<#--    <#if userRoles?seq_contains("ADMIN")>-->
<#--        <div class="mt-3 mb-3">-->
<#--            <a href="/emails/create" class="btn-add">Add Email</a>-->
<#--        </div>-->
<#--    </#if>-->

<#--    <!-- Error message display &ndash;&gt;-->
<#--    <#if errorMessage??>-->
<#--        <div id="confirm-message" class="alert alert-danger transparent" role="alert">-->
<#--            ${errorMessage}-->
<#--            <button type="button" class="btn btn-primary" onclick="hideConfirmMessage()">OK</button>-->
<#--        </div>-->
<#--    </#if>-->

<#--    <!-- Search form &ndash;&gt;-->
<#--    <div class="mt-3 mb-3">-->
<#--        <form action="/emails/all" method="get">-->
<#--            <input id="search-input" type="text" name="query" placeholder="Search by email" class="form-control transparent" style="display: inline-block; width: auto;" value="${query}">-->
<#--            <button type="submit" class="btn-add">Search</button>-->
<#--            <button type="button" class="btn-cancel" onclick="clearSearch()">Clear</button>-->
<#--        </form>-->
<#--    </div>-->

<#--    <!-- Email list table &ndash;&gt;-->
<#--    <div class="table-responsive">-->
<#--        <table class="table table-striped custom-table">-->
<#--            <thead>-->
<#--            <tr>-->
<#--                <th>-->
<#--                    Email address-->
<#--                    <i class="bi <#if sortField == "email" && sortDir?has_content>bi-filter-circle-fill<#else>bi-filter-circle</#if>" style="cursor: pointer;" onclick="sortTable('email')"></i>-->
<#--                </th>-->
<#--                <#if userRoles?seq_contains("ADMIN")>-->
<#--                    <th>Action</th>-->
<#--                </#if>-->
<#--            </tr>-->
<#--            </thead>-->
<#--            <tbody>-->
<#--            <#list emails as email>-->
<#--                <tr>-->
<#--                    <td>${email.email}</td>-->
<#--                    <#if userRoles?seq_contains("ADMIN")>-->
<#--                        <td>-->
<#--                            <a href="/emails/${email.email}/edit" class="btn-update">Update</a>-->
<#--                            <a href="/emails/${email.email}/delete" class="btn-delete" onclick="return confirmDelete()">Delete</a>-->
<#--                        </td>-->
<#--                    </#if>-->
<#--                </tr>-->
<#--            </#list>-->
<#--            </tbody>-->
<#--        </table>-->
<#--    </div>-->

<#--    <!-- Pagination controls &ndash;&gt;-->
<#--    <nav aria-label="Page navigation">-->
<#--        <ul class="pagination justify-content-center">-->
<#--            <#if currentPage > 0>-->
<#--                <li class="page-item">-->
<#--                    <a class="page-link" href="?page=${currentPage - 1}&size=${size}&sortField=${sortField}&sortDir=${sortDir}" aria-label="Previous">-->
<#--                        <span aria-hidden="true">&laquo;</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--            </#if>-->

<#--            <#list 0..(totalPages - 1) as page>-->
<#--                <li class="page-item ${page == currentPage ? 'active' : ''}">-->
<#--                    <a class="page-link" href="?page=${page}&size=${size}&sortField=${sortField}&sortDir=${sortDir}">-->
<#--                        ${page + 1}-->
<#--                    </a>-->
<#--                </li>-->
<#--            </#list>-->

<#--            <#if currentPage < totalPages - 1>-->
<#--                <li class="page-item">-->
<#--                    <a class="page-link" href="?page=${currentPage + 1}&size=${size}&sortField=${sortField}&sortDir=${sortDir}" aria-label="Next">-->
<#--                        <span aria-hidden="true">&raquo;</span>-->
<#--                    </a>-->
<#--                </li>-->
<#--            </#if>-->
<#--        </ul>-->
<#--    </nav>-->

<#--    <!-- JavaScript for confirmation and sorting &ndash;&gt;-->
<#--    <script>-->
<#--        function confirmDelete() {-->
<#--            return confirm('Are you sure you want to delete this email?');-->
<#--        }-->

<#--        function hideConfirmMessage() {-->
<#--            document.getElementById('confirm-message').style.display = 'none';-->
<#--        }-->

<#--        function sortTable(field) {-->
<#--            let urlParams = new URLSearchParams(window.location.search);-->
<#--            let sortField = urlParams.get('sortField');-->
<#--            let sortDir = urlParams.get('sortDir');-->

<#--            if (sortField === field) {-->
<#--                if (sortDir === 'asc') {-->
<#--                    urlParams.set('sortDir', 'desc'); // Second click - Descending-->
<#--                } else if (sortDir === 'desc') {-->
<#--                    urlParams.delete('sortField'); // Third click - No filter-->
<#--                    urlParams.delete('sortDir');-->
<#--                } else {-->
<#--                    urlParams.set('sortDir', 'asc'); // First click - Ascending-->
<#--                }-->
<#--            } else {-->
<#--                urlParams.set('sortField', field);-->
<#--                urlParams.set('sortDir', 'asc'); // Default to Ascending when sorting a new field-->
<#--            }-->

<#--            window.location.href = '/emails/all?' + urlParams.toString();-->
<#--        }-->

<#--        function clearSearch() {-->
<#--            window.location.href = '/emails/all?clear=true';-->
<#--        }-->
<#--    </script>-->
<#--</@main.layout>-->
