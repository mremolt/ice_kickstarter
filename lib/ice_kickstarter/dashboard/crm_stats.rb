module IceKickstarter
  module Dashboard
    class CrmStats
      def contacts
        @contacts ||= Infopark::Crm::Contact.search('*').size
      end

      def accounts
        @accounts ||= Infopark::Crm::Account.search('*').size
      end

      def mailings
        @mailings ||= Infopark::Crm::Mailing.search('*').size
      end

      def events
        @events ||= Infopark::Crm::Event.search('*').size
      end

      def activities
        @activities ||= Infopark::Crm::Activity.search('*').size
      end
    end
  end
end