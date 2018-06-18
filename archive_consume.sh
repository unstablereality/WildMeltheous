#!/bin/bash

cd ~/projects/WildMeltheous
ebooks archive unstablereality corpus/unstablereality.json
ebooks consume corpus/unstablereality.json
git add model/unstablereality.model
git commit -m ":card_index: Updating text model for $(date +%Y-%m-%d)"
git push origin master
