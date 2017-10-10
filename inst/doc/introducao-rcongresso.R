## ---- warning=FALSE, message=FALSE---------------------------------------
library(rcongresso)
library(DT)
library(magrittr)
library(dplyr)
library(knitr)

## ------------------------------------------------------------------------
pl4302_id <- fetch_id_proposicao(tipo="PL", numero=4302, ano=1998)

## ------------------------------------------------------------------------
pl4302 <- fetch_proposicao(id_prop=pl4302_id)

## ------------------------------------------------------------------------
colnames(pl4302)

## ------------------------------------------------------------------------
pl4302 %>% 
  select(id, uri, numero, ano, ementa, dataApresentacao) %>%
  kable()

## ------------------------------------------------------------------------
votacoes_pl4302 <- fetch_votacoes(id_prop=pl4302_id)

## ------------------------------------------------------------------------
colnames(votacoes_pl4302)

## ------------------------------------------------------------------------
votacoes_pl4302 %>% 
  select(id, titulo, placarSim, placarNao, placarAbstencao) %>% 
  kable()

## ------------------------------------------------------------------------
votacao_aprovacao_terceirizacao <- fetch_votacao(id_votacao=7431)

## ------------------------------------------------------------------------
colnames(votacao_aprovacao_terceirizacao)

## ------------------------------------------------------------------------
data.frame(id=votacao_aprovacao_terceirizacao$id, titulo=votacao_aprovacao_terceirizacao$titulo, 
           dataHoraInicio=votacao_aprovacao_terceirizacao$dataHoraInicio, dataHoraFim=votacao_aprovacao_terceirizacao$dataHoraFim) %>%
  kable()

## ------------------------------------------------------------------------
fetch_orientacoes(id_votacao=7431) %>% 
  select(nomeBancada, voto) %>% 
  datatable()

## ------------------------------------------------------------------------
votos_aprovacao_terceirizacao <- fetch_votos(id_votacao=7431)

## ------------------------------------------------------------------------
colnames(votacao_aprovacao_terceirizacao)

## ------------------------------------------------------------------------
votos_aprovacao_terceirizacao %>% 
  select(parlamentar.id, parlamentar.nome, parlamentar.siglaPartido, voto) %>% 
  datatable()

## ------------------------------------------------------------------------
fetch_deputado(178957) %>%
  select(-uri) %>%
  kable()

