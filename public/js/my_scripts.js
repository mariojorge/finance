$(function () {
  $('.datepicker').datepicker({
    uiLibrary: 'bootstrap5'
  });
  anElement = new AutoNumeric('.auto-numeric').brazilian({ unformatOnSubmit: true });
});
