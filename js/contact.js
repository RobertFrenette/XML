function trimLastChar() {
    $question = $('#question').val().substring(0, $('#question').val().length - 1);
    $('#question').val($question);
}

$(document).ready(function() {
    $('#mnuContact').addClass('active');
    $('#name').focus();

    $('#frmContact').submit(function () {
        $ret = true;
        if ($('#question').val().trim() == '') {
            $submitForm = confirm('You have not entered a question.\n\nPress OK to submit or Cancel to enter your question.\n\n');
            if (! $submitForm) {
                $('#question').focus();
                $ret = false;
            }
        }
        if ($ret) {
            trimLastChar();
        }
        return $ret;
    });
});