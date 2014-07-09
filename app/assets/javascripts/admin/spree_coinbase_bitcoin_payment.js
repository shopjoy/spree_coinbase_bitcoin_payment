//= require admin/spree_backend

SpreeCoinbase = {
  hideSettings: function(paymentMethod) {
    if (SpreeCoinbase.paymentMethodID && paymentMethod.val() == SpreeCoinbase.paymentMethodID) {
      alert('You cannot make a Coinbase payment through the admin backend at this time.');
    }
  }
}

$(document).ready(function() {
  checkedPaymentMethod = $('[data-hook="payment_method_field"] input[type="radio"]:checked');
  SpreeCoinbase.hideSettings(checkedPaymentMethod);
  paymentMethods = $('[data-hook="payment_method_field"] input[type="radio"]').click(function (e) {
    SpreeCoinbase.hideSettings($(e.target));
  });
})
