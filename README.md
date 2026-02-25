# Side Backdrop (Margin) – Discourse Theme Component

Toont links en rechts **naast** de Discourse layout een “backdrop” (decoratieve afbeelding),
alleen als er voldoende ruimte is (dus niet op mobiel / smalle schermen).

## Belangrijkste fix voor brede (4K) schermen
Deze component meet de randen van `#main-outlet-wrapper` (als die bestaat), omdat dat doorgaans het
meest overeenkomt met de **visuele** site-rand. Daardoor sluiten de backdrops strak aan op de layout.

## Instellingen
- `gap_from_site_left/right`: extra marge (px) tussen site-rand en backdrop (zet op 0 voor strak)
- `min_viewport_width`: onder deze viewportbreedte wordt niets getoond
- `min_side_space`: minimale beschikbare marge per zijde om een paneel te tonen
- `max_side_width`: maximale paneelbreedte
- styling: opacity/repeat/size/position/mirror

## Nieuwe presets toevoegen
1. Voeg een bestand toe onder `assets/`
2. Voeg het toe aan `about.json` onder `assets`
3. Voeg de choice toe aan `settings.yml` bij `backdrop_preset`
4. Breid de mapping uit in `common/common.scss`
