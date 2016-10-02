// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('.favorite-checkbox').on('click', function(e) {
  e.target.form.submit();
});
