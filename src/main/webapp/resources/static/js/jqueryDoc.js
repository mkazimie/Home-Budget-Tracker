$(document).ready(function () {
        $('#dataTable').DataTable({
            "order": [[0, "desc" ]]
        });
        $('.dataTables_length').addClass('bs-select');
});
