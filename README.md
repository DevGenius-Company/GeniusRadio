# Genius Radio

The amazing Genius Radio -> https://geniusradio.web.app <br>

| [<img src="https://raw.githubusercontent.com/DevGenius-Company/GeniusRadio/main/assets/avatars/emanuel.jpg" width="160px;" /><br /><sub><b>Emanuel Tesoriello</b></sub>](https://www.linkedin.com/in/emanuel-tesoriello-developer)<br /> | [<img src="https://raw.githubusercontent.com/DevGenius-Company/GeniusRadio/main/assets/avatars/giorgio.jpg" width="160px;" /><br /><sub><b>Giorgio Boa</b></sub>](https://www.linkedin.com/in/giorgio-boa-3ba717139)<br /> | [<img src="https://raw.githubusercontent.com/DevGenius-Company/GeniusRadio/main/assets/avatars/francesco.jpg" width="160px;" /><br /><sub><b>Francesco La Forgia</b></sub>](https://www.linkedin.com/in/francesco-la-forgia-808a6b151)<br /> |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |

<br><br>

# Install dependencies

- flutter pub get

# Run

- DEV -> _flutter run -d chrome --web-renderer html -t lib/dev/main.dart_
- PROD -> _flutter run -d chrome --web-renderer html -t lib/prod/main.dart_

# Build

- DEV -> _flutter build web --web-renderer html -t lib/dev/main.dart_
- PROD -> _flutter build web --web-renderer html -t lib/prod/main.dart_

## branch: 01_base

- Base di partenza, capiamo assieme come passare le variabili d'ambiente all'interno della nostra applicazione.

## branch: 02_mobx

- Utilizzo di [mobx](https://pub.dev/packages/mobx) per la gestione dello stato applicativo.

## branch: 02_mobx_sbagliato

- Errore tipico nell'uso di mobx. **Da evitare assolutamente** per non impattare su performance e leggibilità.

## branch: 03_mobx_provider

- Usiamo la combo [mobx](https://pub.dev/packages/mobx) più [provider](https://pub.dev/packages/provider) per organizzare al meglio la nostra applicazione.

## branch: main

- Applicazione completa.
