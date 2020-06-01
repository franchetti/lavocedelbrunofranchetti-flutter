# La Voce del Bruno - Franchetti

Client per il giornalino d'Istituto dell'Istituto Bruno - Franchetti.

## Premessa

La funzionalità dell'app, costituita di tre elementi essenziali, è principalmente distribuita nelle questioni di:

1. Parsing dei dati dal sito web tramite REST API di WordPress
2. Visualizzazione dei dati ottenuti dal sito
3. Manipolazioni indirette dei dati tramite riferimento, quali la condivisione di articoli tramite link e il loro salvataggio in una memoria locale

## Future implementazioni

- [ ] Caching degli articoli in una memoria locale
- [ ] Modifica a monte del meccanismo delle REST API per fornire i media degli articoli senza la necessità di effettuare una chiamata API ad ogni articolo cercato
- [ ] Implementazione del deeplinking per aprire l'app dal sito