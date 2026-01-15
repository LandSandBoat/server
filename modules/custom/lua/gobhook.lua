-----------------------------------
-- Goblin Mafia
-----------------------------------

xi = xi or {}
xi.mafia = xi.mafia or {}

xi.mafia.GIL_REWARD = 13515

xi.mafia.CONTRACTS =
{
    [1]   = { mobId = zones[xi.zone.VALLEY_OF_SORROWS].mob.ADAMANTOISE, mobName = 'Adamantoise', item = xi.item.HEAVY_CUIRASS, itemName = 'Heavy Cuirass', reward = 1000, bonus = 100 },
    [2]   = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.ALASTOR_ANTLION, mobName = 'Alastor Antlion', item = xi.item.ROSTRUM_PUMPS, itemName = 'Rostrum Pumps', reward = 1000, bonus = 1000 },
    [3]   = { mobId = zones[xi.zone.UPPER_DELKFUTTS_TOWER].mob.ALKYONEUS, mobName = 'Alkyoneus', item = xi.item.ALKYONEUSS_BRACELETS, itemName = 'Alkyoneus\'s Bracelets', reward = 300, bonus = 500 },
    [4]   = { mobId = zones[xi.zone.WEST_RONFAURE].mob.AMANITA, mobName = 'Amanita', item = xi.item.TENAX_STRAP, itemName = 'Tenax Strap', reward = 150, bonus = 100 },
    [5]   = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.AMBUSHER_ANTLION, mobName = 'Ambusher Antlion', item = xi.item.ARCHERS_JUPON, itemName = 'Archer\'s Jupon', reward = 500, bonus = 300 },
    [6]   = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.AMIKIRI, mobName = 'Amikiri', item = xi.item.KAMEWARI, itemName = 'Kamewari', reward = 500, bonus = 100 },
    [7]   = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.ANCIENT_GOOBBUE, mobName = 'Ancient Goobbue', item = xi.item.DAIHANNYA, itemName = 'Daihannya', reward = 300, bonus = 100 },
    [8]   = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_CONSUL, mobName = 'Antican Consul', item = xi.item.BERSERKERS_AXE, itemName = 'Berserker\'s Axe', reward = 300, bonus = 100 },
    [9]   = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_LEGATUS, mobName = 'Antican Legatus', item = xi.item.PALADINS_TESTIMONY, itemName = 'Pld. Testimony', reward = 100, bonus = 300 },
    [10]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_MAGISTER, mobName = 'Antican Magister', item = xi.item.ARCANABANE, itemName = 'Arcanabane', reward = 500, bonus = 100 },
    [11]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_PRAEFECTUS, mobName = 'Antican Praefectus', item = xi.item.SAVE_THE_QUEEN, itemName = 'Save The Queen', reward = 500, bonus = 100 },
    [12]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.ANTICAN_TRIBUNUS, mobName = 'Antican Tribunus', item = xi.item.PHAROAHS_BOW, itemName = 'Pharoah\'s Bow', reward = 500, bonus = 100 },
    [13]  = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.AQUARIUS, mobName = 'Aquarius', item = xi.item.FRANSISCA, itemName = 'Fransisca', reward = 500, bonus = 300 },
    [14]  = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.ASH_DRAGON, mobName = 'Ash Dragon', item = xi.item.MURASAME, itemName = 'Murasame', reward = 1000, bonus = 1000 },
    [15]  = { mobId = zones[xi.zone.YUGHOTT_GROTTO].mob.ASHMAKER_GOTBLUT, mobName = 'Ashmaker Gotblut', item = xi.item.PRIESTS_ROBE, itemName = 'Priest\'s Robe', reward = 500, bonus = 200 },
    [16]  = { mobId = zones[xi.zone.GUSGEN_MINES].mob.ASPHYXIATED_AMSEL, mobName = 'Asphyxiated Amsel', item = xi.item.MALGUST_RING, itemName = 'Malgust Ring', reward = 150, bonus = 100 },
    [17]  = { mobId = zones[xi.zone.VALLEY_OF_SORROWS].mob.ASPIDOCHELONE, mobName = 'Aspidochelone', item = xi.item.ADAMANTOISE_EGG, itemName = 'Adamantoise Egg', reward = 1000, bonus = 1000 },
    [18]  = { mobId = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S].mob.BALAM_QUITZ, mobName = 'Balam Quitz', item = xi.item.THUNDERERS_MANTLE, itemName = 'Thunderer\'s Mantle', reward = 500, bonus = 100 },
    [19]  = { mobId = zones[xi.zone.BATALLIA_DOWNS_S].mob.BURLIBIX_BRAWNBACK, mobName = 'Burlibix Brawnback', item = xi.item.SORTIE_RING, itemName = 'Sortie Ring', reward = 500, bonus = 100 },
    [20]  = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.BAOBHAN_SITH, mobName = 'Baobhan Sith', item = xi.item.CHEVIOT_CLOTH, itemName = 'Cheviot Cloth', reward = 500, bonus = 100 },
    [21]  = { mobId = zones[xi.zone.CASTLE_ZVAHL_KEEP].mob.BARONET_ROMWE, mobName = 'Baronet Romwe', item = xi.item.DEMONS_AXE, itemName = 'Demon\'s Axe', reward = 500, bonus = 100 },
    [22]  = { mobId = zones[xi.zone.NORTH_GUSTABERG].mob.BEDROCK_BARRY, mobName = 'Bedrock Barry', item = xi.item.FLAWED_GARNET, itemName = 'Flawed Garnet', reward = 150, bonus = 100 },
    [23]  = { mobId = zones[xi.zone.BEHEMOTHS_DOMINION].mob.BEHEMOTH, mobName = 'Behemoth', item = xi.item.COMET_TAIL, itemName = 'Comet Tail', reward = 1000, bonus = 300 },
    [24]  = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.BERYL_FOOTED_MOLBERRY, mobName = 'Beryl Footed Molberry', item = xi.item.HOTOTOGISU, itemName = 'Hototogisu', reward = 500, bonus = 300 },
    [25]  = { mobId = zones[xi.zone.BEADEAUX].mob.BI_GHO_HEADTAKER, mobName = 'Bi\'Gho Headtaker', item = xi.item.PLANTBANE, itemName = 'Plantbane', reward = 500, bonus = 100 },
    [26]  = { mobId = zones[xi.zone.XARCABARD].mob.BIAST, mobName = 'Biast', item = xi.item.PATROCLUSS_HELM, itemName = 'Patroclus\'s Helm', reward = 500, bonus = 1000 },
    [27]  = { mobId = zones[xi.zone.HALVUNG].mob.BIG_BOMB, mobName = 'Big Bomb', item = xi.item.FIRE_BOMBLET, itemName = 'Fire Bomblet', reward = 500, bonus = 1000 },
    [28]  = { mobId = zones[xi.zone.YHOATOR_JUNGLE].mob.BISQUE_HEELED_SUNBERRY, mobName = 'Bisque-heeled Sunberry', item = xi.item.RANCOR_HANDLE, itemName = 'Rancor Handle', reward = 150, bonus = 100 },
    [29]  = { mobId = zones[xi.zone.PASHHOW_MARSHLANDS].mob.BLOODPOOL_VORAX, mobName = 'Bloodpool Vorax', item = xi.item.BLOODBEAD_AMULET, itemName = 'Bloodbead Amulet', reward = 500, bonus = 200 },
    [30]  = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.BLOODSUCKER, mobName = 'Bloodsucker', item = xi.item.BLOODBEAD_RING, itemName = 'Bloodbead Ring', reward = 100, bonus = 500 },
    [31]  = { mobId = zones[xi.zone.LA_THEINE_PLATEAU].mob.BLOODTEAR, mobName = 'Bloodtear Baldurf', item = xi.item.VIKING_SHIELD, itemName = 'Viking Shield', reward = 500, bonus = 100 },
    [32]  = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.BLOODTHIRSTER_MADKIX, mobName = 'Bloodthirster Madkin', item = xi.item.ACHA_DARMAS, itemName = 'Acha D\'Armas', reward = 500, bonus = 100 },
    [33]  = { mobId = zones[xi.zone.DAVOI].mob.BLUBBERY_BULGE, mobName = 'Blueberry Bulge', item = xi.item.VIAL_OF_SLIME_OIL, itemName = 'Slime Oil', reward = 500, bonus = 100 },
    [34]  = { mobId = zones[xi.zone.AYDEEWA_SUBTERRANE].mob.BLUESTREAK_GYUGYUROON, mobName = 'Bluestreak Gyugyuroon', item = xi.item.PEACEMAKER, itemName = 'Peacemaker', reward = 700, bonus = 100 },
    [35]  = { mobId = zones[xi.zone.PASHHOW_MARSHLANDS].mob.BOWHO_WARMONGER, mobName = 'Bo\'Who Warmonger', item = xi.item.TORTOISE_SHIELD, itemName = 'Tortoise Shield', reward = 500, bonus = 100 },
    [36]  = { mobId = zones[xi.zone.JUGNER_FOREST_S].mob.BOLL_WEEVIL, mobName = 'Boll Weevil', item = xi.item.NASATYAS_RING, itemName = 'Nasatyas Ring', reward = 150, bonus = 100 },
    [37]  = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.BOMB_QUEEN, mobName = 'Bomb Queen', item = xi.item.AVENGERS, itemName = 'Avengers', reward = 800, bonus = 800 },
    [38]  = { mobId = zones[xi.zone.ULEGUERAND_RANGE].mob.BONNACON, mobName = 'Bonnacon', item = xi.item.CURE_CLOGS, itemName = 'Cure Clogs', reward = 500, bonus = 500 },
    [39]  = { mobId = zones[xi.zone.YHOATOR_JUNGLE].mob.BRIGHT_HANDED_KUNBERRY, mobName = 'Bright-Handed Kunberry', item = xi.item.RESENTMENT_CAPE, itemName = 'Resentment Cape', reward = 300, bonus = 100 },
    [40]  = { mobId = zones[xi.zone.PALBOROUGH_MINES].mob.BU_GHI_HOWLBLADE, mobName = 'Bu\'Ghi Howlblade', item = xi.item.MARINE_SHIELD, itemName = 'Marine Shield', reward = 500, bonus = 100 },
    [41]  = { mobId = zones[xi.zone.BUBURIMU_PENINSULA].mob.BUBURIMBOO, mobName = 'Buburimboo', item = xi.item.BUBURIMU_GORGET, itemName = 'Buburimu Gorget', reward = 500, bonus = 100 },
    [42]  = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.BUNE, mobName = 'Bune', item = xi.item.ENHANCING_SWORD, itemName = 'Enhancing Sword', reward = 1000, bonus = 1000 },
    [43]  = { mobId = zones[xi.zone.GUSGEN_MINES].mob.BURNED_BERGMANN, mobName = 'Burned Bergmann', item = xi.item.MALFLAME_RING, itemName = 'Malflame Ring', reward = 150, bonus = 100 },
    [44]  = { mobId = zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CACTROT_RAPIDO, mobName = 'Cactrot Rapido', item = xi.item.ARCO_DE_VELOCIDAD, itemName = 'Arco de Velocidad', reward = 1000, bonus = 100 },
    [45]  = { mobId = zones[xi.zone.WESTERN_ALTEPA_DESERT].mob.CACTUAR_CANTAUTOR, mobName = 'Cactuar Cantautor', item = xi.item.KUNG_FU_SHOES, itemName = 'Kung Fu Shoes', reward = 500, bonus = 400 },
    [46]  = { mobId = zones[xi.zone.BATALLIA_DOWNS].mob.PRANKSTER_MAVERIX, mobName = 'Prankster Maverix', item = xi.item.VOLANT_BELT, itemName = 'Volant Belt', reward = 500, bonus = 100 },
    [47]  = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.CANCER, mobName = 'Cancer', item = xi.item.ARONDIGHT, itemName = 'Arondight', reward = 100, bonus = 100 },
    [48]  = { mobId = zones[xi.zone.FEIYIN].mob.CAPRICIOUS_CASSIE, mobName = 'Capricious Cassie', item = xi.item.CASSIE_EARRING, itemName = 'Cassie Earring', reward = 700, bonus = 1000 },
    [49]  = { mobId = zones[xi.zone.KORROLOKA_TUNNEL].mob.CARGO_CRAB_COLIN, mobName = 'Cargo Crab Colin', item = xi.item.NADRS, itemName = 'Nadrs', reward = 500, bonus = 100 },
    [50]  = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.CELESTE_EYED_TOZBERRY, mobName = 'Celeste-eyed Tozberry', item = xi.item.KITSUTSUKI, itemName = 'Kitsutsuki', reward = 500, bonus = 100 },
    [51]  = { mobId = zones[xi.zone.WESTERN_ALTEPA_DESERT].mob.CELPHIE, mobName = 'Celphie', item = xi.item.DHALMEL_WHISTLE, itemName = 'Dhalmel Whistle', reward = 500, bonus = 100 },
    [52]  = { mobId = zones[xi.zone.KING_RANPERRES_TOMB].mob.CEMETERY_CHERRY, mobName = 'Cemetery Cherry', item = xi.item.LIVING_ROD, itemName = 'Living Rod', reward = 500, bonus = 100 },
    [53]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.CENTURIO_X_I, mobName = 'Centurio X-I', item = xi.item.SHAMANS_CLOAK, itemName = 'Shaman\'s Cloak', reward = 500, bonus = 500 },
    [54]  = { mobId = zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.CENTURIO_XII_I, mobName = 'Centurio XII-I', item = xi.item.INTRUDER_EARRING, itemName = 'Intruder Earring', reward = 300, bonus = 400 },
    [55]  = { mobId = zones[xi.zone.MOUNT_ZHAYOLM].mob.CERBERUS, mobName = 'Cerberus', item = xi.item.ALGOL, itemName = 'Algol', reward = 1000, bonus = 500 },
    [56]  = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.CHARYBDIS, mobName = 'Charybdis', item = xi.item.JOYEUSE, itemName = 'Joyeuse', reward = 1000, bonus = 1000 },
    [57]  = { mobId = zones[xi.zone.DANGRUF_WADI].mob.CHOCOBOLEECH, mobName = 'Chocoboleech', item = xi.item.GASSAN, itemName = 'Gassan', reward = 100, bonus = 200 },
    [58]  = { mobId = zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.CHONCHON, mobName = 'Chonchon', item = xi.item.HEADLONG_BELT, itemName = 'Headlong Belt', reward = 150, bonus = 1000 },
    [59]  = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.CITIPATI, mobName = 'Citipati', item = xi.item.HARPE, itemName = 'Harpe', reward = 500, bonus = 100 },
    [60]  = { mobId = zones[xi.zone.LUFAISE_MEADOWS].mob.COLORFUL_LESHY, mobName = 'Colorful Leshy', item = xi.item.HARVEST_EARRING, itemName = 'Harvest Earring', reward = 300, bonus = 400 },
    [61]  = { mobId = zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.COO_KEJA_THE_UNSEEN, mobName = 'Coo Keja the Unseen', item = xi.item.AJASE_BEADS, itemName = 'Ajase Beads', reward = 300, bonus = 300 },
    [62]  = { mobId = zones[xi.zone.CASTLE_ZVAHL_KEEP].mob.COUNT_BIFRONS, mobName = 'Count Bifrons', item = xi.item.GOSHISHOS_SCYTHE, itemName = 'Goshisho\'s Scythe', reward = 500, bonus = 100 },
    [63]  = { mobId = zones[xi.zone.GUSGEN_MINES].mob.CRUSHED_KRAUSE, mobName = 'Crushed Krause', item = xi.item.MALDUST_RING, itemName = 'Maldust Ring', reward = 150, bonus = 100 },
    [64]  = { mobId = zones[xi.zone.THE_ELDIEME_NECROPOLIS].mob.CWN_CYRFF, mobName = 'Cwn Cyrff', item = xi.item.SWAN_BILBO, itemName = 'Swan Bilbo', reward = 500, bonus = 100 },
    [65]  = { mobId = zones[xi.zone.BEADEAUX].mob.DA_DHA_HUNDREDMASK, mobName = 'Da\'Dha Hundredmask', item = xi.item.MITHRAN_SCIMITAR, itemName = 'Mithran Scimitar', reward = 500, bonus = 100 },
    [66]  = { mobId = zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.DAGGERCLAW_DRACOS, mobName = 'Daggerclaw Dracos', item = xi.item.SONIC_KNUCKLES, itemName = 'Sonic Knuckles', reward = 500, bonus = 100 },
    [67]  = { mobId = zones[xi.zone.KORROLOKA_TUNNEL].mob.DAME_BLANCHE, mobName = 'Dame Blanche', item = xi.item.SARCENET_CLOTH, itemName = 'Sarcenet Cloth', reward = 500, bonus = 100 },
    [68]  = { mobId = zones[xi.zone.MAMOOK].mob.DARTING_KACHAAL_JA, mobName = 'Darting Kachaal Ja', item = xi.item.VOLUNTEERS_BELT, itemName = 'Volunteers Belt', reward = 700, bonus = 100 },
    [69]  = { mobId = zones[xi.zone.BEADEAUX].mob.DE_VYU_HEADHUNTER, mobName = 'De\'Vyu Headhunter', item = xi.item.QUADAV_CHARM, itemName = 'Quadav Charm', reward = 100, bonus = 100 },
    [70]  = { mobId = zones[xi.zone.SAUROMUGUE_CHAMPAIGN].mob.DEADLY_DODO, mobName = 'Deadly Dodo', item = xi.item.DODO_SKIN, itemName = 'Dodo Skin', reward = 500, bonus = 300 },
    [71]  = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.DEATH_FROM_ABOVE, mobName = 'Death From Above', item = xi.item.HORNETNEEDLE, itemName = 'Hornetneedle', reward = 100, bonus = 1000 },
    [72]  = { mobId = zones[xi.zone.CRAWLERS_NEST].mob.DEMONIC_TIPHIA, mobName = 'Demonic Tiphia', item = xi.item.TIPHIA_STING, itemName = 'Tiphia Sting', reward = 500, bonus = 300 },
    [73]  = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.DIAMOND_DAIG, mobName = 'Diamond Daig', item = xi.item.PROTECTING_BANGLES, itemName = 'Protecting Bangles', reward = 500, bonus = 100 },
    [74]  = { mobId = zones[xi.zone.DAVOI].mob.DIRTYHANDED_GOCHAKZUK, mobName = 'Dirtyhanded Gochakzuk', item = xi.item.CURSE_WAND, itemName = 'Curse Wand', reward = 100, bonus = 100 },
    [75]  = { mobId = zones[xi.zone.HALVUNG].mob.DORGERWOR_THE_ASTUTE, mobName = 'Dorgerwor the Astute', item = xi.item.MERCENARYS_MANTLE, itemName = 'Mercenary\'s Mantle', reward = 1000, bonus = 500 },
    [76]  = { mobId = zones[xi.zone.MAMOOK].mob.DRAGONSCALED_BUGAAL_JA, mobName = 'Dragonscaled Bagaal Ja', item = xi.item.BEAST_BAZUBANDS, itemName = 'Beast Bazubands', reward = 700, bonus = 100 },
    [78]  = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.DREXERION_THE_CONDEMNED, mobName = 'Drexerion the Condemned', item = xi.item.FLAGELLANTS_CROSSBOW, itemName = 'Flagellant\'s Crossbow', reward = 500, bonus = 100 },
    [79]  = { mobId = zones[xi.zone.ROLANBERRY_FIELDS].mob.DROOLING_DAISY, mobName = 'Drooling Daisy', item = xi.item.DODGE_HEADBAND, itemName = 'Dodge Headband', reward = 500, bonus = 300 },
    [80]  = { mobId = zones[xi.zone.EAST_SARUTABARUTA].mob.DUKE_DECAPOD, mobName = 'Duke Decapod', item = xi.item.PELTE, itemName = 'Pelte', reward = 150, bonus = 100 },
    [81]  = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.DUKE_HABORYM, mobName = 'Duke Haborym', item = xi.item.BARBARIANS_SCYTHE, itemName = 'Barbarian\'s Scythe', reward = 300, bonus = 100 },
    [82]  = { mobId = zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.DUNE_WIDOW, mobName = 'Dune Widow', item = xi.item.SPIDER_TORQUE, itemName = 'Spider Torque', reward = 500, bonus = 600 },
    [83]  = { mobId = zones[xi.zone.CRAWLERS_NEST].mob.DYNAST_BEETLE, mobName = 'Dynast Beetle', item = xi.item.DASRAS_RING, itemName = 'Dasra\'s Ring', reward = 150, bonus = 100 },
    [84]  = { mobId = zones[xi.zone.FEIYIN].mob.EASTERN_SHADOW, mobName = 'Eastern Shadow', item = xi.item.VALIS_BOW, itemName = 'Vali\'s Bow', reward = 500, bonus = 100 },
    [85]  = { mobId = zones[xi.zone.PHOMIUNA_AQUEDUCTS].mob.EBA, mobName = 'Eba', item = xi.item.FORMOR_TUNIC, itemName = 'Formor Tunic', reward = 1000, bonus = 1000 },
    [86]  = { mobId = zones[xi.zone.YHOATOR_JUNGLE].mob.EDACIOUS_OPO_OPO, mobName = 'Edacious Opo-opo', item = xi.item.NANBAN_KARIGINU, itemName = 'Nanban Kariginu', reward = 100, bonus = 100 },
    [87]  = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.ELLYLLON, mobName = 'Ellyllon', item = xi.item.MUSHROOM_HELM, itemName = 'Mushroom Helm', reward = 500, bonus = 100 },
    [88]  = { mobId = zones[xi.zone.BHAFLAU_THICKETS].mob.EMERGENT_ELM, mobName = 'Emergent Elm', item = xi.item.ARBORIST_NAILS, itemName = 'Arborist Nails', reward = 500, bonus = 100 },
    [89]  = { mobId = zones[xi.zone.MOUNT_ZHAYOLM].mob.ENERGETIC_ERUCA, mobName = 'Energetic Eruca', item = xi.item.HANZO_TEKKO, itemName = 'Hanzo Tekko', reward = 700, bonus = 500 },
    [90]  = { mobId = zones[xi.zone.BATALLIA_DOWNS].mob.EYEGOUGER, mobName = 'Eyegouger', item = xi.item.BRAWN_EARRING, itemName = 'Brawn Earring', reward = 150, bonus = 100 },
    [91]  = { mobId = zones[xi.zone.GIDDEUS].mob.EYY_MON_THE_IRONBREAKER, mobName = 'Eyy Mon the Ironbreaker', item = xi.item.ASPIR_KNIFE, itemName = 'Aspir Knife', reward = 100, bonus = 100 },
    [92]  = { mobId = zones[xi.zone.DRAGONS_AERY].mob.FAFNIR, mobName = 'Fafnir', item = xi.item.BALMUNG, itemName = 'Balmung', reward = 1000, bonus = 500 },
    [93]  = { mobId = zones[xi.zone.KORROLOKA_TUNNEL].mob.FALCATUS_ARANEI, mobName = 'Falcatus Aranei', item = xi.item.WEBCUTTER, itemName = 'Webcutter', reward = 500, bonus = 100 },
    [94]  = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.FLAUROS, mobName = 'Flauros', item = xi.item.FLAUROS_WHISKER, itemName = 'Flauros Whisker', reward = 500, bonus = 100 },
    [95]  = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.FORESEER_ORAMIX, mobName = 'Foreseer Oramix', item = xi.item.POWER_STAFF, itemName = 'Power Staff', reward = 500, bonus = 100 },
    [96]  = { mobId = zones[xi.zone.JUGNER_FOREST].mob.FRADUBIO, mobName = 'Fradubio', item = xi.item.BELLICOSE_MANTLE, itemName = 'Bellicose Mantle', reward = 500, bonus = 100 },
    [97]  = { mobId = zones[xi.zone.JUGNER_FOREST].mob.FRAELISSA, mobName = 'Fraelissa', item = xi.item.ALMOGAVAR_BOW, itemName = 'Almogavar Bow', reward = 100, bonus = 100 },
    [98]  = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.FRIAR_RUSH, mobName = 'Friar Rush', item = xi.item.BOMB_CORE, itemName = 'Bomb Core', reward = 500, bonus = 1000 },
    [99]  = { mobId = zones[xi.zone.CAPE_TERIGGAN].mob.FROSTMANE, mobName = 'Frostmane', item = xi.item.LOCKHEART, itemName = 'Lockheart', reward = 700, bonus = 100 },
    [100] = { mobId = zones[xi.zone.WEST_RONFAURE].mob.FUNGUS_BEETLE, mobName = 'Fungus Beetle', item = xi.item.CLIPEUS, itemName = 'Clipeus', reward = 500, bonus = 100 },
    [101] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.FYUU_THE_SEABELLOW, mobName = 'Fyuu the Seabellow', item = xi.item.FROG_TROUSERS, itemName = 'Frog Trousers', reward = 500, bonus = 100 },
    [102] = { mobId = zones[xi.zone.BEADEAUX].mob.GA_BHU_UNVANQUISHED, mobName = 'Ga\'Bhu Unvanquished', item = xi.item.VALKYRIES_MASK, itemName = 'Valkyrie\'s Mask', reward = 500, bonus = 400 },
    [103] = { mobId = zones[xi.zone.BEAUCEDINE_GLACIER].mob.GARGANTUA, mobName = 'Gargantua', item = xi.item.ELEMENTAL_CHARM, itemName = 'Elemental Charm', reward = 500, bonus = 300 },
    [104] = { mobId = zones[xi.zone.BEADEAUX].mob.GE_DHA_EVILEYE, mobName = 'Ge\'Dha Evileye', item = xi.item.HOLY_PHIAL, itemName = 'Holy Phial', reward = 500, bonus = 300 },
    [105] = { mobId = zones[xi.zone.DANGRUF_WADI].mob.GEYSER_LIZARD, mobName = 'Geyser Lizard', item = xi.item.STEAM_SCALE_MAIL, itemName = 'Steam Scale Mail', reward = 150, bonus = 100 },
    [106] = { mobId = zones[xi.zone.KONSCHTAT_HIGHLANDS].mob.GHILLIE_DHU, mobName = 'Ghillie Dhu', item = xi.item.ESTRAMACON, itemName = 'Estramacon', reward = 150, bonus = 100 },
    [107] = { mobId = zones[xi.zone.NORTH_GUSTABERG_S].mob.GLOOMANITA, mobName = 'Gloomanita', item = xi.item.VIPERINE_PICK, itemName = 'Viperine Pick', reward = 500, bonus = 100 },
    [108] = { mobId = zones[xi.zone.BEADEAUX].mob.GO_BHU_GASCON, mobName = 'Go\'Bhu Gascon', item = xi.item.QUADAV_AUGURY_SHELL, itemName = 'Quadav Augury Shell', reward = 100, bonus = 100 },
    [109] = { mobId = zones[xi.zone.OLDTON_MOVALPOLOS].mob.GOBLIN_WOLFMAN, mobName = 'Goblin Wolfman', item = xi.item.PARADE_GORGET, itemName = 'Parade Gorget', reward = 100, bonus = 900 },
    [110] = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.GOBLINSAVIOR_HERONOX, mobName = 'Goblinsavior Heronox', item = xi.item.EISENTAENZER, itemName = 'Eisentaenzer', reward = 500, bonus = 100 },
    [111] = { mobId = zones[xi.zone.VALKURM_DUNES].mob.GOLDEN_BAT, mobName = 'Golden Bat', item = xi.item.NIGHT_CAPE, itemName = 'Night Cape', reward = 500, bonus = 300 },
    [112] = { mobId = zones[xi.zone.PSOXJA].mob.GOLDEN_TONGUED_CULBERRY, mobName = 'Golden Tongued Culberry', item = xi.item.UGGALEPIH_PENDANT, itemName = 'Uggalepih Pendant', reward = 1000, bonus = 1000 },
    [113] = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.GRAND_DUKE_BATYM, mobName = 'Grand Duke Batym', item = xi.item.DEMONSLICER, itemName = 'Demonslicer', reward = 300, bonus = 300 },
    [114] = { mobId = zones[xi.zone.MISAREAUX_COAST].mob.GRATION, mobName = 'Gration', item = xi.item.TATAMI_SHIELD, itemName = 'Tatami Shield', reward = 300, bonus = 1000 },
    [115] = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.GUIVRE, mobName = 'Guivre', item = xi.item.GUIVRES_SKULL, itemName = 'Guivre\'s Skull', reward = 800, bonus = 100 },
    [116] = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.HABETROT, mobName = 'Habetrot', item = xi.item.CRAWLER_EGG, itemName = 'Crawler Egg', reward = 100, bonus = 100 },
    [117] = { mobId = zones[xi.zone.TAHRONGI_CANYON].mob.HABROK, mobName = 'Habrok', item = xi.item.BESIEGER_MANTLE, itemName = 'Besieger Mantle', reward = 300, bonus = 100 },
    [118] = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.HAKUTAKU, mobName = 'Hakutaku', item = xi.item.OPTICAL_HAT, itemName = 'Optical Hat', reward = 1000, bonus = 1000 },
    [119] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.HASTATUS_XI_XII, mobName = 'Hastatus XI-XII', item = xi.item.XHIFHUT_HEAD, itemName = 'Xhifhut Head', reward = 500, bonus = 100 },
    [120] = { mobId = zones[xi.zone.DAVOI].mob.HAWKEYED_DNATBAT, mobName = 'Hawkeyed Dnatbat', item = xi.item.ASSASSINS_BOW, itemName = 'Assassin\'s Bow', reward = 500, bonus = 100 },
    [121] = { mobId = zones[xi.zone.BUBURIMU_PENINSULA].mob.HELLDIVER, mobName = 'Helldiver', item = xi.item.WINGEDGE, itemName = 'Wingedge', reward = 500, bonus = 100 },
    [122] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.HELLION, mobName = 'Hellion', item = xi.item.A_LOUTRANCE, itemName = 'A L\'Outrance', reward = 500, bonus = 100 },
    [123] = { mobId = zones[xi.zone.TAHRONGI_CANYON].mob.HERBAGE_HUNTER, mobName = 'Herbage Hunter', item = xi.item.PRECISION_BANDANA, itemName = 'Precision Bandana', reward = 500, bonus = 100 },
    [124] = { mobId = zones[xi.zone.CARPENTERS_LANDING].mob.HERCULES_BEETLE, mobName = 'Hercules Beetle', item = xi.item.BLACK_HOSE, itemName = 'Black Hose', reward = 100, bonus = 100 },
    [125] = { mobId = zones[xi.zone.KONSCHTAT_HIGHLANDS].mob.HIGHLANDER_LIZARD, mobName = 'Highlander Lizard', item = xi.item.IMMORTAL_MOLT, itemName = 'Immortal Molt', reward = 100, bonus = 100 },
    [126] = { mobId = zones[xi.zone.GIDDEUS].mob.HOO_MJUU_THE_TORRENT, mobName = 'Hoo Mjuu the Torrent', item = xi.item.MONSTER_SIGNA, itemName = 'Monster Signa', reward = 500, bonus = 300 },
    [127] = { mobId = zones[xi.zone.FORT_GHELSBA].mob.HUNDREDSCAR_HAJWAJ, mobName = 'Hundredscar Hajwaj', item = xi.item.WILD_CUDGEL, itemName = 'Wild Cudgel', reward = 500, bonus = 100 },
    [128] = { mobId = zones[xi.zone.SAUROMUGUE_CHAMPAIGN_S].mob.HYAKINTHOS, mobName = 'Hyakinthos', item = xi.item.LAVAS_RING, itemName = 'Lava\'s Ring', reward = 150, bonus = 100 },
    [129] = { mobId = zones[xi.zone.WAJAOM_WOODLANDS].mob.HYDRA, mobName = 'Hydra', item = xi.item.BERSERKERS_TORQUE, itemName = 'Berserker\'s Torque', reward = 1000, bonus = 1000 },
    [130] = { mobId = zones[xi.zone.BHAFLAU_THICKETS].mob.MAHISHASURA, mobName = 'Mahishasura', item = xi.item.VEUGLAIRE, itemName = 'Veuglaire', reward = 500, bonus = 100 },
    [131] = { mobId = zones[xi.zone.BIBIKI_BAY].mob.INTULO, mobName = 'Intulo', item = xi.item.MAGIC_SLACKS, itemName = 'Magic Slacks', reward = 500, bonus = 100 },
    [132] = { mobId = zones[xi.zone.WAJAOM_WOODLANDS].mob.JADED_JODY, mobName = 'Jaded Jody', item = xi.item.JET_SERAWEELS, itemName = 'Jet Seraweels', reward = 900, bonus = 1000 },
    [133] = { mobId = zones[xi.zone.WEST_RONFAURE].mob.JAGGEDY_EARED_JACK, mobName = 'Jaggedy-Eared Jack', item = xi.item.RABBIT_CHARM, itemName = 'Rabbit Charm', reward = 500, bonus = 1000 },
    [134] = { mobId = zones[xi.zone.PASHHOW_MARSHLANDS].mob.JOLLY_GREEN, mobName = 'Jolly Green', item = xi.item.SHAMANS_BELT, itemName = 'Shaman\'s Belt', reward = 500, bonus = 200 },
    [135] = { mobId = zones[xi.zone.ULEGUERAND_RANGE].mob.JORMUNGAND, mobName = 'Jormungand', item = xi.item.MERCURIAL_POLE, itemName = 'Mercurial Pole', reward = 1000, bonus = 500 },
    [136] = { mobId = zones[xi.zone.GUSGEN_MINES].mob.JUGGLER_HECATOMB, mobName = 'Juggler Hecatomb', item = xi.item.HEAVY_HALBERD, itemName = 'Heavy Halberd', reward = 300, bonus = 100 },
    [137] = { mobId = zones[xi.zone.GIDDEUS].mob.JUU_DUZU_THE_WHIRLWIND, mobName = 'Juu Duzu the Whirlwind', item = xi.item.HUNTERS_LONGBOW, itemName = 'Hunter\'s Longbow', reward = 500, bonus = 100 },
    [138] = { mobId = zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.KEEPER_OF_HALIDOM, mobName = 'Keeper of Halidom', item = xi.item.DAIHANNYA, itemName = 'Daihannya', reward = 500, bonus = 100 },
    [139] = { mobId = zones[xi.zone.JUGNER_FOREST].mob.KING_ARTHRO, mobName = 'King Arthro', item = xi.item.VELOCIOUS_BELT, itemName = 'Velocious Belt', reward = 1000, bonus = 1000 },
    [140] = { mobId = zones[xi.zone.BEHEMOTHS_DOMINION].mob.KING_BEHEMOTH, mobName = 'King Behemoth', item = xi.item.BEHEMOTH_TONGUE, itemName = 'Behemoth Tongue', reward = 1000, bonus = 500 },
    [141] = { mobId = zones[xi.zone.WESTERN_ALTEPA_DESERT].mob.KING_VINEGAROON, mobName = 'King Vinegaroon', item = xi.item.ACES_HELM, itemName = 'Ace\'s Helm', reward = 1000, bonus = 500 },
    [142] = { mobId = zones[xi.zone.BEAUCEDINE_GLACIER].mob.KIRATA, mobName = 'Kirata', item = xi.item.BOREAS_CESTI, itemName = 'Boreas Cesti', reward = 500, bonus = 100 },
    [143] = { mobId = zones[xi.zone.CAPE_TERIGGAN].mob.KREUTZET, mobName = 'Kreutzet', item = xi.item.SIROCCO_KUKRI, itemName = 'Sirocco Kukri', reward = 500, bonus = 100 },
    [144] = { mobId = zones[xi.zone.ROLANBERRY_FIELDS_S].mob.LAMINA, mobName = 'Lamina', item = xi.item.KUSHAS_RING, itemName = 'Kusha\'s Ring', reward = 150, bonus = 100 },
    [145] = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.LESHONKI, mobName = 'Leshonki', item = xi.item.LESHONKI_BULB, itemName = 'Leshonki Bulb', reward = 500, bonus = 100 },
    [146] = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.LINDWURM, mobName = 'Lindwurm', item = xi.item.VALIANT_KNIFE, itemName = 'Valiant Knife', reward = 500, bonus = 300 },
    [147] = { mobId = zones[xi.zone.BHAFLAU_THICKETS].mob.NIS_PUK, mobName = 'Nis Puk', item = xi.item.TEMPEST_BELT, itemName = 'Tempest Belt', reward = 500, bonus = 300 },
    [148] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.LORD_OF_ONZOZO, mobName = 'Lord of Onzozo', item = xi.item.OCTAVE_CLUB, itemName = 'Octave Club', reward = 500, bonus = 1000 },
    [149] = { mobId = zones[xi.zone.BATALLIA_DOWNS].mob.LUMBER_JACK, mobName = 'Lumber Jack', item = xi.item.BLOODSWORD, itemName = 'Bloodsword', reward = 500, bonus = 400 },
    [150] = { mobId = zones[xi.zone.INNER_HORUTOTO_RUINS].mob.MALTHA, mobName = 'Maltha', item = xi.item.TRAILERS_TUNICA, itemName = 'Trailer Tunica', reward = 150, bonus = 100 },
    [151] = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.MARQUIS_ALLOCEN, mobName = 'Marquis Allocen', item = xi.item.CORSAIRS_KNIFE, itemName = 'Corsair\'s Knife', reward = 300, bonus = 300 },
    [152] = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.MARQUIS_AMON, mobName = 'Marquis Amon', item = xi.item.LION_CROSSBOW, itemName = 'Lion Crossbow', reward = 300, bonus = 100 },
    [153] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.MASAN, mobName = 'Masan', item = xi.item.PIGEONS_BLOOD_RUBY, itemName = 'Pigeon\'s Blood Ruby', reward = 500, bonus = 100 },
    [154] = { mobId = zones[xi.zone.CASTLE_OZTROJA].mob.MEE_DEGGI_THE_PUNISHER, mobName = 'Mee Deggii the Punisher', item = xi.item.OCHIUDOS_KOTE, itemName = 'Ochiudo\'s Kote', reward = 500, bonus = 800 },
    [155] = { mobId = zones[xi.zone.JUGNER_FOREST].mob.METEORMAULER_ZHAGTEGG, mobName = 'Meteormauler Zhagtegg', item = xi.item.GARDE_PICK, itemName = 'Garde Pick', reward = 300, bonus = 100 },
    [156] = { mobId = zones[xi.zone.YUHTUNGA_JUNGLE].mob.TURTLERIDER, mobName = 'Meww the Turtlerider', item = xi.item.OLIPHANT, itemName = 'Oliphant', reward = 300, bonus = 100 },
    [157] = { mobId = zones[xi.zone.UPPER_DELKFUTTS_TOWER].mob.MIMAS, mobName = 'Mimas', item = xi.item.HUGE_MOTH_AXE, itemName = 'Huge Moth Axe', reward = 150, bonus = 100 },
    [158] = { mobId = zones[xi.zone.YUHTUNGA_JUNGLE].mob.MISCHIEVOUS_MICHOLAS, mobName = 'Mischievous Micholas', item = xi.item.KIDNEY_DAGGER, itemName = 'Kidney Dagger', reward = 500, bonus = 100 },
    [159] = { mobId = zones[xi.zone.CASTLE_OZTROJA].mob.MOO_OUZI_THE_SWIFTBLADE, mobName = 'Moo Ouzi the Swiftblade', item = xi.item.DEMONIC_SWORD, itemName = 'Demonic Sword', reward = 500, bonus = 100 },
    [160] = { mobId = zones[xi.zone.KORROLOKA_TUNNEL].mob.MORION_WORM, mobName = 'Morion Worm', item = xi.item.MORION_TATHLUM, itemName = 'Morion Tathlum', reward = 100, bonus = 200 },
    [161] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.MOUU_THE_WAVERIDER, mobName = 'Mouu the Waverider', item = xi.item.MONSOON_SPEAR, itemName = 'Monsoon Spear', reward = 500, bonus = 100 },
    [162] = { mobId = zones[xi.zone.CARPENTERS_LANDING].mob.MYCOPHILE, mobName = 'Mycophile', item = xi.item.MYCOPHILE_CUFFS, itemName = 'Mycophile Cuffs', reward = 100, bonus = 100 },
    [163] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.MYSTICMAKER_PROFBLIX, mobName = 'Mysticmaker Profblix', item = xi.item.MOLDAVITE_EARRING, itemName = 'Moldavite Earring', reward = 150, bonus = 900 },
    [164] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.NAMTAR, mobName = 'Namtar', item = xi.item.NAMTAR_BONE, itemName = 'Namtar Bone', reward = 500, bonus = 100 },
    [165] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.NARASIMHA, mobName = 'Narasimha', item = xi.item.NARASIMHA_HIDE, itemName = 'Narasimha Hide', reward = 500, bonus = 100 },
    [166] = { mobId = zones[xi.zone.DRAGONS_AERY].mob.NIDHOGG, mobName = 'Nidhogg', item = xi.item.WYRM_BEARD, itemName = 'Wyrm Beard', reward = 1000, bonus = 500 },
    [167] = { mobId = zones[xi.zone.THE_SANCTUARY_OF_ZITAH].mob.NOBLE_MOLD, mobName = 'Noble Mold', item = xi.item.RAIN_HAT, itemName = 'Rain Hat', reward = 500, bonus = 100 },
    [168] = { mobId = zones[xi.zone.INNER_HORUTOTO_RUINS].mob.NOCUOUS_WEAPON, mobName = 'Nocuous Weapon', item = xi.item.DISCIPLE_GRIP, itemName = 'Disciple Grip', reward = 500, bonus = 100 },
    [169] = { mobId = zones[xi.zone.FEIYIN].mob.NORTHERN_SHADOW, mobName = 'Northern Shadow', item = xi.item.EXECUTIONER, itemName = 'Executioner', reward = 500, bonus = 100 },
    [170] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.NOVV_THE_WHITEHEARTED, mobName = 'Novv the Whitehearted', item = xi.item.MINSTRELS_COAT, itemName = 'Minstrel\'s Coat', reward = 500, bonus = 100 },
    [171] = { mobId = zones[xi.zone.BEAUCEDINE_GLACIER].mob.NUE, mobName = 'Nue', item = xi.item.NUE_FANG, itemName = 'Nue Fang', reward = 500, bonus = 300 },
    [172] = { mobId = zones[xi.zone.WEST_SARUTABARUTA].mob.NUMBING_NORMAN, mobName = 'Numbing Norman', item = xi.item.PIKE, itemName = 'Pike', reward = 150, bonus = 100 },
    [173] = { mobId = zones[xi.zone.WEST_SARUTABARUTA].mob.NUNYENUNC, mobName = 'Nunyenunc', item = xi.item.PILGRIMS_WAND, itemName = 'Pilgrim\'s Wand', reward = 500, bonus = 100 },
    [174] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.NUSSKNACKER, mobName = 'Nussknacker', item = xi.item.SAND_GLOVES, itemName = 'Sand Gloves', reward = 500, bonus = 100 },
    [175] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].OCEAN_SAHAGIN, mobName = 'Ocean Sahagin', item = xi.item.COLOSSAL_LANCE, itemName = 'Colossal Lance', reward = 300, bonus = 100 },
    [176] = { mobId = zones[xi.zone.GARLAIGE_CITADEL].mob.OLD_TWO_WINGS, mobName = 'Old Two-Wings', item = xi.item.BAT_CAPE, itemName = 'Bat Cape', reward = 300, bonus = 300 },
    [178] = { mobId = zones[xi.zone.TORAIMARAI_CANAL].mob.ONI_CARCASS, mobName = 'Oni Carcass', item = xi.item.ONIKIRI, itemName = 'Onikiri', reward = 300, bonus = 100 },
    [179] = { mobId = zones[xi.zone.MONASTIC_CAVERN].mob.ORCISH_HEXSPINNER, mobName = 'Orcish Hexspinner', item = xi.item.BLACK_MAGES_TESTIMONY, itemName = 'Black Mage\'s Testimony', reward = 100, bonus = 200 },
    [180] = { mobId = zones[xi.zone.CARPENTERS_LANDING].mob.ORCTRAP, mobName = 'Orctrap', item = xi.item.HOJUTSU_BELT, itemName = 'Hojutsu Belt', reward = 500, bonus = 100 },
    [181] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.OSE, mobName = 'Ose', item = xi.item.ASSAULT_JERKIN, itemName = 'Assault Jerkin', reward = 500, bonus = 1000 },
    [182] = { mobId = zones[xi.zone.MONASTIC_CAVERN].mob.OVERLORD_BAKGODEK, mobName = 'Overlord Bakgodek', item = xi.item.JUGGERNAUT, itemName = 'Juggernaut', reward = 1000, bonus = 1000 },
    [183] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.PAHH_THE_GULLCALLER, mobName = 'Pahh the Gullcaller', item = xi.item.CALAMAR, itemName = 'Calamar', reward = 500, bonus = 100 },
    [184] = { mobId = zones[xi.zone.UPPER_DELKFUTTS_TOWER].mob.PALLAS, mobName = 'Pallas', item = xi.item.PALLASS_BRACELETS, itemName = 'Pallas\'s Bracelets', reward = 100, bonus = 300 },
    [185] = { mobId = zones[xi.zone.CAEDARVA_MIRE].mob.PEALLAIDH, mobName = 'Peallaidh', item = xi.item.NIGHTMARE_GLOVES, itemName = 'Nightmare Gloves', reward = 500, bonus = 300 },
    [186] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.PEG_POWLER, mobName = 'Peg Powler', item = xi.item.SCHWARZ_AXT, itemName = 'Schwarz Axt', reward = 500, bonus = 100 },
    [187] = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.PELICAN, mobName = 'Pelican', item = xi.item.ASTRAL_ASPIS, itemName = 'Astral Aspis', reward = 800, bonus = 100 },
    [188] = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.PHANDURON_THE_CONDEMNED, mobName = 'Phanduron the Condemned', item = xi.item.ASCALON, itemName = 'Ascalon', reward = 500, bonus = 100 },
    [189] = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.PHANTOM_WORM, mobName = 'Phantom Worm', item = xi.item.PHANTOM_TATHLUM, itemName = 'Phantom Tathlum', reward = 150, bonus = 100 },
    [190] = { mobId = zones[xi.zone.DAVOI].mob.POISONHAND_GNADGAD, mobName = 'Poisonhand Gnadgad', item = xi.item.JUJITSU_GI, itemName = 'Jujitsu Gi', reward = 500, bonus = 300 },
    [191] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.PROCONSUL_XII, mobName = 'Proconsul XII', item = xi.item.DAINSLAIF, itemName = 'Dainslaif', reward = 100, bonus = 100 },
    [192] = { mobId = zones[xi.zone.GUSGEN_MINES].mob.PULVERIZED_PFEFFER, mobName = 'Pulverized Pfeffer', item = xi.item.MALFROST_RING, itemName = 'Malfrost Ring', reward = 150, bonus = 100 },
    [193] = { mobId = zones[xi.zone.CASTLE_OZTROJA].mob.QUU_DOMI_THE_GALLANT, mobName = 'Quu Domi the Gallant', item = xi.item.SARUTOBI_KYAHAN, itemName = 'Sarutobi Kyahan', reward = 500, bonus = 100 },
    [194] = { mobId = zones[xi.zone.PALBOROUGH_MINES].mob.QU_VHO_DEATHHURLER, mobName = 'Qu\'Vho Deathhurler', item = xi.item.GUERILLA_GLOVES, itemName = 'Guerilla Gloves', reward = 150, bonus = 100 },
    [195] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.QULL_THE_SHELLBUSTER, mobName = 'Qull the Shellbuster', item = xi.item.EXOCETS, itemName = 'Exocets', reward = 500, bonus = 100 },
    [196] = { mobId = zones[xi.zone.GIDDEUS].mob.QUU_XIJO_THE_ILLUSORY, mobName = 'Quu Xijo the Illusory', item = xi.item.EPHEMERAL_CLOTH, itemName = 'Ephemeral Cloth', reward = 150, bonus = 100 },
    [197] = { mobId = zones[xi.zone.EAST_RONFAURE].mob.RAMBUKK, mobName = 'Rambukk', item = xi.item.BUKKTOOTH, itemName = 'Bukktooth', reward = 150, bonus = 100 },
    [198] = { mobId = zones[xi.zone.SAUROMUGUE_CHAMPAIGN].mob.ROC, mobName = 'Roc', item = xi.item.DRYAD_STAFF, itemName = 'Dryad Staff', reward = 500, bonus = 800 },
    [199] = { mobId = zones[xi.zone.YUHTUNGA_JUNGLE].mob.ROSE_GARDEN, mobName = 'Rose Garden', item = xi.item.VELMAS_RING, itemName = 'Velma\'s Ring', reward = 500, bonus = 500 },
    [200] = { mobId = zones[xi.zone.KUFTAL_TUNNEL].mob.SABOTENDER_MARIACHI, mobName = 'Sabotender Mariachi', item = xi.item.BANO_DEL_SOL, itemName = 'Bano del sol', reward = 500, bonus = 100 },
    [201] = { mobId = zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.SACRIFICIAL_GOBLET, mobName = 'Sacrificial Goblet', item = xi.item.CHARGING_SHIELD, itemName = 'Charging Shield', reward = 500, bonus = 100 },
    [202] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.SAGITTARIUS_X_XIII, mobName = 'Sagittarius X-XIII', item = xi.item.LOXLEY_BOW, itemName = 'Loxley Bow', reward = 500, bonus = 500 },
    [203] = { mobId = zones[xi.zone.GRAUBERG_S].mob.SCITALIS, mobName = 'Scitalis', item = xi.item.SAURIAN_HELM, itemName = 'Saurian Helm', reward = 800, bonus = 1000 },
    [204] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.SEA_HOG, mobName = 'Sea Hog', item = xi.item.SOUTHERN_PEARL, itemName = 'Southern Pearl', reward = 500, bonus = 100 },
    [205] = { mobId = zones[xi.zone.GARLAIGE_CITADEL].mob.SERKET, mobName = 'Serket', item = xi.item.SERKET_RING, itemName = 'Serket Ring', reward = 700, bonus = 1000 },
    [206] = { mobId = zones[xi.zone.BIBIKI_BAY].mob.SERRA, mobName = 'Serra', item = xi.item.VOLANS_GREAVES, itemName = 'Volans Greaves', reward = 500, bonus = 100 },
    [207] = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.SEWER_SYRUP, mobName = 'Sewer Syrup', item = xi.item.JELLY_RING, itemName = 'Jelly Ring', reward = 500, bonus = 900 },
    [208] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.SEWW_THE_SQUIDLIMBED, mobName = 'Seww the Squidlimbed', item = xi.item.MERMAID_TAIL, itemName = 'Mermaid Tail', reward = 500, bonus = 100 },
    [209] = { mobId = zones[xi.zone.XARCABARD].mob.SHADOW_EYE, mobName = 'Shadow Eye', item = xi.item.MOON_AMULET, itemName = 'Moon Amulet', reward = 500, bonus = 200 },
    [210] = { mobId = zones[xi.zone.BIBIKI_BAY].mob.SHEN, mobName = 'Shen', item = xi.item.REVEREND_MAIL, itemName = 'Reverend Mail', reward = 1000, bonus = 1000 },
    [211] = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.SHII, mobName = 'Shii', item = xi.item.SUKESADA, itemName = 'Sukesada', reward = 500, bonus = 100 },
    [212] = { mobId = zones[xi.zone.ROMAEVE].mob.SHIKIGAMI_WEAPON, mobName = 'Shikigami Weapon', item = xi.item.YINYANG_ROBE, itemName = 'Yingyang Robe', reward = 500, bonus = 1000 },
    [213] = { mobId = zones[xi.zone.ROLANBERRY_FIELDS].mob.SIMURGH, mobName = 'Simurgh', item = xi.item.TROTTER_BOOTS, itemName = 'Trotter Boots', reward = 500, bonus = 800 },
    [214] = { mobId = zones[xi.zone.GARLAIGE_CITADEL].mob.SKEWER_SAM, mobName = 'Skewer Sam', item = xi.item.WIND_SPEAR, itemName = 'Wind Spear', reward = 300, bonus = 100 },
    [215] = { mobId = zones[xi.zone.LA_THEINE_PLATEAU].mob.SLUMBERING_SAMWELL, mobName = 'Slumbering Samwell', item = xi.item.SAMWELLS_SHANK, itemName = 'Samwell\'s Shank', reward = 150, bonus = 100 },
    [216] = { mobId = zones[xi.zone.GUSGEN_MINES].mob.SMOTHERED_SCHMIDT, mobName = 'Smothered Schmidt', item = xi.item.MALFLOOD_RING, itemName = 'Malflood Ring', reward = 150, bonus = 100 },
    [217] = { mobId = zones[xi.zone.LABYRINTH_OF_ONZOZO].mob.SOULSTEALER_SKULLNIX, mobName = 'Soulstealer Skullnix', item = xi.item.KARD, itemName = 'Kard', reward = 500, bonus = 100 },
    [218] = { mobId = zones[xi.zone.FEIYIN].mob.SOUTHERN_SHADOW, mobName = 'Southern Shadow', item = xi.item.MASTER_SHIELD, itemName = 'Master Shield', reward = 500, bonus = 100 },
    [219] = { mobId = zones[xi.zone.EAST_SARUTABARUTA].mob.SPINY_SPIPI, mobName = 'Spiny Spipi', item = xi.item.MIST_SILK_CAPE, itemName = 'Mist Silk Cape', reward = 500, bonus = 100 },
    [220] = { mobId = zones[xi.zone.BIBIKI_BAY].mob.SPLACKNUCK, mobName = 'Splacknuck', item = xi.item.KNACK_PENDANT, itemName = 'Knack Pendant', reward = 500, bonus = 100 },
    [221] = { mobId = zones[xi.zone.DAVOI].mob.STEELBITER_GUDRUD, mobName = 'Steelbiter Gudrud', item = xi.item.LIZARD_PIERCER, itemName = 'Lizard Piercer', reward = 500, bonus = 100 },
    [222] = { mobId = zones[xi.zone.KONSCHTAT_HIGHLANDS].mob.STEELFLEECE, mobName = 'Steelfleece Baldarich', item = xi.item.VIKING_SHIELD, itemName = 'Viking Shield', reward = 500, bonus = 300 },
    [223] = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.TARASQUE, mobName = 'Tarasque', item = xi.item.ASCENTION, itemName = 'Ascention', reward = 300, bonus = 100 },
    [224] = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.TAWNY_FINGERED_MUGBERRY, mobName = 'Tawny Fingered Mugberry', item = xi.item.UGGALEPIH_NECKLACE, reward = 500, bonus = 1000 },
    [225] = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.TAXIM, mobName = 'Taxim', item = xi.item.COCYTUS_POLE, itemName = 'Cocytus Pole', reward = 500, bonus = 100 },
    [226] = { mobId = zones[xi.zone.DANGRUF_WADI].mob.TEPORINGO, mobName = 'Teporingo', item = xi.item.SUCCUBUS_GRIP, itemName = 'Succubus Grip', reward = 500, bonus = 200 },
    [227] = { mobId = zones[xi.zone.GHELSBA_OUTPOST].mob.THOUSANDARM_DESHGLESH, mobName = 'Thousandarm Deshglesh', item = xi.item.PLATE_BELT, itemName = 'Plate Belt', reward = 500, bonus = 100 },
    [228] = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.TIAMAT, mobName = 'Tiamat', item = xi.item.NORITSUNE_KOTE, itemName = 'Noritsune Kote', reward = 1000, bonus = 500 },
    [229] = { mobId = zones[xi.zone.DAVOI].mob.TIGERBANE_BAKDAK, mobName = 'Tigerbane Bakdak', item = xi.item.TIGERHUNTER, itemName = 'Tigerhunter', reward = 500, bonus = 100 },
    [230] = { mobId = zones[xi.zone.SOUTH_GUSTABERG].mob.TOCOCO, mobName = 'Tacoco', item = xi.item.ARMIGERS_LACE, itemName = 'Armiger\'s Lace', reward = 150, bonus = 100 },
    [231] = { mobId = zones[xi.zone.BATALLIA_DOWNS].mob.TOTTERING_TOBY, mobName = 'Tottering Toby', item = xi.item.STUMBLING_SANDALS, itemName = 'Stumbling Sandals', reward = 500, bonus = 100 },
    [232] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.TRIARIUS_X_XV, mobName = 'Triarius X-XV', item = xi.item.PENDRAGON_AXE, itemName = 'Pendragon Axe', reward = 500, bonus = 100 },
    [233] = { mobId = zones[xi.zone.QUICKSAND_CAVES].mob.TRIBUNUS_VII_I, mobName = 'Tribunus VII-I', item = xi.item.TUNGI, itemName = 'Tungi', reward = 100, bonus = 100 },
    [234] = { mobId = zones[xi.zone.QUFIM_ISLAND].mob.TRICKSTER_KINETIX, mobName = 'Trickster Kinetix', item = xi.item.TABAR, itemName = 'Tabar', reward = 500, bonus = 100 },
    [235] = { mobId = zones[xi.zone.LA_THEINE_PLATEAU].mob.TUMBLING_TRUFFLE, mobName = 'Tumbling Truffle', item = xi.item.FUNGUS_HAT, itemName = 'Fungus Hat', reward = 100, bonus = 100 },
    [236] = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.TYRANNIC_TUNNOK, mobName = 'Tyrannic Tunnok', item = xi.item.LOHAR, itemName = 'Lohar', reward = 500, bonus = 100 },
    [237] = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.UNGUR, mobName = 'Ungur', item = xi.item.UNGUR_BOOMERANG, itemName = 'Ungur Boomerand', reward = 1000, bonus = 1000 },
    [238] = { mobId = zones[xi.zone.RIVERNE_SITE_B01].mob.UNSTABLE_CLUSTER, mobName = 'Unstable Cluster', item = xi.item.SOBORO_SUKEHIRO, itemName = 'Soboro Sukehiro', reward = 1000, bonus = 1000 },
    [239] = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.UNUT, mobName = 'Unut', item = xi.item.LUNA_SUBLIGAR, itemName = 'Luna Subligar', reward = 500, bonus = 500 },
    [240] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.VOLL_THE_SHARKFINNED, mobName = 'Voll the Sharkfinned', item = xi.item.MONSOON_JINPACHI, itemName = 'Monsoon Jinpachi', reward = 500, bonus = 100 },
    [241] = { mobId = zones[xi.zone.THE_BOYAHDA_TREE].mob.VOLUPTUOUS_VIVIAN, mobName = 'Voluptuous Vivian', item = xi.item.BLACK_RIBBON, itemName = 'Black Ribbon', reward = 1000, bonus = 500 },
    [242] = { mobId = zones[xi.zone.IFRITS_CAULDRON].mob.VOUIVRE, mobName = 'Vouivre', item = xi.item.GAE_BOLG, itemName = 'Gae Bolg', reward = 500, bonus = 100 },
    [243] = { mobId = zones[xi.zone.KING_RANPERRES_TOMB].mob.VRTRA, mobName = 'Vrtra', item = xi.item.REVILERS_HELM, itemName = 'Reviler\'s Helm', reward = 1000, bonus = 1000 },
    [244] = { mobId = zones[xi.zone.GIDDEUS].mob.VUU_PUQU_THE_BEGUILER, mobName = 'Vuu Puqu the Beguiler', item = xi.item.BONZES_CIRCLET, itemName = 'Bonze\'s Circlet', reward = 500, bonus = 100 },
    [245] = { mobId = zones[xi.zone.BUBURIMU_PENINSULA].mob.WANDA, mobName = 'Wake Warder Wanda', item = xi.item.MELAMPUS_STAFF, itemName = 'Melampus Staff', reward = 150, bonus = 100 },
    [246] = { mobId = zones[xi.zone.MERIPHATAUD_MOUNTAINS].mob.WARAXE_BEAK, mobName = 'Waraxe Beak', item = xi.item.MONSOON_TEKKO, itemName = 'Monsoon Tekko', reward = 500, bonus = 100 },
    [247] = { mobId = zones[xi.zone.FEIYIN].mob.WESTERN_SHADOW, mobName = 'Western Shadow', item = xi.item.RETALIATORS, itemName = 'Retaliators', reward = 500, bonus = 500 },
    [248] = { mobId = zones[xi.zone.YHOATOR_JUNGLE].mob.WOODLAND_SAGE, mobName = 'Woodland Sage', item = xi.item.SUNLIGHT_POLE, itemName = 'Sunlight Pole', reward = 300, bonus = 100 },
    [249] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.WORR_THE_CLAWFISTED, mobName = 'Worr the Clawfisted', item = xi.item.PAGURES, itemName = 'Pagures', reward = 500, bonus = 100 },
    [250] = { mobId = zones[xi.zone.GUSGEN_MINES].mob.WOUNDED_WURFEL, mobName = 'Wounded Wurfel', item = xi.item.MALFLASH_RING, itemName = 'Malflash Ring', reward = 150, bonus = 100 },
    [251] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.WUUR_THE_SANDCOMBER, mobName = 'Wuur the Sandcomber', item = xi.item.HOLY_AMPULLA, itemName = 'Holy Ampulla', reward = 500, bonus = 100 },
    [252] = { mobId = zones[xi.zone.GUSTAV_TUNNEL].mob.WYVERNPOACHER_DRACHLOX, mobName = 'Wyvernpoacher Drachlox', item = xi.item.OTHINUS_BOW, itemName = 'Othinus\' Bow', reward = 500, bonus = 100 },
    [253] = { mobId = zones[xi.zone.ATTOHWA_CHASM].mob.XOLOTL, mobName = 'Xolotl', item = xi.item.BANDOMUSHA_KOTE, itemName = 'Bandomusha Kote', reward = 700, bonus = 500 },
    [254] = { mobId = zones[xi.zone.CASTLE_OZTROJA].mob.YAA_HAQA_THE_PROFANE, mobName = 'Yaa Haqa the Profane', item = xi.item.EARTH_DOUBLET, itemName = 'Earth Doublet', reward = 500, bonus = 100 },
    [255] = { mobId = zones[xi.zone.CASTLE_OZTROJA].mob.YAGUDO_AVATAR, mobName = 'Yagudo Avatar', item = xi.item.WALRUS_STAFF, itemName = 'Walrus Staff', reward = 300, bonus = 100 },
    [256] = { mobId = zones[xi.zone.TAHRONGI_CANYON].mob.YARA_MA_YHA_WHO, mobName = 'Yara Ma Yha Who', item = xi.item.FASTING_RING, itemName = 'Fasting Ring', reward = 100, bonus = 100 },
    [257] = { mobId = zones[xi.zone.GIDDEUS].mob.ZHUU_BUXU_THE_SILENT, mobName = 'Zhuu Buxu the Silent', item = xi.item.PARANA_SHIELD, itemName = 'Parana Shield', reward = 100, bonus = 100 },
    [258] = { mobId = zones[xi.zone.PALBOROUGH_MINES].mob.ZI_GHI_BONEEATER, mobName = 'Zi\'Ghi Boneeater', item = xi.item.Braveheart, itemName = 'Braveheart', reward = 500, bonus = 100 },
    [259] = { mobId = zones[xi.zone.CAEDARVA_MIRE].mob.ZIKKO, mobName = 'Zikko', item = xi.item.TEMPLAR_HAMMER, itemName = 'Templar Hammer', reward = 500, bonus = 500 },
    [260] = { mobId = zones[xi.zone.MISAREAUX_COAST].mob.ZIPHIUS, mobName = 'Ziphius', item = xi.item.HOSPITALER_EARRING, itemName = 'Hospitaler Earring', reward = 100, bonus = 600 },
    [261] = { mobId = zones[xi.zone.BEADEAUX].mob.ZO_KHU_BLACKCLOUD, mobName = 'Zo\'Khu Blackcloud', item = xi.item.FAERIE_SHIELD, itemName = 'Faerie Shield', reward = 500, bonus = 300 },
    [262] = { mobId = zones[xi.zone.WAJAOM_WOODLANDS].mob.ZORAAL_JAS_PKUUCHA, mobName = 'Zoraal Ja\'s Pkuucha', item = xi.item.ZORAAL_JAS_AXE, itemName = 'Zoraal Ja\'s Axe', reward = 500, bonus = 400 },
    [263] = { mobId = zones[xi.zone.SEA_SERPENT_GROTTO].mob.ZUUG_THE_SHORELEAPER, mobName = 'Zuug the Shoreleaper', item = xi.item.NARVAL, itemName = 'Narval', reward = 500, bonus = 100 },
    [264] = { mobId = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE].mob.MANES, mobName = 'Manes', item = xi.item.TAFFETA_CLOTH, itemName = 'Taffeta Cloth', reward = 500, bonus = 100 },
    [265] = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.MARQUIS_SABNOCK, mobName = 'Marquis Sabnock', item = xi.item.ASTROLABE, itemName = 'Astrolabe', reward = 500, bonus = 300 },
    [266] = { mobId = zones[xi.zone.CASTLE_ZVAHL_BAILEYS].mob.LIKHO, mobName = 'Likho', item = xi.item.LIKHO_TALON, itemName = 'Likho Talon', reward = 500, bonus = 300 },
    [267] = { mobId = zones[xi.zone.CASTLE_ZVAHL_KEEP].mob.BARON_VAPULA, mobName = 'Baron Vapula', item = xi.item.DEMON_SKULL, itemName = 'Demon Skull', reward = 300, bonus = 100 },
    [268] = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.OGAMA, mobName = 'Ogama', item = xi.item.AMANOJAKU, itemName = 'Amanojaku', reward = 1000, bonus = 500 },
    [269] = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.BISTRE_HEARTED_MALBERRY, mobName = 'Bistre Hearted Malberry', item = xi.item.SKIRNIRS_WAND, itemName = 'Skirnir\'s Wand', reward = 700, bonus = 300 },
    [270] = { mobId = zones[xi.zone.DEN_OF_RANCOR].mob.CARMINE_TAILED_JANBERRY, mobName = 'Carmine Tailed Janberry', item = xi.item.ASKLEPIOS, itemName = 'Asklepios', reward = 500, bonus = 300 },
    [271] = { mobId = zones[xi.zone.EAST_RONFAURE].mob.SWAMFISK, mobName = 'Swamfisk', item = xi.item.GELONG_STAFF, itemName = 'Gelong Staff', reward = 300, bonus = 100 },
    [272] = { mobId = zones[xi.zone.EAST_RONFAURE_S].mob.MYRADROSH, mobName = 'Myradrosh', item = xi.item.RESTORER_CLOAK, itemName = 'Restorer Cloak', reward = 150, bonus = 150 },
    [273] = { mobId = zones[xi.zone.EAST_RONFAURE_S].mob.GOBLINTRAP, mobName = 'Goblintrap', item = xi.item.WILHELMS_EARRING, itemName = 'Wilhelm\'s Earring', reward = 500, bonus = 500 },
    [274] = { mobId = zones[xi.zone.EAST_RONFAURE_S].mob.SKOGS_FRU, mobName = 'Skogs Fru', item = xi.item.ECPHORIA_RING, itemName = 'Ecphoria Ring', reward = 500, bonus = 100 },
    [275] = { mobId = zones[xi.zone.EAST_SARUTABARUTA].mob.SHARP_EARED_ROPIPI, mobName = 'Sharp Eared Ropipi', item = xi.item.ENTRANCING_RIBBON, itemName = 'Entrancing Ribbon', reward = 300, bonus = 100 },
    [276] = { mobId = zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.NANDI, mobName = 'Nandi', item = xi.item.RATHE_EARRING, itemName = 'Rathe Earring', reward = 100, bonus = 150 },
    [277] = { mobId = zones[xi.zone.EASTERN_ALTEPA_DESERT].mob.DONNERGUGI, mobName = 'Donnergugi', item = xi.item.THUNDER_CORAL, itemName = 'Thunder Coral', reward = 500, bonus = 300 },
    [278] = { mobId = zones[xi.zone.FEIYIN].mob.MIND_HOARDER, mobName = 'Mind Hoarder', item = xi.item.LLEUS_CHARM, itemName = 'Lleu\'s Charm', reward = 500, bonus = 1000 },
    [279] = { mobId = zones[xi.zone.GARLAIGE_CITADEL].mob.HAZMAT, mobName = 'Hazmat', item = xi.item.PROMPTITUDE_SOLEA, itemName = 'Promptitude Solea', reward = 500, bonus = 500 },
    [280] = { mobId = zones[xi.zone.GARLAIGE_CITADEL].mob.HOVERING_HOTPOT, mobName = 'Hovering Hotpot', item = xi.item.SLEIGHT_KUKRI, itemName = 'Sleight Kukri', reward = 500, bonus = 500 },
}

local function getPurchaseItemFunc(itemId, quantity, cost, name)
    return function(playerInner)
        playerInner:queue(0, function(playerQueued)
            local confirmationMenu =
            {
                title = 'Confirm Purchase (' .. cost .. ' Mafia)',
                options =
                {
                    { 'Purchase ' .. name .. '.', function(playerConfirm)
                        local legionPoint = playerConfirm:getCurrency('legion_point')

                        if legionPoint < cost then
                            playerConfirm:printToPlayer('You do not have enough Mafia Points to claim that item.')
                            return
                        end

                        if npcUtil.giveItem(playerConfirm, { { itemId, quantity } }) then
                            playerConfirm:delCurrency('legion_point', cost)
                        end
                    end },
                    { 'I changed my mind.', function()
                        return
                    end },
                }
            }
            playerQueued:customMenu(confirmationMenu)
        end)
    end
end

local function getPurchaseKeyItemFunc(keyItemId, cost, name)
    return function(playerInner)
        playerInner:queue(0, function(playerQueued)
            local confirmationMenu =
            {
                title = 'Confirm Purchase (' .. cost .. ' Mafia)',
                options =
                {
                    { 'Purchase ' .. name .. '.', function(playerConfirm)
                        local legionPoint = playerConfirm:getCurrency('legion_point')

                        if legionPoint < cost then
                            playerConfirm:printToPlayer('You do not have enough Mafia Points to claim that item.')
                            return
                        end

                        if playerConfirm:hasKeyItem(keyItemId) then
                            playerConfirm:printToPlayer('You already have that.')
                            return
                        end

                        npcUtil.giveKeyItem(playerConfirm, keyItemId)
                        playerConfirm:delCurrency('legion_point', cost)

                    end },
                    { 'I changed my mind.', function()
                        return
                    end },
                }
            }
            playerQueued:customMenu(confirmationMenu)
        end)
    end
end

local function getOpenMenuFunc(menuName)
    return function(playerInner)
        playerInner:queue(0, function(playerQueued)
            playerQueued:customMenu(xi.mafia.standardShop[menuName])
        end)
    end
end

local function getZoneSpecificMenuFunc()
    return function(playerInner)
        playerInner:queue(0, function(playerQueued)
            local zoneID = playerQueued:getZoneID()

            if not xi.mafia.SALES[zoneID] then
                return
            end

            local zoneOptions = { unpack(xi.mafia.SALES[zoneID]) }
            zoneOptions[#zoneOptions + 1] = { 'Back', getOpenMenuFunc('Main Menu') }
            local zoneMenu =
            {
                title = 'Special Sales!',
                options = zoneOptions,
            }
            print('sales[1] ' .. zoneMenu.options[1][1] .. ' ' .. type(zoneMenu.options[1][2]))
            print('sales[2] ' .. zoneMenu.options[2][1] .. ' ' .. type(zoneMenu.options[2][2]))
            playerQueued:customMenu(zoneMenu)
        end)
    end
end

local function getRelicResetFunc()
    local cost = 3000

    return function(playerInner)
        local remaining = playerInner:getVar('RELIC_DUE_AT') - GetSystemTime()

        if remaining <= 0 then
            playerInner:printToPlayer('You have no relic in progress.')
            return
        end

        local days    = math.floor(remaining / 86400)
        local hours   = math.floor((remaining / 3600) - (days * 24))
        local minutes = math.floor((remaining / 60) - (hours * 60) - (days * 1440))

        local remainingString = string.format('%sd %sh %sm', days, hours, minutes)

        playerInner:queue(0, function(playerQueued)
            local confirmMenu =
            {
                title = string.format('Clear wait for current stage (%s mafia points)', cost),
                options =
                {
                    { string.format('Clear %s', remainingString), function(playerConfirm)
                        if playerConfirm:getCurrency('legion_point') < cost then
                            playerConfirm:printToPlayer('Not enough mafia points.')
                            return
                        end

                        playerConfirm:setVar('RELIC_DUE_AT', GetSystemTime())
                        playerConfirm:delCurrency('legion_point', cost)
                        playerConfirm:printToPlayer('Your relic timer has been reset.')
                    end },
                    { 'I changed my mind', function()
                        return
                    end },
                }
            }

            playerQueued:customMenu(confirmMenu)
        end)
    end
end

xi.mafia.standardShop =
{
    ['Main Menu'] =
    {
        title = 'Choose an Item or Category.',
        options =
        {
            { 'Instant Reraise', getPurchaseItemFunc(GetItemIDByName('Instant_reraise'), 1, 50, 'Instant Reraise') },
            { 'Instant Warp', getPurchaseItemFunc(GetItemIDByName('Instant_warp'), 1, 50, 'Instant Warp') },
            { 'Instant Retrace', getPurchaseItemFunc(GetItemIDByName('Instant_retrace'), 1, 50, 'Instant Retrace') },
            { 'Zone Specific Items', getZoneSpecificMenuFunc() },
            { 'Exit', function(player)
                return
            end },
        }
    },

    ['peak 2'] =
    {
        title = 'peak 2',
        options =
        {
            { 'Atropos Orb KSNM 30', getPurchaseItemFunc(GetItemIDByName('Atropos_orb'), 1, 5000, 'Atropos Orb') },
            { 'Clotho Orb KSNM 30', getPurchaseItemFunc(GetItemIDByName('Clotho_orb'), 1, 5000, 'Clotho Orb') },
            { 'Lachesis Orb KSNM 30', getPurchaseItemFunc(GetItemIDByName('Lachesis_orb'), 1, 5000, 'Lachesis Orb') },
            { 'Themis Orb KSNM 99', getPurchaseItemFunc(GetItemIDByName('Themis_orb'), 1, 7000, 'Themis Orb') },
            { 'Back', getZoneSpecificMenuFunc() },
        }
    },
}

xi.mafia.SALES =
{
    [xi.zone.AHT_URHGAN_WHITEGATE] =
    {
        { 'Imperial Army I.D. Tag', getPurchaseKeyItemFunc(xi.ki.IMPERIAL_ARMY_ID_TAG, 1000, 'Imperial Army I.D. Tag') },
        { 'Remnants Permit', getPurchaseKeyItemFunc(xi.ki.REMNANTS_PERMIT , 1500, 'Remnants Permit') },
    },
    [xi.zone.CLOISTER_OF_FROST] =
    {
        { '12 Glacier Crystals', getPurchaseItemFunc(GetItemIDByName('Glacier_crystal'), 12, 500, '12 Glacier Crystals') },
    },
    [xi.zone.CLOISTER_OF_TREMORS] =
    {
        { '12 Terra Crystals', getPurchaseItemFunc(GetItemIDByName('Terra_crystal'), 12, 500, '12 Terra Crystals') },
    },
    [xi.zone.CLOISTER_OF_TIDES] =
    {
        { '12 Torrent Crystals', getPurchaseItemFunc(GetItemIDByName('Torrent_crystal'), 12, 500, '12 Torrent Crystals') },
    },
    [xi.zone.CLOISTER_OF_GALES] =
    {
        { '12 Cyclone Crystals', getPurchaseItemFunc(GetItemIDByName('Cyclone_crystal'), 12, 500, '12 Cyclone Crystals') },
    },
    [xi.zone.CLOISTER_OF_FLAMES] =
    {
        { '12 Inferno Crystals' ,getPurchaseItemFunc(GetItemIDByName('Inferno_crystal'), 12, 500, '12 Inferno Crystals') },
    },
    [xi.zone.CLOISTER_OF_STORMS] =
    {
        { '12 Plasma Crystals', getPurchaseItemFunc(GetItemIDByName('Plasma_crystals'), 12, 500, '12 Inferno Crystals') },
    },
    [xi.zone.DRAGONS_AERY] =
    {
        { 'Dragon Meat' , getPurchaseItemFunc(GetItemIDByName('Dragon_meat'), 1, 500, 'Dragon Meat') },
        { '12 Dragon Meat', getPurchaseItemFunc(GetItemIDByName('Dragon_meat'), 12, 6000, '12 Dragon Meat') },
    },
    [xi.zone.HALL_OF_THE_GODS] =
    {
        { '12 Aurora Crystals', getPurchaseItemFunc(GetItemIDByName('Aurora_crystal'), 12, 500, '12 Aurora Crystals') },
    },
    [xi.zone.THE_SHROUDED_MAW] =
    {
        { '12 Twilight Crystals', getPurchaseItemFunc(GetItemIDByName('Twilight_crystals'), 12, 500, '12 Twilight Crystals') },
    },
    [xi.zone.ULEGUERAND_RANGE] =
    {
        { 'Molybdenum Ore', getPurchaseItemFunc(GetItemIDByName('Molybdenum_Ore'), 12, 300, 'Molybdenum Ore') },
        { '12 Molybdenum Ore', getPurchaseItemFunc(GetItemIDByName('Molybdenum_Ore'), 12, 3000, '12 Molybdenum Ore') },
    },
    [xi.zone.UPPER_JEUNO] =
    {
        { 'Goblin Mask' , getPurchaseItemFunc(GetItemIDByName('Goblin_mask') , 1, 1500, 'Goblin Mask') },
        { 'Goblin Suit' , getPurchaseItemFunc(GetItemIDByName('Goblin_suit') , 1, 1500, 'Goblin Suit') },
        { 'Goblin Drink', getPurchaseItemFunc(GetItemIDByName('Goblin_drink'), 1, 200, 'Goblin Drink') },
    },
    [xi.zone.MAZE_OF_SHAKHRAMI] =
    {
        { 'Peacock Amulet', getPurchaseItemFunc(GetItemIDByName('Peacock_amulet'), 1, 25000, 'Peacock Amulet') },
    },
    [xi.zone.JUGNER_FOREST] =
    {
      { 'Velocious Belt', getPurchaseItemFunc(GetItemIDByName('Velocious_Belt'), 1, 30000, 'Velocious Belt') },
    },
    [xi.zone.SOUTH_GUSTABERG] =
    {
      { 'Bounding Boots', getPurchaseItemFunc(GetItemIDByName('Bounding_Boots'), 1, 10000, 'Bounding Boots') },
    },
    [xi.zone.ROMAEVE] =
    {
        { 'YinYang Robe', getPurchaseItemFunc(GetItemIDByName('YinYang_robe'), 1, 25000, 'YinYang Robe') },
    },

    [xi.zone.HORLAIS_PEAK] =
    {

        { 'Cloudy Orb', getPurchaseItemFunc(GetItemIDByName('Cloudy_orb'), 1, 1500, 'Cloudy Orb') },
        { 'Sky Orb', getPurchaseItemFunc(GetItemIDByName('sky_orb'), 1, 2000, 'Sky Orb') },
        { 'Star Orb', getPurchaseItemFunc(GetItemIDByName('star_orb'), 1, 2500, 'Star Orb') },
        { 'Comet Orb', getPurchaseItemFunc(GetItemIDByName('Comet_orb'), 1, 3000, 'Comet Orb') },
        { 'Moon Orb', getPurchaseItemFunc(GetItemIDByName('Moon_orb'), 1, 4000, 'Moon Orb') },
        { 'Page 2 of Orbs', getOpenMenuFunc('peak 2') },
    },

    [xi.zone.CASTLE_ZVAHL_BAILEYS] =
    {
        { 'Relic Timer', getRelicResetFunc() },
    }
}

xi.mafia.grumItems =
{
    -- [1] = { itemid = 1236, amount = 40000, min = 30000, divisor = 2000, qnt = 5, itemname = 'Cactus Stems' },
    -- [2] = { itemid = 1237, amount = 40000, min = 30000, divisor = 2000, qnt = 5, itemname = 'Tree Cuttings' },
    -- [3] = { itemid = 2014, amount = 25000, min = 18000, divisor = 1000, qnt = 5, itemname = 'Bird Blood' },
    -- [4] = { itemid = 656, amount = 10000, min = 5000, divisor = 1000, qnt = 5, itemname = 'Beastcoin' },
    -- [5] = { itemid = 575, amount = 10000, min = 5000, divisor = 750, qnt = 5, itemname = 'Grain Seeds' },
    -- [6] = { itemid = 574, amount = 10000, min = 5000, divisor = 750, qnt = 5, itemname = 'Fruit Seeds' },
    -- [7] = { itemid = 573, amount = 10000, min = 5000, divisor = 750, qnt = 5, itemname = 'Vegetable Seeds' },
    -- [8] = { itemid = 1664, amount = 30000, min = 5000, divisor = 5000, qnt = 5, itemname = 'Eastern Gem' },
    -- [23] = { itemid = , amount = , min = , divisor = , qnt = , itemname = '' },
    -- [24] = { itemid = , amount = , min = , divisor = , qnt = , itemname = '' },
}

xi.mafia.grumEndItem =
{
    [1]  = { item = xi.item.RAINBOW_CAPE, points = 100, qnt = 1, itemname = 'Rainbow Cape' },
    [2]  = { item = xi.item.WIVRE_MASK, points = 100, qnt = 1, itemname = 'Wivre Mask' },
    [3]  = { item = xi.item.BEAK_NECKLACE, points = 100, qnt = 1, itemname = 'Beak Necklace' },
    [4]  = { item = xi.item.SNIPERS_RING, points = 100, qnt = 2, itemname = 'Sniper\'s Ring' },
    [5]  = { item = xi.item.CURSED_MITTS, points = 200, qnt = 1, itemname = 'Cursed Mitts' },
    [6]  = { item = xi.item.CURSED_CUIRASS, points = 300, qnt = 1, itemname = 'Cursed Cuirass' },
    [7]  = { item = xi.item.CURSED_MAIL, points = 300, qnt = 1, itemname = 'Cursed Mail' },
    [8]  = { item = xi.item.CURSED_HAIDATE, points = 300, qnt = 1, itemname = 'Cursed Haidate' },
    [9]  = { item = xi.item.DUSK_GLOVES, points = 350, qnt = 1, itemname = 'Dusk Gloves' },
    [10] = { item = xi.item.CORAL_RING, points = 100, qnt = 1, itemname = 'Coral Ring' },
    [11] = { item = xi.item.CURSED_HANDSCHUHS, points = 300, qnt = 1, itemname = 'Cursed Handschuhs' },
    [12] = { item = xi.item.CURSED_MASK, points = 300, qnt = 1, itemname = 'Cursed Mask' },
    [13] = { item = xi.item.CURSED_FINGER_GAUNTLETS, points = 300, qnt = 1, itemname = 'Cursed Fng. Gnt.' },
    [14] = { item = xi.item.CURSED_CUISSES, points = 300, qnt = 1, itemname = 'Cursed Cuisses' },
    [15] = { item = xi.item.CURSED_GREAVES, points = 300, qnt = 1, itemname = 'Cursed Greaves' },
    [16] = { item = xi.item.CURSED_CAP, points = 300, qnt = 1, itemname = 'Cursed Cap' },
    [17] = { item = xi.item.CURSED_HARNESS, points = 300, qnt = 1, itemname = 'Cursed Harness' },
    [18] = { item = xi.item.CURSED_GLOVES, points = 300, qnt = 1, itemname = 'Cursed Gloves' },
    [19] = { item = xi.item.CURSED_SUBLIGAR, points = 300, qnt = 1, itemname = 'Cursed Subligar' },
    [20] = { item = xi.item.CURSED_LEGGINGS, points = 300, qnt = 1, itemname = 'Cursed Leggings' },
    [21] = { item = xi.item.SCORPION_HARNESS, points = 100, qnt = 1, itemname = 'Scorpion Harness' },
    [22] = { item = xi.item.DRAGON_HARNESS, points = 200, qnt = 1, itemname = 'Dragon Harness' },
    [23] = { item = xi.item.IGQIRA_TIARA, points = 200, qnt = 1, itemname = 'Igqira Tiara' },
    [24] = { item = xi.item.ERRANT_CUFFS, points = 200, qnt = 1, itemname = 'Errant Cuffs' },
    [25] = { item = xi.item.DUSK_TROUSERS, points = 200, qnt = 1, itemname = 'Dusk Trousers' },
    [26] = { item = xi.item.DRAGON_LEGGINGS, points = 200, qnt = 1, itemname = 'Dragon Leggings' },
    [27] = { item = xi.item.DUSK_LEDELSENS, points = 200, qnt = 1, itemname = 'Dusk Ledelsens' },
    [28] = { item = xi.item.CERBERUS_MANTLE, points = 100, qnt = 1, itemname = 'Cerberus Mantle' },
}

function xi.mafia.gobhook(player, npc)
    local gobid = npc:getID() - 1
    local zoneid = player:getZoneID()
    local plevel = player:getMainLvl()

    if zoneid == xi.zone.PROVENANCE then
        -- gobid = 17686623 what the hell is this id? it just links to blank lol
    end

    local gob = GetNPCByID(gobid)
    gob:setPos(npc:getXPos(), npc:getYPos(), npc:getZPos(), npc:getRotPos(), player:getZoneID())
    gob:setStatus(xi.status.NORMAL)

    if plevel >= 5 then
        if player:getVar('ghook' .. zoneid) == 0 then
            local count = player:getVar('ghooked') + 1
            player:setVar('ghooked', count)
            player:printToPlayer('New footprint discovered. Your total is ' .. count .. '.')
            player:addGil(xi.mafia.GIL_REWARD)
            player:messageSpecial(zones[zoneid].text.GIL_OBTAINED, xi.mafia.GIL_REWARD)
            player:setVar('ghook'.. zoneid, 1)
            SetServerVariable('ghookOutput', GetServerVariable('ghookOutput') + xi.mafia.GIL_REWARD)
            if player:getVar('ghookHintZone') == zoneid then
                player:setVar('ghookHintZone', 0)
                player:setVar('ghookHintTime', 0)
            end
        else
            local count = player:getVar('ghooked')
            player:printToPlayer('Already found this one. Your total is ' .. count .. '.')
            player:printToPlayer(string.format('Your balance with the Goblin Mafia is: %s Mafia points.', player:getCurrency('legion_point')), xi.msg.channel.SAY, 'Ramblix')
            player:customMenu(xi.mafia.standardShop['Main Menu'])
        end
    else
        player:printToPlayer(string.format('Come back when you have more experience...'), xi.msg.channel.SAY, 'Ramblix')
    end
end

function xi.mafia.gobhook2(player, npc)
    player:printToPlayer(string.format('Your balance with the Goblin Mafia is: %s Mafia points.', player:getCurrency('legion_point')), xi.msg.channel.SAY, 'Coffer')
    player:customMenu(xi.mafia.standardShop['Main Menu'])
end

return xi.mafia
