# La Voce del Bruno - Franchetti

Client per il giornalino d'Istituto dell'Istituto Bruno - Franchetti.

## Come testarla

### Android

#### Distribuzioni binarie

Per testare l'app su Android, è possibile scaricare un apk precompilato dalla 

[sezione 'releases' di questa repository](https://github.com/franchetti/lavocedelbrunofranchetti-flutter/releases).

#### Build del codice sorgente
Alternativamente, è possibile clonare questa repository e compilare l'apk tramite i comandi:

```
flutter channel master && flutter upgrade // Per passare alla versione più aggiornata possibile di Flutter.
flutter pub get
flutter build apk
flutter install apk // Per installare l'app sul dispositivo.
```

### iOS

#### Build del codice sorgente

Per effettuare la build su iOS e testare un progetto locale, è necessario clonare la repository nel proprio spazio di lavoro, e disporre di Xcode installato nella versione più aggiornata possibile.

Una volta aperto il file `ios/Runner.xcworkspace`, è possibile andare a selezionare il team di firma dell'app: sarà sufficiente selezionare il proprio Apple ID (a cui si sarà eseguito l'accesso tramite le impostazioni di Xcode).

Una volta completata la configurazione di firma dell'app, sarà sufficiente eseguire da terminale:

```
flutter channel master && flutter upgrade // Per passare alla versione più aggiornata possibile di Flutter.
flutter pub get
flutter build ios
flutter install ios // Per installare l'app sul dispositivo.
```



## Struttura

La funzionalità dell'app, costituita di tre elementi essenziali, è principalmente distribuita nelle questioni di:

1. Parsing dei dati dal sito web tramite REST API di WordPress
2. Visualizzazione dei dati ottenuti dal sito
3. Manipolazioni indirette dei dati tramite riferimento, quali la condivisione di articoli tramite link e il loro salvataggio in una memoria locale

## Future implementazioni

- [ ] Caching degli articoli in una memoria locale
- [ ] Modifica a monte del meccanismo delle REST API per fornire i media degli articoli senza la necessità di effettuare una chiamata API ad ogni articolo cercato
- [ ] Implementazione del deeplinking per aprire l'app dal sito