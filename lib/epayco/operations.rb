module Epayco
  module Operations
    module ClassMethods

      private

      def create params={}, extra=nil
        if self.url == "token"
          url = "/v1/tokens"
        elsif self.url == "customers"
          url = "/payment/v1/customer/create"
        elsif self.url == "plan"
          url = "/recurring/v1/plan/create"
        elsif self.url == "subscriptions"
          url = "/recurring/v1/subscription/create"
        elsif self.url == "bank"
          url = "/restpagos/pagos/debitos.json"
        elsif self.url == "cash"
          if extra == "efecty"
            url = "/restpagos/pagos/efecties.json"
          elsif extra == "baloto"
            url = "/restpagos/pagos/balotos.json"
          elsif extra == "gana"
            url = "/restpagos/pagos/ganas.json"
          else
            raise Error.new('109', Epayco.lang)
          end
        end
        Epayco.request :post, url, extra, params, self.switch
      end

      def get uid, params={}, extra=nil
        if self.url == "customers"
          url = "/payment/v1/customer/" + Epayco.apiKey + "/" + uid + "/"
        elsif self.url == "plan"
          url = "/recurring/v1/plan/" + Epayco.apiKey + "/" + uid + "/"
        elsif self.url == "subscriptions"
          url = "/recurring/v1/subscription/" + uid + "/" + Epayco.apiKey  + "/"
        elsif self.url == "bank" || self.url == "cash"
          url = "/restpagos/pse/transactioninfomation.json?transactionID=" + uid + "&&public_key=" + Epayco.apiKey
        end
        Epayco.request :get, url, extra, params, self.switch
      end

      def update uid, params={}, extra=nil
        if self.url == "customers"
          url = "/payment/v1/customer/edit/" + Epayco.apiKey + "/" + uid + "/"
        end
        Epayco.request :post, url, extra, params, self.switch
      end

      def list params={}, extra=nil
        if self.url == "customers"
          url = "/payment/v1/customers/" + Epayco.apiKey + "/"
        elsif self.url == "plan"
          url = "/recurring/v1/plans/" + Epayco.apiKey + "/"
        elsif self.url == "subscriptions"
          url = "/recurring/v1/subscriptions/" + Epayco.apiKey
        end
        Epayco.request :get, url, extra, params, self.switch
      end

      def delete uid, params={}, extra=nil
        if self.url == "plan"
          url = "/recurring/v1/plan/remove/" + Epayco.apiKey + "/" + uid + "/"
        end
        Epayco.request :post, url, extra, params, self.switch
      end

      def cancel uid, params={}, extra=nil
        params["id"] = uid
        params["public_key"] = Epayco.apiKey
        if self.url == "subscriptions"
          url = "/recurring/v1/subscription/cancel"
        end
        Epayco.request :post, url, extra, params, self.switch
      end

    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
