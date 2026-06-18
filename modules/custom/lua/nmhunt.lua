-----------------------------------
-- NM Hunt System Configuration
-----------------------------------

xi = xi or {}
xi.nmHunt = xi.nmHunt or {}

xi.nmHunt.config = {
    huntDuration = 1209600, -- 14 days
    cooldownTime = 259200,  -- 3 days

    -- Reward chances
    itemRewardChance = 25,
    gilMin = 25000,
    gilMax = 100000,
}

xi.nmHunt.milestoneRewards = {
    [5]   = xi.item.LOTUS_KATANA,
    [10]  = xi.item.ANNIVERSARY_RING,
    [15]  = xi.item.NOMAD_MOOGLE_ROD,
    [20]  = xi.item.TIDAL_TALISMAN,
    [25]  = xi.item.CHOCOBO_SHIRT,
    [30]  = xi.item.NOVENNNIAL_RING,
    [35]  = xi.item.GLINTING_SHIELD,
    [40]  = xi.item.SHADOW_LORD_SHIRT,
    [45]  = xi.item.BOMB_MASQUE_P1,
    [50]  = xi.item.EXCALIPOOR_II,
    [55]  = xi.item.WORM_FEELERS_P1,
    [60]  = xi.item.ARK_SCYTHE,
    [65]  = xi.item.SOL_CAP,
    [70]  = xi.item.ARK_TABAR,
    [75]  = xi.item.FORTUNE_EGG,
    [80]  = xi.item.ARK_TACHI,
    [85]  = xi.item.HAPPY_EGG,
    [90]  = xi.item.ARK_SABER,
    [95]  = xi.item.REDEYES,
    [100] = xi.item.TRACK_PANTS_P1,
    [105] = xi.item.JANUS_GUARD,
    [110] = xi.item.ARK_SWORD,
    [115] = xi.item.FERMION_SWORD,
    [120] = xi.item.CHOCOBO_PULLUS_TORQUE,
    [125] = xi.item.IRRADIANCE_BLADE,
    [130] = xi.item.APHELION_KNUCKLES,
}

xi.nmHunt.standardRewards = {
    xi.item.COTTON_COIN_PURSE,
    xi.item.LINEN_COIN_PURSE,
}

xi.nmHunt.targets = {
    [1] = { zone = xi.zone.JUGNER_FOREST, mob = 'METEORMAULER_ZHAGTEGG', clue = 'I am the sentinel to the ruins of their sanctuary. My allies and I defend our stronghold.' },
    [2] = { zone = xi.zone.ATTOHWA_CHASM, mob = 'CITIPATI', clue = 'Come join our dance in the graveyard.' },
    [3] = { zone = xi.zone.CASTLE_OZTROJA, mob = 'MOO_OUZI_THE_SWIFTBLADE', clue = 'I\'m certainly not the king of this old castle.' },
    [4] = { zone = xi.zone.EAST_RONFAURE, mob = 'SWAMFISK', clue = 'I wouldn\'t go wading in the woods with me around.' },
    [5] = { zone = xi.zone.EAST_RONFAURE, mob = 'BIGMOUTH_BILLY', clue = 'I have so many fillings in my mouth. copper, zinc, silver and gold.' },
    [6] = { zone = xi.zone.KONSCHTAT_HIGHLANDS, mob = 'RAMPAGING_RAM', clue = 'I destroy everything that gets in my way.' },
    [7] = { zone = xi.zone.KONSCHTAT_HIGHLANDS, mob = 'STEELFLEECE_BALDARICH', clue = 'Water is my enemy and causes oxidation on me.' },
    [8] = { zone = xi.zone.TEMPLE_OF_UGGALEPIH, mob = 'TONBERRY_KINQ', clue = 'Swear I\'m the king! I even have the crown to prove it!' },
    [9] = { zone = xi.zone.VALKURM_DUNES, mob = 'GOLDEN_BAT', clue = 'Shikaka, Shikakaaa, Shikasche, Shish kabob, Shawshank Redemption, Chicago!' },
    [10] = { zone = xi.zone.BATALLIA_DOWNS, mob = 'AHTU', clue = 'My spirit is adrift at sea on a lonely island.' },
    [11] = { zone = xi.zone.SOUTH_GUSTABERG, mob = 'BUBBLY_BERNIE', clue = 'Champagne by the lighthouse.' },
    [12] = { zone = xi.zone.DAVOI, mob = 'BLUBBERY_BULGE', clue = 'Is that muffin-top in your pocket or are you just happy to see me?' },
    [13] = { zone = xi.zone.BIBIKI_BAY, mob = 'SHANKHA', clue = 'All my people retreat into their homes when scared, I do not!' },
    [14] = { zone = xi.zone.KORROLOKA_TUNNEL, mob = 'DAME_BLANCHE', clue = 'I would have gotten away with it too if it weren\'t for those meddling kids!' },
    [15] = { zone = xi.zone.LOWER_DELKFUTTS_TOWER, mob = 'EPIALTES', clue = 'I am a nightmarish giant.' },
    [16] = { zone = xi.zone.BOSTAUNIEUX_OUBLIETTE, mob = 'BLOODSUCKER', clue = 'Just saying my name gets the blood flowing through my veins!' },
    [17] = { zone = xi.zone.PALBOROUGH_MINES, mob = 'ZI_GHI_BONEEATER', clue = 'Some people gnaw on \'em, I eat \'em outright.' },
    [18] = { zone = xi.zone.BEADEAUX, mob = 'GE_DHA_EVILEYE', clue = 'I shall curse you with a malevolent glare!' },
    [19] = { zone = xi.zone.PALBOROUGH_MINES, mob = 'NO_MHO_CRIMSONARMOR', clue = 'The blood of many young adventurers may stain my pauldrons but I wish to wear them no more.' },
    [20] = { zone = xi.zone.RANGUEMONT_PASS, mob = 'TAISAIJIN', clue = 'I am the deity of my kind - I find it quite refreshing!' },
    [21] = { zone = xi.zone.BIBIKI_BAY, mob = 'INTULO', clue = 'I am but a simple messenger - the harbinger of doom!' },
    [22] = { zone = xi.zone.FEIYIN, mob = 'NORTHERN_SHADOW', clue = 'Beware the Executioner in the shadows...' },
    [23] = { zone = xi.zone.EAST_SARUTABARUTA, mob = 'SPINY_SPIPI', clue = 'I\'m spiffy, thanks for asking.' },
    [24] = { zone = xi.zone.BATALLIA_DOWNS, mob = 'PRANKSTER_MAVERIX', clue = 'Energy manipulated it into a tool of death. What it takes as playful, others take as pain.' },
    [25] = { zone = xi.zone.THE_BOYAHDA_TREE, mob = 'AQUARIUS', clue = 'I carry the water through the tree.' },
    [26] = { zone = xi.zone.YHOATOR_JUNGLE, mob = 'BISQUE_HEELED_SUNBERRY', clue = 'I can handle the hate, Barry.' },
    [27] = { zone = xi.zone.KORROLOKA_TUNNEL, mob = 'CARGO_CRAB_COLIN', clue = '5 points for your delivery, Mochrie.' },
    [28] = { zone = xi.zone.CASTLE_ZVAHL_KEEP, mob = 'COUNT_BIFRONS', clue = 'My 66 Legions and I will mark the graves of our enemies.' },
    [29] = { zone = xi.zone.CARPENTERS_LANDING, mob = 'ORCTRAP', clue = 'This plant\'s strong enough to catch beastmen in its jaws.' },
    [30] = { zone = xi.zone.BIBIKI_BAY, mob = 'SERRA', clue = 'I strike fear into dragons. I destroy seafaring ships. Look to the southern sky to see me.' },
    [31] = { zone = xi.zone.BUBURIMU_PENINSULA, mob = 'WAKE_WARDER_WANDA', clue = 'I wade in the water while wondering when the water will wash me away.' },
    [32] = { zone = xi.zone.GARLAIGE_CITADEL, mob = 'HAZMAT', clue = 'A roaming disaster. It will be prompt to end you, quickly.' },
    [33] = { zone = xi.zone.UPPER_DELKFUTTS_TOWER, mob = 'PORPHYRION', clue = 'I\'m not going to brag about coming in second.' },
    [34] = { zone = xi.zone.VALKURM_DUNES, mob = 'METAL_SHEARS', clue = 'Just a few quick snips and I\'ll be done.' },
    [35] = { zone = xi.zone.LA_THEINE_PLATEAU, mob = 'SLUMBERING_SAMWELL', clue = 'Just five more minutes...' },
    [36] = { zone = xi.zone.CARPENTERS_LANDING, mob = 'TEMPEST_TIGON', clue = 'Whirlwind romance of tiger and lion.' },
    [37] = { zone = xi.zone.KORROLOKA_TUNNEL, mob = 'MORION_WORM', clue = 'My five brothers and I love when adventurers bring us ferrous material.' },
    [38] = { zone = xi.zone.WEST_SARUTABARUTA, mob = 'NUMBING_NORMAN', clue = 'I\'ll take away the pain but leave you paralyzed.' },
    [39] = { zone = xi.zone.MERIPHATAUD_MOUNTAINS, mob = 'CHONCHON', clue = 'Chacha, chichi, cheche, chuchu...' },
    [40] = { zone = xi.zone.BEAUCEDINE_GLACIER, mob = 'KIRATA', clue = 'I\'m not new here, I\'m just usually hunting.' },
    [41] = { zone = xi.zone.EAST_SARUTABARUTA, mob = 'DUKE_DECAPOD', clue = 'Duke, duke, duke, duke of East...' },
    [42] = { zone = xi.zone.JUGNER_FOREST, mob = 'FRAELISSA', clue = 'Make like a tree and leaf, weakling.' },
    [43] = { zone = xi.zone.VALKURM_DUNES, mob = 'HIPPOMARITIMUS', clue = 'Only one thing for Christmas will do.' },
    [44] = { zone = xi.zone.YUHTUNGA_JUNGLE, mob = 'KOROPOKKUR', clue = 'You can\'t find me hiding under some leaves.' },
    [45] = { zone = xi.zone.PALBOROUGH_MINES, mob = 'QU_VHO_DEATHHURLER', clue = 'Have you seen my good throwing gloves?' },
    [46] = { zone = xi.zone.EAST_RONFAURE, mob = 'RAMBUKK', clue = 'Will the dentist knockk my tooth out?' },
    [47] = { zone = xi.zone.JUGNER_FOREST, mob = 'SAPPY_SYCAMORE', clue = 'I\'m the schmaltziest sappling in the forest.' },
    [48] = { zone = xi.zone.ROLANBERRY_FIELDS, mob = 'SILK_CATERPILLAR', clue = 'I\'m the aviophobes\'s missing link.' },
    [49] = { zone = xi.zone.BATALLIA_DOWNS, mob = 'SKIRLING_LIGER', clue = 'Gosh, that noise is worse than San d\'Orian bagpipes.' },
    [50] = { zone = xi.zone.SOUTH_GUSTABERG, mob = 'TOCOCO', clue = 'Protect your neck around this Spanish bird.' },
    [51] = { zone = xi.zone.BEADEAUX, mob = 'GE_DHA_EVILEYE', clue = 'Gaze into my evil eye.' },
    [52] = { zone = xi.zone.SEA_SERPENT_GROTTO, mob = 'MASAN', clue = 'A vampire that feeds primarily on children.' },
    [53] = { zone = xi.zone.BEADEAUX, mob = 'GA_BHU_UNVANQUISHED', clue = 'I\'m the undefeated duelist of my race.' },
    [54] = { zone = xi.zone.BEADEAUX, mob = 'ZO_KHU_BLACKCLOUD', clue = 'Fear me, I\'m a dark cloud of imposing magic.' },
    [55] = { zone = xi.zone.BEADEAUX, mob = 'BI_GHO_HEADTAKER', clue = 'Don\'t lose your head.' },
    [56] = { zone = xi.zone.SEA_SERPENT_GROTTO, mob = 'WUUR_THE_SANDCOMBER', clue = 'My metal detector doesn\'t go brrrt but it sounds similar.' },
    [57] = { zone = xi.zone.YUHTUNGA_JUNGLE, mob = 'MISCHIEVOUS_MICHOLAS', clue = 'You might lose something around this prankster that doesn\'t know when to quit.' },
    [58] = { zone = xi.zone.SEA_SERPENT_GROTTO, mob = 'SEA_HOG', clue = 'I don\'t look like a pig and I smell funny.' },
    [59] = { zone = xi.zone.ROLANBERRY_FIELDS, mob = 'DROOLING_DAISY', clue = 'A princess shouldn\'t be caught doing that in public, Sarasaland or elsewhere.' },
    [60] = { zone = xi.zone.YHOATOR_JUNGLE, mob = 'EDACIOUS_OPO_OPO', clue = 'What a bodaciously hungry monkey!' },
    [61] = { zone = xi.zone.TEMPLE_OF_UGGALEPIH, mob = 'HABETROT', clue = 'This spinner\'s thread is very desired.' },
    [62] = { zone = xi.zone.CARPENTERS_LANDING, mob = 'HERCULES_BEETLE', clue = 'Give me something sweet at night time and I might drop my pants.' },
    [63] = { zone = xi.zone.PASHHOW_MARSHLANDS, mob = 'JOLLY_GREEN', clue = 'Ho ho ho, green peaness.' },
    [64] = { zone = xi.zone.BUBURIMU_PENINSULA, mob = 'HELLDIVER', clue = 'Bu-bu-bu-bu-bombs away!' },
    [65] = { zone = xi.zone.TAHRONGI_CANYON, mob = 'HERBAGE_HUNTER', clue = 'DID I TELL YOU I\'M VEGAN YET?!?' },
    [66] = { zone = xi.zone.MERIPHATAUD_MOUNTAINS, mob = 'DAGGERCLAW_DRACOS', clue = 'Malfoy & Knuckles' },
    [67] = { zone = xi.zone.MERIPHATAUD_MOUNTAINS, mob = 'PATRIPATAN', clue = 'We found this monk\'s cat carrying a bow made of sacred wood.' },
    [68] = { zone = xi.zone.NORTH_GUSTABERG, mob = 'BEDROCK_BARRY', clue = 'He\'s from their town, but doesn\'t know Fred or Barney.' },
    [69] = { zone = xi.zone.PASHHOW_MARSHLANDS, mob = 'BLOODPOOL_VORAX', clue = 'I love my pool. I can swim in it and drink from it, too.' },
    [70] = { zone = xi.zone.WEST_RONFAURE, mob = 'JAGGEDY_EARED_JACK', clue = 'This guy\'s necklace is a steal.' },
    [71] = { zone = xi.zone.DANGRUF_WADI, mob = 'GEYSER_LIZARD', clue = 'This lizard really blows.' },
    [72] = { zone = xi.zone.JUGNER_FOREST, mob = 'SUPPLESPINE_MUJWUJ', clue = 'This guy never needs to visit the chiropractor.' },
    [73] = { zone = xi.zone.KING_RANPERRES_TOMB, mob = 'ANKOU', clue = 'I am death personified.' },
    [74] = { zone = xi.zone.CRAWLERS_NEST, mob = 'DEMONIC_TIPHIA', clue = 'My sting is extremely cruel, if you live long enough to see it.' },
    [75] = { zone = xi.zone.YUGHOTT_GROTTO, mob = 'ASHMAKER_GOTBLUT', clue = 'Got blood?' },
    [76] = { zone = xi.zone.YHOATOR_JUNGLE, mob = 'WOODLAND_SAGE', clue = 'I\'m the wisest in this land but I\'m told I should branch out more.' },
    [77] = { zone = xi.zone.LA_THEINE_PLATEAU, mob = 'TUMBLING_TRUFFLE', clue = 'Supposedly this fun guy is acrobatic but I\'ve never seen him do anything tricks.' },
    [78] = { zone = xi.zone.WEST_RONFAURE, mob = 'AMANITA', clue = 'I wouldn\'t trying eating this toxic mushroom.' },
    [79] = { zone = xi.zone.TEMPLE_OF_UGGALEPIH, mob = 'FLAUROS', clue = 'This demonic cat\'s hairs are strong enough to hold up to rapid fire.' },
    [80] = { zone = xi.zone.MIDDLE_DELKFUTTS_TOWER, mob = 'OGYGOS', clue = 'There was a great flood during my reign. Now I count flowers on the tower walls with my friends.' },
    [81] = { zone = xi.zone.BEAUCEDINE_GLACIER, mob = 'CALCABRINA', clue = 'Count the salt, walk on it, and you might be lucky enough to get a cursed item.' },
    [82] = { zone = xi.zone.KONSCHTAT_HIGHLANDS, mob = 'GHILLIE_DHU', clue = 'This shy, dark-haired spirit is covered in leaves and moss.' },
    [83] = { zone = xi.zone.GHELSBA_OUTPOST, mob = 'THOUSANDARM_DESHGLESH', clue = 'Ganesh would be jealous of my appendages.' },
    [84] = { zone = xi.zone.FORT_GHELSBA, mob = 'HUNDREDSCAR_HAJWAJ', clue = 'This guy\'s seen a lot of action, he should get some new boots.' },
    [85] = { zone = xi.zone.TAHRONGI_CANYON, mob = 'HABROK', clue = 'Officially the best of hawks that are named High Pants.' },
    [86] = { zone = xi.zone.GIDDEUS, mob = 'VUU_PUQU_THE_BEGUILER', clue = 'Just put your lips together and blow, like a bird.' },
    [87] = { zone = xi.zone.INNER_HORUTOTO_RUINS, mob = 'NOCUOUS_WEAPON', clue = 'Like all weapons, this one is harmful.' },
    [88] = { zone = xi.zone.DAVOI, mob = 'STEELBITER_GUDRUD', clue = 'Nailfiber Gertrude? Speak clearly through those messed up teeth of yours.' },
    [89] = { zone = xi.zone.UPPER_DELKFUTTS_TOWER, mob = 'MIMAS', clue = 'Hasn\'t said a word since the day Hercules slew him.' },
    [90] = { zone = xi.zone.CASTLE_OZTROJA, mob = 'YAA_HAQA_THE_PROFANE', clue = 'This guy has a dirty mouth, but used to be godly.' },
    [91] = { zone = xi.zone.BEAUCEDINE_GLACIER, mob = 'GARGANTUA', clue = 'This giant loves to munch on pilgrims.' },
    [92] = { zone = xi.zone.XARCABARD, mob = 'SHADOW_EYE', clue = 'If you look around in the dark, you might have his lunar charm.' },
    [93] = { zone = xi.zone.NORTH_GUSTABERG_S, mob = 'GLOOMANITA', clue = 'Defeat this fun guy and you might get a sharp, poisonous weapon.' },
    [94] = { zone = xi.zone.SAUROMUGUE_CHAMPAIGN_S, mob = 'BALAM_QUITZ', clue = 'This cat with a sweet smile is a great protector.' },
    [95] = { zone = xi.zone.THE_SANCTUARY_OF_ZITAH, mob = 'KEEPER_OF_HALIDOM', clue = 'The protector of the sanctuary.' },
    [96] = { zone = xi.zone.GARLAIGE_CITADEL, mob = 'SKEWER_SAM', clue = 'You might feel a draft after he runs you through with his beak.' },
    [97] = { zone = xi.zone.SEA_SERPENT_GROTTO, mob = 'MOUU_THE_WAVERIDER', clue = 'Surf\'s up, dudes!' },
    [98] = { zone = xi.zone.DANGRUF_WADI, mob = 'TEPORINGO', clue = 'This guy is no Thumper, he hangs out at night with some strange company.' },
    [99] = { zone = xi.zone.TEMPLE_OF_UGGALEPIH, mob = 'SOZU_SARBERRY', clue = 'Potentially a chef\'s best friend, but a stingy one.' },
    [100] = { zone = xi.zone.GIDDEUS, mob = 'QUU_XIJO_THE_ILLUSORY', clue = 'Is this nm and his cloth even real?' },
    [101] = { zone = xi.zone.WEST_SARUTABARUTA_S, mob = 'JEDUAH', clue = 'Swords, flowers, tchatchkes, whatever. Oy vey!' },
    [102] = { zone = xi.zone.GHELSBA_OUTPOST, mob = 'ORCISH_WALLBREACHER', clue = 'Strike the walls hard enough so that we might breach them!' },
    [103] = { zone = xi.zone.PHANAUET_CHANNEL, mob = 'VODYANOI', clue = 'This old man likes to drown people in the muck.' },
}

xi.nmHunt.vars = {
    COMPLETE_BY    = 'NM_Completeby',
    NEXT_HUNT      = 'NMHuntNextHunt',
    HUNT_TARGET    = 'NMHuntTarget',
    HUNT_SCORE     = 'NM_Score',
    HUNT_CLEARED   = 'NMHuntClear',
    HUNT_PATTERN   = 'NM_Pattern',
}

-- Helper functions
xi.nmHunt.getMobId = function(huntData)
    local zoneId = huntData.zone
    local mobName = huntData.mob
    return zones[zoneId].mob[mobName]
end

xi.nmHunt.getRandomTarget = function()
    local index = math.random(1, #xi.nmHunt.targets)
    return index, xi.nmHunt.targets[index]
end

xi.nmHunt.isHuntActive = function(player)
    local completeBy = player:getVar(xi.nmHunt.vars.COMPLETE_BY)
    return completeBy > 0 and completeBy >= GetSystemTime()
end

xi.nmHunt.checkKill = function(player)
    player:printToPlayer('You have killed your NM Hunt target! Return to the Explorer Moogle for your reward!', xi.msg.channel.SYSTEM_3)
end

xi.nmHunt.isOnCooldown = function(player)
    local nextHunt = player:getVar(xi.nmHunt.vars.NEXT_HUNT)
    return nextHunt > GetSystemTime()
end

xi.nmHunt.clearHunt = function(player)
    player:setVar(xi.nmHunt.vars.COMPLETE_BY, 0)
    player:setVar(xi.nmHunt.vars.HUNT_TARGET, 0)
    player:setVar(xi.nmHunt.vars.HUNT_PATTERN, 0)
    player:setVar(xi.nmHunt.vars.HUNT_CLEARED, 0)
end

return xi.nmHunt
