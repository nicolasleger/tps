class ChampsService
  class << self
    def save_formulaire(champs, params, check_mandatory = true)
      champs.select { |c| c.type_champ != 'datetime' }
            .each { |c| c.value = params[:champs]["'#{c.id}'"] }

      champs.select { |c| c.type_champ == 'datetime' }
            .each { |c| c.value = parse_datetime(c.id, params) }

      champs.select(&:changed?).each(&:save)

      return [] unless check_mandatory
      champs.select(&:mandatory_and_blank?)
            .map { |c| build_error_message_for(c) }
    end

    private

    def parse_datetime(champ_id, h)
      "#{h[:champs]["'#{champ_id}'"]} #{extract_hour(champ_id, h)}:#{extract_minute(champ_id, h)}"
    end

    def extract_hour(champ_id, h)
      h[:time_hour]["'#{champ_id}'"]
    end

    def extract_minute(champ_id, h)
      h[:time_minute]["'#{champ_id}'"]
    end

    def build_error_message_for(champ)
      { message: "Le champ #{champ.libelle} doit être rempli." }
    end
  end
end
