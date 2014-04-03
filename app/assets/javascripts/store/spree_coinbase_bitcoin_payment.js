//= require store/spree_frontend

SpreeCoinbase = {
  hidePaymentSaveAndContinueButton: function(paymentMethod) {
    if ( (paymentMethod.val() == SpreeCoinbase.paymentMethodID) ||
         (typeof SpreePaypalExpress === 'object' && paymentMethod.val() == SpreePaypalExpress.paymentMethodID)
       ) {
      $('.continue').hide();
    } else {
      $('.continue').show();
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
