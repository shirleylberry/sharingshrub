class PledgesController < ApplicationController

    def new
        @event = set_event
        @pledge = @event.pledges.build
    end

    def create
        amount = pledge_params[:amount]
        result = Braintree::Transaction.sale( 
                  :amount => amount,
                  :payment_method_nonce => "fake-valid-nonce",
                  :options => {
                    :submit_for_settlement => true
                 }
                )
        @pledge = Pledge.new(pledge_params_with_transaction_id(result))
        @pledge.donor = Donor.find_or_create_by(user: current_user)
        @pledge.event = set_event
        if @pledge.save
            @pledge.event.update_funded_status_if_goal_reached
            redirect_to event_path(set_event)
        else
            render 'new'
        end
    end

    private

    def pledge_params_with_transaction_id(result)
        pledge_object = pledge_params
        pledge_object[:transaction_id] = result.transaction.id
        pledge_object
    end

    def pledge_params
        params.require(:pledge).permit(:amount)
    end

    def payment_nonce
        # in production, this method will replace
        permitted = params.permit(:payment_method_nonce)
        permitted[:payment_method_nonce]
    end

    def set_event
       Event.find(params[:event_id])
    end

end
