############################################################################################
# Script SQL - sem dados
# Estrutura de tabelas auxiliares para a tabela de Gastos Diretos do Portal da Transparencia
############################################################################################
# Criando as tabelas auxiliares:
CREATE TABLE `banco`.`aux_org_superior` (
  `cod_org_superior` int(5) DEFAULT NULL,
  `nome_org_superior` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_org_superior`),
  KEY `org_superior_covering_index` (`cod_org_superior`,`nome_org_superior`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_org` (
  `cod_org` int(5) DEFAULT NULL,
  `nome_org` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_org`),
  KEY `org_covering_index` (`cod_org`,`nome_org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_unid_gestora` (
  `cod_unid_gestora` int(6) DEFAULT NULL,
  `nome_unid_gestora` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_unid_gestora`),
  KEY `unid_gestora_covering_index` (`cod_unid_gestora`,`nome_unid_gestora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_grupo_despesa` (
  `cod_grupo_despesa` int(1) DEFAULT NULL,
  `nome_grupo_despesa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_grupo_despesa`),
  KEY `grupo_despesa_covering_index` (`cod_grupo_despesa`,`nome_grupo_despesa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_elemento_despesa` (
  `cod_elemento_despesa` int(2) DEFAULT NULL,
  `nome_elemento_despesa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_elemento_despesa`),
  KEY `elemento_despesa_covering_index` (`cod_elemento_despesa`,`nome_elemento_despesa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_funcao` (
  `cod_funcao` int(2) DEFAULT NULL,
  `nome_funcao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_funcao`),
  KEY `funcao_covering_index` (`cod_funcao`,`nome_funcao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_subfuncao` (
  `cod_subfuncao` int(3) DEFAULT NULL,
  `nome_subfuncao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_subfuncao`),
  KEY `subfuncao_covering_index` (`cod_subfuncao`,`nome_subfuncao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_programa` (
  `cod_programa` int(4) DEFAULT NULL,
  `nome_programa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_programa`),
  KEY `programa_covering_index` (`cod_programa`,`nome_programa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `banco`.`aux_acao` (
  `cod_acao` int(4) DEFAULT NULL,
  `nome_acao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cod_acao`),
  KEY `acao_covering_index` (`cod_acao`,`nome_acao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Versao relacional dos gastos diretos (abaixo desta, a versao original, nao-relacional)
CREATE TABLE `banco`.`gastosdiretos_rel` (
  `idGastosDiretos_rel` int(11) NOT NULL AUTO_INCREMENT,
  `idGastosDiretos_orig` int (11) NOT NULL,
  `cod_org_superior` int(5) DEFAULT NULL,
  `cod_org` int(5) DEFAULT NULL,
  `cod_unid_gestora` int(6) DEFAULT NULL,
  `cod_grupo_despesa` int(1) DEFAULT NULL,
  `cod_elemento_despesa` int(2) DEFAULT NULL,
  `cod_funcao` int(2) DEFAULT NULL,
  `cod_subfuncao` int(3) DEFAULT NULL,
  `cod_programa` int(4) DEFAULT NULL,
  `cod_acao` int(4) DEFAULT NULL,
  `linguagem_cidada` varchar(255) DEFAULT NULL,
  `cod_favorecido` varchar(14) DEFAULT NULL,
  `numero_documento` varchar(41) DEFAULT NULL,
  `gestao_pagamento` varchar(41) DEFAULT NULL,
  `data_pagamento` date DEFAULT NULL,
  `valor` decimal(13,2) DEFAULT NULL,
  `new_ano_arquivo_orig` year DEFAULT NULL,
  `new_mes_arquivo_orig` int(2) DEFAULT NULL,
  `new_pessoa_juridica` tinyint(1) DEFAULT NULL,
  `new_excluir_view` tinyint(1) DEFAULT '0',
  `new_excluir_view_justificativa` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idGastosDiretos_rel`),

  KEY `idGastosDiretos_orig_index` (`idGastosDiretos_orig`),
  FOREIGN KEY (`idGastosDiretos_orig`) REFERENCES gastosdiretos(idGastosDiretos),

  KEY `cod_org_superior_index` (`cod_org_superior`),
  FOREIGN KEY (`cod_org_superior`) REFERENCES aux_org_superior(cod_org_superior),

  KEY `cod_org_index` (`cod_org`),
  FOREIGN KEY (`cod_org`) REFERENCES aux_org(cod_org),

  KEY `cod_unid_gestora_index` (`cod_unid_gestora`),
  FOREIGN KEY (`cod_unid_gestora`) REFERENCES aux_unid_gestora(cod_unid_gestora),

  KEY `cod_grupo_despesa_index` (`cod_grupo_despesa`),
  FOREIGN KEY (`cod_grupo_despesa`) REFERENCES aux_grupo_despesa(cod_grupo_despesa),

  KEY `cod_elemento_despesa_index` (`cod_elemento_despesa`),
  FOREIGN KEY (`cod_elemento_despesa`) REFERENCES aux_elemento_despesa(cod_elemento_despesa),

  KEY `cod_funcao_index` (`cod_funcao`),
  FOREIGN KEY (`cod_funcao`) REFERENCES aux_funcao(cod_funcao),

  KEY `cod_subfuncao_index` (`cod_subfuncao`),
  FOREIGN KEY (`cod_subfuncao`) REFERENCES aux_subfuncao(cod_subfuncao),

  KEY `cod_programa_index` (`cod_programa`),
  FOREIGN KEY (`cod_programa`) REFERENCES aux_programa(cod_programa),

  KEY `cod_acao_index` (`cod_acao`),
  FOREIGN KEY (`cod_acao`) REFERENCES aux_acao(cod_acao),

  KEY `cod_favorecido_index` (`cod_favorecido`),
  KEY `data_pagamento_index` (`data_pagamento`),
  KEY `new_pessoa_juridica_index` (`new_pessoa_juridica`),
  KEY `gastosdiretos_rel_covering_index` (`cod_favorecido`,`cod_org_superior`,`cod_org`,`cod_unid_gestora`,`cod_grupo_despesa`,`cod_elemento_despesa`,`cod_funcao`,`cod_subfuncao`,`cod_programa`,`cod_acao`,`data_pagamento`,`valor`,`new_ano_arquivo_orig`,`new_mes_arquivo_orig`,`new_pessoa_juridica`,`new_excluir_view`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# Abaixo esta a tabela original, sem relacionamentos. Foi para esta tabela que, primeiramente,
# importamos os .csv do Portal da Transparencia. Depois, utilizamos essa tabela para os INSERT
# das tabelas auxiliares. O dump com os dados das tabelas auxiliares (quer dizer, com as tabelas
# criadas acima mais os dados) tambem esta disponivel neste repositorio.
CREATE TABLE `banco`.`gastosdiretos` (
  `idGastosDiretos` int(11) NOT NULL AUTO_INCREMENT,
  `cod_org_superior` varchar(255) DEFAULT NULL,
  `nome_org_superior` varchar(255) DEFAULT NULL,
  `cod_org` varchar(255) DEFAULT NULL,
  `nome_org` varchar(255) DEFAULT NULL,
  `cod_unid_gestora` varchar(255) DEFAULT NULL,
  `nome_unid_gestora` varchar(255) DEFAULT NULL,
  `cod_grupo_despesa` varchar(255) DEFAULT NULL,
  `nome_grupo_despesa` varchar(255) DEFAULT NULL,
  `cod_elemento_despesa` varchar(255) DEFAULT NULL,
  `nome_elemento_despesa` varchar(255) DEFAULT NULL,
  `cod_funcao` varchar(255) DEFAULT NULL,
  `nome_funcao` varchar(255) DEFAULT NULL,
  `cod_subfuncao` varchar(255) DEFAULT NULL,
  `nome_subfuncao` varchar(255) DEFAULT NULL,
  `cod_programa` varchar(255) DEFAULT NULL,
  `nome_programa` varchar(255) DEFAULT NULL,
  `cod_acao` varchar(255) DEFAULT NULL,
  `nome_acao` varchar(255) DEFAULT NULL,
  `linguagem_cidada` varchar(255) DEFAULT NULL,
  `cod_favorecido` varchar(255) DEFAULT NULL,
  `nome_favorecido` varchar(255) DEFAULT NULL,
  `numero_documento` varchar(255) DEFAULT NULL,
  `gestao_pagamento` varchar(255) DEFAULT NULL,
  `data_pagamento` varchar(255) DEFAULT NULL,
  `valor` varchar(255) DEFAULT NULL,
  `new_pessoa_juridica` tinyint(1) DEFAULT NULL,
  `new_arquivo_orig` varchar(255)  NOT NULL,
  PRIMARY KEY (`idGastosDiretos`),
  UNIQUE KEY `idGastosDiretos_UNIQUE` (`idGastosDiretos`),
  KEY `cod_favorecido_index` (`cod_favorecido`),
  KEY `new_pessoa_juridica_index` (`new_pessoa_juridica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;