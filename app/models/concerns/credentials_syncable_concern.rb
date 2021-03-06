module CredentialsSyncableConcern
    extend ActiveSupport::Concern

    included do
      after_update :sync_credentials
    end

    def sync_credentials
      if email_changed? || encrypted_password_changed?
        return force_sync_credentials
      end
      true
    end

    def force_sync_credentials
      SyncCredentialsService.new(self.class, email_was, email, encrypted_password).change_credentials!
    end

end
