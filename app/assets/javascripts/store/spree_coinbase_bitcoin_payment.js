//= require store/spree_frontend

SpreeCoinbase = {
  hidePaymentSaveAndContinueButton: function(paymentMethod) {
    if ( (paymentMethod.val() == SpreeCoinbase.paymentMethodID) ||
         (typeof SpreePaypalExpress === 'object' && paymentMethod.val() == SpreePaypalExpress.paymentMethodID)
       ) {
      $('#checkout_form_payment .continue').hide();
    } else {
      $('#checkout_form_payment .continue').show();
    }
  }
};

$(document).ready(function() {
  checkedPaymentMethod = $('div[data-hook="checkout_payment_step"] input[type="radio"]:checked');
  SpreeCoinbase.hidePaymentSaveAndContinueButton(checkedPaymentMethod);
  paymentMethods = $('div[data-hook="checkout_payment_step"] input[type="radio"]').click(function (e) {
    SpreeCoinbase.hidePaymentSaveAndContinueButton($(e.target));
  });
});
