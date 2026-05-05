## Collections (5)
- motoristas: nome (String), telefone (String), certeficadocmtvde (String), cartadeconducao (String), nif (String), email (String), created_time (DateTime)
  - Used by: Homepage, Registerpage, dadosmotorista
- users: email (String), display_name (String), photo_url (ImagePath), uid (String), created_time (DateTime), phone_number (String)
- veiculos: matricula (String), marca (String), ano (String), cor (String), licencaoperador (String), email (String), ativo (Boolean), created_time (DateTime)
  - Used by: Homepage, dadosveiculos
- turnos: email (String), estado (String), inicio_turno (DateTime), ativo (Boolean), data (DateTime), fim_turno (DateTime), data_dia (String), nome_motorista (String), certificado_cmtvde (String), matricula (String), licenca_operador (String), duracao_segundos (Integer)
  - Used by: Homepage
- pausas: email (String), turno_ref (DocumentReference), data_dia (String), inicio_pausa (DateTime), fim_pausa (DateTime), ativo (Boolean)
  - Used by: Homepage

