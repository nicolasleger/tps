class PiecesJustificativesService
  def self.upload!(dossier, user, params)
    tpj_contents = dossier.types_de_piece_justificative
                          .map { |tpj| [tpj, params["piece_justificative_#{tpj.id}"]] }
                          .select { |_, content| content }

    without_virus, with_virus = tpj_contents
                                .partition { |_, content| ClamavService.safe_file?(content.path) }

    errors = with_virus
             .map { |_, content| content.original_filename + ': <b>Virus détecté !!</b>' }

    errors += without_virus
              .map { |tpj, content| save_pj(content, dossier, tpj, user) }
              .reject(&:empty?)
  end

  def self.upload_one! dossier, user, params
    content = params[:piece_justificative][:content]
    if ClamavService.safe_file? content.path
      pj = PieceJustificative.new(content: content,
                                  dossier: dossier,
                                  type_de_piece_justificative: nil,
                                  user: user)

      pj.save
    else
      pj = PieceJustificative.new
      pj.errors.add(:content, content.original_filename + ': <b>Virus détecté !!</b>')
    end

    pj
  end

  def self.save_pj(content, dossier, tpj, user)
    pj = PieceJustificative.new(content: content,
                                dossier: dossier,
                                type_de_piece_justificative: tpj,
                                user: user)

    pj.save ? '' : "le fichier #{pj.libelle} n'a pas pu être sauvegardé"
  end

  def self.missing_pj_error_messages(dossier)
    mandatories = dossier.types_de_piece_justificative.select(&:mandatory)
    presents = dossier.pieces_justificatives.map(&:type_de_piece_justificative)
    missing = mandatories.reject { |m| m.in?(presents) }

    missing.map { |m| "Le document #{m.libelle} doit être fourni." }
  end
end
