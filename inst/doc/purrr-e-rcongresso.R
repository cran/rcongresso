## ---- warning=FALSE, message=FALSE---------------------------------------
library(rcongresso)
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

## ------------------------------------------------------------------------
proposicoes = frame_data(
  ~tipo, ~numero, ~ano,
  "PEC", 171,     1993,
  "PL",  1057,    2007
) %>%
  pmap(fetch_id_proposicao) %>%
  map_df(~ (fetch_proposicao(.)))

glimpse(proposicoes)

## ------------------------------------------------------------------------
fetch_id_ultima_votacao = function(id_proposicao){
  fetch_votacoes(id_proposicao) %>%
    ultima_votacao() %>%
    pull(id)
}

## ------------------------------------------------------------------------
votos = proposicoes %>%
  mutate(id_votacao = map_int(id, ~ fetch_id_ultima_votacao(.))) %>%
  mutate(votos = map(id_votacao, ~ fetch_votos(.))) %>%
  unnest(votos)

glimpse(votos)

## ----fig.width=6---------------------------------------------------------
votos %>%
  group_by(siglaTipo, numero, ano, voto) %>%
  count() %>%
  ggplot(aes(x = paste(siglaTipo, numero, ano), y = n, fill = voto)) +
  geom_col() + 
  coord_flip()

## ------------------------------------------------------------------------
deputados = tibble(parlamentar.id = unique(votos$parlamentar.id)) %>% 
  mutate(dados_parlamentar = map(parlamentar.id, fetch_deputado)) %>% 
  unnest(dados_parlamentar)

glimpse(deputados)

## ----fig.width=6---------------------------------------------------------
votos %>% 
  left_join(deputados, by = "parlamentar.id") %>% 
  group_by(siglaTipo, numero, ano, voto, sexo) %>%
  count() %>%
  ggplot(aes(x = paste(siglaTipo, numero, ano), y = n, fill = voto)) +
  geom_col(position = "dodge") + 
  facet_wrap(~ sexo) + 
  coord_flip()

## ------------------------------------------------------------------------
orientacoes = proposicoes %>%
  mutate(id_votacao = map_int(id, ~ fetch_id_ultima_votacao(.))) %>%
  mutate(o = map(id_votacao, ~ fetch_orientacoes(.))) %>%
  unnest(o)

glimpse(orientacoes)

