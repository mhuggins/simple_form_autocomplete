jQuery(function ($) {
  $(document).on('focus', 'input.autocomplete', function () {
    var $input = $(this);
    var $value = $input.next('input[type=hidden]');

    if (!$input.data('autocomplete-loaded')) {
      $input
          .autocomplete({
            delay: $input.data('delay') || 100,
            source: $input.data('source'),
            focus: function (event, ui) {
              $input.val(ui.item.label);
              $value.val(ui.item.value);
              return false;
            },
            select: function (event, ui) {
              $input.val(ui.item.label);
              $value.val(ui.item.value);
              return false;
            }
          })
          .data({
            'autocomplete-value': $value,
            'autocomplete-loaded': true
          });
    }
  });
});
