<!--MODAL to CONFIRM and EXECUTE DELETE BUDGET -->
<div id="deleteBudgetModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-warning d-table justify-content-between">
                <div class="d-table-cell align-middle">
                    <h5 class="modal-title text-white font-weight-bolder text-center">
                        Delete Budget</h5>
                </div>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="addAlert"></div>
                <p class="text-center text-dark">Are you sure you want to delete
                    budget <strong></strong> with its <span id="catCount"></span> and
                    all its transactions?</p>
                <p class="text-center font-weight-bolder text-warning">All records will be removed
                    permanently.</p>
                <div class="btn-wrapper text-center">
                    <a href="" class="btn btn-primary">Yes</a>
                    <button type="button" class="btn btn-secondary"
                            data-dismiss="modal"> No
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>