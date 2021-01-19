-----------------------------------
-- Records of Eminence
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/common")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------


function getRoeRecords(triggers)
    return {

      -----------------------------------
      -- Tutorial -> Basics
      -----------------------------------

        [   1] = { -- First Step Forward +
            reward =  { item = { {4376,6} }, keyItem = tpz.ki.MEMORANDOLL, sparks = 100, xp = 300 }
        },

        [   2] = { -- Vanquish 1 Enemy +
            trigger = triggers.mobKill,
            reward =  { sparks = 100, xp = 500}
        },

        [   3] = { -- Undertake a FoV Training Regime
            reward =  { sparks = 100, xp = 500}
        },

        [   4] = { -- Heal without magic
            reward =  { sparks = 100, xp = 500}
        },

        [  11] = { -- Undertake a GoV Training Regime
            reward =  { sparks = 100, xp = 500}
        },

        [ 932] = { -- Call Forth an Alter Ego (gives Cipher: Valaineral)
            reward =  { sparks = 100, xp = 300, item = { 10116 } }
        },

        [ 933] = { -- Alter Ego: Valaineral (gives Cipher: Mihli)
            reward =  { sparks = 100, xp = 300, item = { 10115 } }
        },

        [ 934] = { -- Alter Ego: Mihli Aliapoh (gives Cipher: Tenzen)
            reward =  { sparks = 100, xp = 300, item = { 10114 } }
        },

        [ 935] = { -- Alter Ego: Tenzen (gives Cipher: Adelheid)
            reward =  { sparks = 100, xp = 300, item = { 10153 } }
        },

        [ 936] = { -- Alter Ego: Adelheid (gives Cipher: Joachim)
            reward =  { sparks = 100, xp = 300, item = { 10117 } }
        },

        [ 937] = { -- Alter Ego: Joachim
            reward =  { sparks = 100, xp = 500 }
        },

      -----------------------------------
      -- Tutorial -> Intermediate
      -----------------------------------
        --[[ TODO
        [1045] = { -- Achieve Level 99 (gives Kupon A-PK109 x5)
            reward =  { sparks = 200, xp = 300, item = { 8733, 5 } }
        },

        [1046] = { -- An Eminent Scholar (gives Kupon W-EMI)
            reward =  { sparks = 200, xp = 200, item = { 9188 } }
        },

        [1047] = { -- An Eminent Scholar 2 (gives Kupon A-EMI)
            reward =  { sparks = 200, xp = 200, item = { 9226 } }
        },

        [1048] = { -- An Eminent Scholar 3 (gives Kupon A-EMI)
            reward =  { sparks = 200, xp = 200, item = { 9226 } }
        },

        [1049] = { -- Always Stand on 117 (gives Cipher: Koru-Moru)
            reward =  { sparks = 200, xp = 300, item = { 10140 }  }
        },
        ]]

      -----------------------------------
      -- Tutorial -> Quests 1
      -----------------------------------

        [ 500] = { -- Mog House Exit: San d'Oria
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.GROWING_FLOWERS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 501] = { -- Mog House Exit: Bastok
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.A_LADY_S_HEART} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 502] = { -- Mog House Exit: Windurst
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.FLOWER_CHILD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 503] = { -- Mog House Exit: Jeuno
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.PRETTY_LITTLE_THINGS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 504] = { -- Mog House Exit: Aht Urhgan
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.KEEPING_NOTES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        -- TODO: [505] Obtain a Support Job (Has two potential quest completes for objective)

        [ 506] = { -- Obtain an Alter Ego: San d'Oria
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.TRUST_SANDORIA} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 507] = { -- Obtain an Alter Ego: Bastok
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRUST_BASTOK} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 508] = { -- Obtain an Alter Ego: Windurst
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.TRUST_WINDURST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 509] = { -- Obtain a Chocobo License
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.CHOCOBO_S_WOUNDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 600 },
        },

        [ 510] = { -- Obtain Job: Paladin
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_SQUIRE_S_TEST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 511] = { -- Obtain Job: Dark Knight
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_DARKNESS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 512] = { -- Obtain Job: Beastmaster
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SAVE_MY_SON} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 513] = { -- Obtain Job: Bard
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_OLD_MONUMENT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 514] = { -- Obtain Job: Ranger
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_FANGED_ONE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 515] = { -- Obtain Job: Samurai
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.FORGE_YOUR_DESTINY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 516] = { -- Obtain Job: Ninja
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.AYAME_AND_KAEDE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 517] = { -- Obtain Job: Dragoon
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 518] = { -- Obtain Job: Summoner
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.I_CAN_HEAR_A_RAINBOW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 519] = { -- Obtain Job: Blue Mage
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.AN_EMPTY_VESSEL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 520] = { -- Obtain Job: Corsair
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 521] = { -- Obtain Job: Puppetmaster
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 522] = { -- Obtain Job: Dancer
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.LAKESIDE_MINUET} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 523] = { -- Obtain Job: Scholar
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.A_LITTLE_KNOWLEDGE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 524] = { -- Obtain Job: Geomancer
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 525] = { -- Obtain Job: Runefencer
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.CHILDREN_OF_THE_RUNE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 1)
      -----------------------------------

        [ 629] = { -- WAR Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_DOORMAN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 630] = { -- WAR Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_TALEKEEPER_S_TRUTH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 631] = { -- WAR Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_TALEKEEPER_S_GIFT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 632] = { -- MNK Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.GHOSTS_OF_THE_PAST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 633] = { -- MNK Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.THE_FIRST_MEETING} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 634] = { -- MNK Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.TRUE_STRENGTH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 635] = { -- WHM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.MESSENGER_FROM_BEYOND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 636] = { -- WHM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 637] = { -- WHM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.PIEUJE_S_DECISION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 638] = { -- BLM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_THREE_MAGI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 639] = { -- BLM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.RECOLLECTIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 640] = { -- BLM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 641] = { -- RDM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.THE_CRIMSON_TRIAL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 642] = { -- RDM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.ENVELOPED_IN_DARKNESS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 643] = { -- RDM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.PEACE_FOR_THE_SPIRIT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 644] = { -- THF Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_TENSHODO_SHOWDOWN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 645] = { -- THF Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.AS_THICK_AS_THIEVES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 646] = { -- THF Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.HITTING_THE_MARQUISATE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 647] = { -- PLD Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.SHARPENING_THE_SWORD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 648] = { -- PLD Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_BOY_S_DREAM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 649] = { -- PLD Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.UNDER_OATH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 650] = { -- DRK Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.DARK_LEGACY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 651] = { -- DRK Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.DARK_PUPPET} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 652] = { -- DRK Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.BLADE_OF_EVIL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 653] = { -- BST Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.WINGS_OF_GOLD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 654] = { -- BST Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SCATTERED_INTO_SHADOW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 655] = { -- BST Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.A_NEW_DAWN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 2)
      -----------------------------------

        [ 656] = { -- BRD Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.PAINFUL_MEMORY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 657] = { -- BRD Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_REQUIEM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 658] = { -- BRD Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_CIRCLE_OF_TIME} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 659] = { -- RNG Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.SIN_HUNTING} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 660] = { -- RNG Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.FIRE_AND_BRIMSTONE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 661] = { -- RNG Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.UNBRIDLED_PASSION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 662] = { -- SAM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.THE_SACRED_KATANA} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 663] = { -- SAM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.YOMI_OKURI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 664] = { -- SAM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.A_THIEF_IN_NORG} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 665] = { -- NIN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.TWENTY_IN_PIRATE_YEARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 666] = { -- NIN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 667] = { -- NIN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.TRUE_WILL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 668] = { -- DRG Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.A_CRAFTSMAN_S_WORK} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 669] = { -- DRG Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 670] = { -- DRG Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 671] = { -- SMN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.THE_PUPPET_MASTER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 672] = { -- SMN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CLASS_REUNION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 673] = { -- SMN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.CARBUNCLE_DEBACLE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 674] = { -- BLU Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 675] = { -- BLU Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 676] = { -- BLU Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.TRANSFORMATIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 677] = { -- COR Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 678] = { -- COR Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 679] = { -- COR Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.AGAINST_ALL_ODDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 680] = { -- PUP Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 681] = { -- PUP Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.OPERATION_TEATIME} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 682] = { -- PUP Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.PUPPETMASTER_BLUES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 3)
      -----------------------------------

        [ 683] = { -- DNC Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_UNFINISHED_WALTZ} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 684] = { -- DNC Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_ROAD_TO_DIVADOM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 685] = { -- DNC Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.COMEBACK_QUEEN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 686] = { -- SCH Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.ON_SABBATICAL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 687] = { -- SCH Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.DOWNWARD_HELIX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 688] = { -- SCH Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.SEEING_BLOOD_RED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 689] = { -- GEO Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.FOR_WHOM_THE_BELL_TOLLS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 690] = { -- GEO Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.THE_BLOODLINE_OF_ZACARIAH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 691] = { -- GEO Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.THE_COMMUNION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 692] = { -- RUN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.FORGING_NEW_BONDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 693] = { -- RUN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.LEGACIES_LOST_AND_FOUND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 694] = { -- RUN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.ADOULIN, tpz.quest.id.adoulin.DESTINYS_DEVICE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Level Cap Increase
      -----------------------------------

        [ 705] = { -- Level Cap Increase: 55 +
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 706] = { -- Level Cap Increase: 60
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 707] = { -- Level Cap Increase: 65
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 708] = { -- Level Cap Increase: 70
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 709] = { -- Level Cap Increase: 75
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 710] = { -- Level Cap Increase: 80
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.NEW_WORLDS_AWAIT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 711] = { -- Level Cap Increase: 85
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.EXPANDING_HORIZONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 712] = { -- Level Cap Increase: 90
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.BEYOND_THE_STARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 713] = { -- Level Cap Increase: 95
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.DORMANT_POWERS_DISLODGED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 714] = { -- Level Cap Increase: 99
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Storage Expansion
      -----------------------------------

        [ 715] = { -- Inventory Expansion 35
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_I} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 716] = { -- Inventory Expansion 40
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_II} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 717] = { -- Inventory Expansion 45
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_III} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 718] = { -- Inventory Expansion 50
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_IV} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 719] = { -- Inventory Expansion 55
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_V} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 720] = { -- Inventory Expansion 60
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 721] = { -- Inventory Expansion 65
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VII} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 722] = { -- Inventory Expansion 70
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 723] = { -- Inventory Expansion 75
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_IX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 724] = { -- Inventory Expansion 80
            trigger = triggers.questComplete,
            reqs = { questComplete = {tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.THE_GOBBIEBAG_PART_X} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Missions (San d'Oria)
      -----------------------------------

        [1313] = { -- San d'Oria Rank 1-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1314] = { -- San d'Oria Rank 1-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.BAT_HUNT} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1315] = { -- San d'Oria Rank 1-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.SAVE_THE_CHILDREN} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1316] = { -- San d'Oria Rank 2-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_RESCUE_DRILL} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1317] = { -- San d'Oria Rank 2-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_DAVOI_REPORT} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1318] = { -- San d'Oria Rank 2-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.JOURNEY_ABROAD} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1319] = { -- San d'Oria Rank 3-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.INFILTRATE_DAVOI} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1320] = { -- San d'Oria Rank 3-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_CRYSTAL_SPRING} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1321] = { -- San d'Oria Rank 3-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.APPOINTMENT_TO_JEUNO} },
            flags = set{"retro"},
            reward = { item = { {4096,8} }, sparks = 300, xp = 500 },
        },

        [1322] = { -- San d'Oria Rank 4
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.MAGICITE} },
            flags = set{"retro"},
            reward = { item = { {4097,8} }, sparks = 300, xp = 500 },
        },

        [1323] = { -- San d'Oria Rank 5-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_RUINS_OF_FEI_YIN} },
            flags = set{"retro"},
            reward = { item = { {4096,8} }, sparks = 300, xp = 500 },
        },

        [1324] = { -- San d'Oria Rank 5-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_SHADOW_LORD} },
            flags = set{"retro"},
            reward = { item = { {4097,8} }, sparks = 300, xp = 500 },
        },

        [1325] = { -- San d'Oria Rank 6-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.LEAUTE_S_LAST_WISHES} },
            flags = set{"retro"},
            reward = { item = { {4096,10} }, sparks = 300, xp = 500 },
        },

        [1326] = { -- San d'Oria Rank 6-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.RANPERRE_S_FINAL_REST} },
            flags = set{"retro"},
            reward = { item = { {4097,10} }, sparks = 300, xp = 500 },
        },

        [1327] = { -- San d'Oria Rank 7-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE} },
            flags = set{"retro"},
            reward = { item = { {4096,10} }, sparks = 300, xp = 500 },
        },

        [1328] = { -- San d'Oria Rank 7-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_SECRET_WEAPON} },
            flags = set{"retro"},
            reward = { item = { {4097,10} }, sparks = 300, xp = 500 },
        },

        [1329] = { -- San d'Oria Rank 8-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.COMING_OF_AGE} },
            flags = set{"retro"},
            reward = { item = { {4096,12} }, sparks = 300, xp = 500 },
        },

        [1330] = { -- San d'Oria Rank 8-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.LIGHTBRINGER} },
            flags = set{"retro"},
            reward = { item = { {4097,12} }, sparks = 300, xp = 500 },
        },

        [1331] = { -- San d'Oria Rank 9-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.BREAKING_BARRIERS} },
            flags = set{"retro"},
            reward = { item = { {4096,12} }, sparks = 300, xp = 500 },
        },

        [1332] = { -- San d'Oria Rank 9-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.SANDORIA, tpz.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT} },
            flags = set{"retro"},
            reward = { item = { {4097,12} }, sparks = 300, xp = 500 },
        },

      -----------------------------------
      -- Tutorial -> Missions (Bastok)
      -----------------------------------

        [1333] = { -- Bastok Rank 1-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_ZERUHN_REPORT} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1334] = { -- Bastok Rank 1-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.A_GEOLOGICAL_SURVEY} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1335] = { -- Bastok Rank 1-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.FETICHISM} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1336] = { -- Bastok Rank 2-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_CRYSTAL_LINE} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1337] = { -- Bastok Rank 2-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.WADING_BEASTS} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1338] = { -- Bastok Rank 2-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_EMISSARY} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1339] = { -- Bastok Rank 3-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_FOUR_MUSKETEERS} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1340] = { -- Bastok Rank 3-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.TO_THE_FORSAKEN_MINES} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1341] = { -- Bastok Rank 3-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.JEUNO} },
            flags = set{"retro"},
            reward = { item = { {4100,8} }, sparks = 300, xp = 500 },
        },

        [1342] = { -- Bastok Rank 4
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.MAGICITE} },
            flags = set{"retro"},
            reward = { item = { {4101,8} }, sparks = 300, xp = 500 },
        },

        [1343] = { -- Bastok Rank 5-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.DARKNESS_RISING} },
            flags = set{"retro"},
            reward = { item = { {4100,8} }, sparks = 300, xp = 500 },
        },

        [1344] = { -- Bastok Rank 5-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS} },
            flags = set{"retro"},
            reward = { item = { {4101,8} }, sparks = 300, xp = 500 },
        },

        [1345] = { -- Bastok Rank 6-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.RETURN_OF_THE_TALEKEEPER} },
            flags = set{"retro"},
            reward = { item = { {4100,10} }, sparks = 300, xp = 500 },
        },

        [1346] = { -- Bastok Rank 6-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_PIRATE_S_COVE} },
            flags = set{"retro"},
            reward = { item = { {4101,10} }, sparks = 300, xp = 500 },
        },

        [1347] = { -- Bastok Rank 7-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_FINAL_IMAGE} },
            flags = set{"retro"},
            reward = { item = { {4100,10} }, sparks = 300, xp = 500 },
        },

        [1348] = { -- Bastok Rank 7-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.ON_MY_WAY} },
            flags = set{"retro"},
            reward = { item = { {4101,10} }, sparks = 300, xp = 500 },
        },

        [1349] = { -- Bastok Rank 8-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_CHAINS_THAT_BIND_US} },
            flags = set{"retro"},
            reward = { item = { {4100,12} }, sparks = 300, xp = 500 },
        },

        [1350] = { -- Bastok Rank 8-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.ENTER_THE_TALEKEEPER} },
            flags = set{"retro"},
            reward = { item = { {4101,12} }, sparks = 300, xp = 500 },
        },

        [1351] = { -- Bastok Rank 9-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.THE_SALT_OF_THE_EARTH} },
            flags = set{"retro"},
            reward = { item = { {4100,12} }, sparks = 300, xp = 500 },
        },

        [1352] = { -- Bastok Rank 9-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {tpz.mission.log_id.BASTOK, tpz.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE} },
            flags = set{"retro"},
            reward = { item = { {4101,12} }, sparks = 300, xp = 500 },
        },

      -----------------------------------
      -- Tutorial -> Missions (Windurst)
      -----------------------------------

      [1353] = { -- Windurst Rank 1-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1354] = { -- Windurst Rank 1-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1355] = { -- Windurst Rank 1-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_PRICE_OF_PEACE} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1356] = { -- Windurst Rank 2-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.LOST_FOR_WORDS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1357] = { -- Windurst Rank 2-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.A_TESTING_TIME} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1358] = { -- Windurst Rank 2-3 +
                 -- Note: For testing purposes, this mission required changes to Kupipi.lua
                 --       missionStatus for THE_THREE_KINGDOMS should == 1, since it was accepted before onTrigger
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_THREE_KINGDOMS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1359] = { -- Windurst Rank 3-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1360] = { -- Windurst Rank 3-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.WRITTEN_IN_THE_STARS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1361] = { -- Windurst Rank 3-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.A_NEW_JOURNEY} },
          flags = set{"retro"},
          reward = { item = { {4098,8} }, sparks = 300, xp = 500 },
      },

      [1362] = { -- Windurst Rank 4 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.MAGICITE} },
          flags = set{"retro"},
          reward = { item = { {4099,8} }, sparks = 300, xp = 500 },
      },

      [1363] = { -- Windurst Rank 5-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_FINAL_SEAL} },
          flags = set{"retro"},
          reward = { item = { {4098,8} }, sparks = 300, xp = 500 },
      },

      [1364] = { -- Windurst Rank 5-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_SHADOW_AWAITS} },
          flags = set{"retro"},
          reward = { item = { {4099,8} }, sparks = 300, xp = 500 },
      },

      [1365] = { -- Windurst Rank 6-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.FULL_MOON_FOUNTAIN} },
          flags = set{"retro"},
          reward = { item = { {4098,10} }, sparks = 300, xp = 500 },
      },

      [1366] = { -- Windurst Rank 6-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.SAINTLY_INVITATION} },
          flags = set{"retro"},
          reward = { item = { {4099,10} }, sparks = 300, xp = 500 },
      },

      [1367] = { -- Windurst Rank 7-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_SIXTH_MINISTRY} },
          flags = set{"retro"},
          reward = { item = { {4098,10} }, sparks = 300, xp = 500 },
      },

      [1368] = { -- Windurst Rank 7-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.AWAKENING_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { item = { {4099,10} }, sparks = 300, xp = 500 },
      },

      [1369] = { -- Windurst Rank 8-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.VAIN} },
          flags = set{"retro"},
          reward = { item = { {4098,12} }, sparks = 300, xp = 500 },
      },

      [1370] = { -- Windurst Rank 8-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.THE_JESTER_WHO_D_BE_KING} },
          flags = set{"retro"},
          reward = { item = { {4099,12} }, sparks = 300, xp = 500 },
      },

      [1371] = { -- Windurst Rank 9-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.DOLL_OF_THE_DEAD} },
          flags = set{"retro"},
          reward = { item = { {4098,12} }, sparks = 300, xp = 500 },
      },

      [1372] = { -- Windurst Rank 9-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.WINDURST, tpz.mission.id.windurst.MOON_READING} },
          flags = set{"retro"},
          reward = { item = { {4099,12} }, sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Rhapsodies of Vana'diel)
      -----------------------------------

      [1373] = { -- Rhapsodies of Vana'diel 1-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ROV, tpz.mission.id.rov.FLAMES_OF_PRAYER} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1374] = { -- Rhapsodies of Vana'diel 1-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ROV, tpz.mission.id.rov.A_LAND_AFTER_TIME} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1375] = { -- Rhapsodies of Vana'diel 1-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ROV, tpz.mission.id.rov.VOLTO_OSCURO} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1416] = { -- Rhapsodies of Vana'diel 2-1 (Not Implemented in Release)
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ROV, tpz.mission.id.rov.CRASHING_WAVES} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Zilart)
      -----------------------------------

      [1377] = { -- Zilart Mission 1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_NEW_FRONTIER} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1378] = { -- Zilart Mission 2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.WELCOME_TNORG} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1379] = { -- Zilart Mission 3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.KAZAMS_CHIEFTAINESS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1380] = { -- Zilart Mission 4 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1381] = { -- Zilart Mission 5 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.HEADSTONE_PILGRIMAGE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1382] = { -- Zilart Mission 6 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1383] = { -- Zilart Mission 7 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_CHAMBER_OF_ORACLES} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1384] = { -- Zilart Mission 8 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1385] = { -- Zilart Mission 9 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.ROMAEVE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1386] = { -- Zilart Mission 10 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_TEMPLE_OF_DESOLATION} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1387] = { -- Zilart Mission 11 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_HALL_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1388] = { -- Zilart Mission 12 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1389] = { -- Zilart Mission 13 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_GATE_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1390] = { -- Zilart Mission 14 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.ARK_ANGELS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1391] = { -- Zilart Mission 15 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_SEALED_SHRINE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1392] = { -- Zilart Mission 16 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.ZILART, tpz.mission.id.zilart.THE_CELESTIAL_NEXUS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Chains of Promathia)
      -----------------------------------

      [1393] = { -- Chains of Promathia Chapter 1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1394] = { -- Chains of Promathia Chapter 2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.COP, tpz.mission.id.cop.ANCIENT_VOWS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1395] = { -- Chains of Promathia Chapter 3
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {tpz.mission.log_id.COP, tpz.mission.id.cop.DARKNESS_NAMED} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Treasures of Aht Urhgan)
      -----------------------------------

    -- start 1410

      -----------------------------------
      -- Combat (Wide Area) -> Combat (General)
      -----------------------------------

        [  12] = { -- Vanquish Multiple Enemies I - 200
            trigger = triggers.mobKill,
            goal = 200,
            reqs = { mobXP = true },
            flags = set{"repeat"},
            reward = { sparks = 1000, xp = 5000, unity = 100 },
        },

        [  13] = { -- Vanquish Multiple Enemies II - 500
            trigger = triggers.mobKill,
            goal = 500,
            reqs = { mobXP = true },
            reward = { sparks = 2000, xp = 6000 , item = { 6180 } },
        },

        [  14] = { -- Vanquish Multiple Enemies III - 750
            trigger = triggers.mobKill,
            goal = 750,
            reqs = { mobXP = true },
            reward = { sparks = 5000, xp = 10000 , item = { 6183 } },
        },

        [  15] = { -- Level Sync to Vanquish I
            trigger = triggers.mobKill,
            goal = 200,
            reqs = { mobXP = true , levelSync = true},
            reward = { sparks = 2000, xp = 6000 , unity = 200 },
        },

        [ 117] = { -- Level Sync to Vanquish II
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true , levelSync = true},
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 600 , unity = 20  },
        },

        [  16] = { -- Deal 500+ Damage
            trigger = triggers.dmgDealt,
            goal = 200,
            reqs = { dmgMin = 500 },
            flags = set{"repeat"},
            reward = { sparks = 1000, xp = 5000, unity = 100 },
        },

        [  17] = { -- Deal 1000+ Damage
            trigger = triggers.dmgDealt,
            goal = 150,
            reqs = { dmgMin = 1000 },
            reward = { sparks = 1000, xp = 5000 },
        },

        [  18] = { -- Deal 1500+ Damage
            trigger = triggers.dmgDealt,
            goal = 100,
            reqs = { dmgMin = 1500 },
            reward = { sparks = 1000, xp = 5000 },
        },

        [ 698] = { -- Deal 2000+ Damage
            trigger = triggers.dmgDealt,
            goal = 100,
            reqs = { dmgMin = 2000 },
            reward = { sparks = 2000, xp = 5000, item = { {8711, 6} } },
        },

        [  19] = { -- Deal 10-20 Damage
            trigger = triggers.dmgDealt,
            goal = 10,
            reqs = { dmgMin = 10, dmgMax = 20 },
            reward = { sparks = 300, xp = 2500 },
        },

        [  20] = { -- Deal 110-120 Damage
            trigger = triggers.dmgDealt,
            goal = 10,
            reqs = { dmgMin = 110, dmgMax = 120 },
            reward = { sparks = 300, xp = 1500 },
        },

        [  21] = { -- Deal 310-320 Damage
            trigger = triggers.dmgDealt,
            goal = 10,
            reqs = { dmgMin = 310, dmgMax = 320 },
            reward = { sparks = 300, xp = 1500 },
        },

        [  22] = { -- Deal 510-520 Damage
            trigger = triggers.dmgDealt,
            goal = 10,
            reqs = { dmgMin = 510, dmgMax = 520 },
            reward = { sparks = 300, xp = 1500 },
        },

        [  23] = { -- Deal 1110-1120 Damage
            trigger = triggers.dmgDealt,
            goal = 10,
            reqs = { dmgMin = 1110, dmgMax = 1120 },
            reward = { sparks = 300, xp = 1500, item = { {8711, 2} } },
        },

        [  29] = { -- Total Damage I
            trigger = triggers.dmgDealt,
            goal = 100000,
            increment = 0,
            notify = 5000,
            reward = { sparks = 1000, xp = 5000 , item = { 6181 } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [  30] = { -- Total Damage II
            trigger = triggers.dmgDealt,
            goal = 200000,
            increment = 0,
            notify = 10000,
            reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [ 696] = { -- Total Damage III
            trigger = triggers.dmgDealt,
            goal = 300000,
            increment = 0,
            notify = 10000,
            reward = { sparks = 3000, xp = 7000 , item = { 6184 } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [  31] = { -- Total Healing I
            trigger = triggers.healAlly,
            goal = 10000,
            increment = 0,
            notify = 500,
            reward = { sparks = 1000, xp = 2500, item = { 6182 } },
            check = function(self, player, params)
                    if params.heal and params.heal > 0 then
                        params.progress = params.progress + params.heal
                        return true
                    end
                    return false
                end
        },

        [  32] = { -- Total Healing II
            trigger = triggers.healAlly,
            goal = 20000,
            increment = 0,
            notify = 1000,
            reward = { sparks = 3000, xp = 7000, item = { 6185 } },
            check = function(self, player, params)
                    if params.heal and params.heal > 0 then
                        params.progress = params.progress + params.heal
                        return true
                    end
                    return false
                end
        },

        [ 699] = { -- Total Healing III
            trigger = triggers.healAlly,
            goal = 30000,
            increment = 0,
            notify = 1000,
            reward = { sparks = 3000, xp = 7000, item = { 6185 } },
            check = function(self, player, params)
                    if params.heal and params.heal > 0 then
                        params.progress = params.progress + params.heal
                        return true
                    end
                    return false
                end
        },

        [  33] = { -- Total Damage Taken I
            trigger = triggers.dmgTaken,
            goal = 10000,
            increment = 0,
            notify = 500,
            reward = { sparks = 1000, xp = 1000, item = { {8711, 2} } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [  34] = { -- Total Damage Taken II
            trigger = triggers.dmgTaken,
            goal = 20000,
            increment = 0,
            notify = 1000,
            reward = { sparks = 3000, xp = 5000, item = { {8711, 4} } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [ 697] = { -- Total Damage Taken III
            trigger = triggers.dmgTaken,
            goal = 30000,
            increment = 0,
            notify = 1000,
            reward = { sparks = 3000, xp = 5000, item = { {8711, 6} } },
            check = function(self, player, params)
                    if params.dmg and params.dmg > 0 then
                        params.progress = params.progress + params.dmg
                        return true
                    end
                    return false
                end
        },

        [  45] = { -- Weapon Skills 1
            trigger = triggers.wSkillUse,
            goal = 100,
            reward = { sparks = 500, xp = 2500 },
        },

        [ 488] = { -- Heal for 500+ HP
            trigger = triggers.healAlly,
            goal = 100,
            reqs = { healMin = 500 },
            reward = { sparks = 2000, xp = 6000 },
        },

        [ 700] = { -- Heal for 750+ HP
            trigger = triggers.healAlly,
            goal = 100,
            reqs = { healMin = 750 },
            reward = { sparks = 3000, xp = 7000, item = { 6183 } },
        },

      -----------------------------------
      -- Crafting: General
      -----------------------------------

        [  57] = { -- Total Successful Synthesis Attempts
            trigger = triggers.synthSuccess,
            goal = 30,
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, unity = 10 },
        },

      -----------------------------------
      -- Combat (Wide Area) -> Spoils 1
      -----------------------------------

        [  71] = { -- Spoils - Fire Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4096 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  72] = { -- Spoils - Ice Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4097 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  73] = { -- Spoils - Wind Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4098 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  74] = { -- Spoils - Earth Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4099 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  75] = { -- Spoils - Lightning Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4100 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  76] = { -- Spoils - Water Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4101 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  77] = { -- Spoils - Light Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4102 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  78] = { -- Spoils - Dark Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4103 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  84] = { -- Spoils - Flame Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3297 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  85] = { -- Spoils - Snow Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3298 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  86] = { -- Spoils - Breeze Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3299 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  87] = { -- Spoils - Soil Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3300 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  88] = { -- Spoils - Thunder Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3301 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  89] = { -- Spoils - Aqua Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3302 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  90] = { -- Spoils - Light Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3303 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  91] = { -- Spoils - Shadow Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3304 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  92] = { -- Spoils - Ifritite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3520 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  93] = { -- Spoils - Shivite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3521 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  94] = { -- Spoils - Garudite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3522 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  95] = { -- Spoils - Titanite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3523 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  96] = { -- Spoils - Ramuite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3524 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  97] = { -- Spoils - Leviatite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3525 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  98] = { -- Spoils - Carbite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3526 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

        [  99] = { -- Spoils - Fenrite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3527 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, unity = 20 },
        },

      -----------------------------------
      -- Combat (Wide Area) -> Spoils 2
      -----------------------------------

        [ 120] = { -- Spoils - Bat Wing
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 922 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 121] = { -- Spoils - Black Tiger Fang
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 884 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 122] = { -- Spoils - Flint Stone
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 768 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 123] = { -- Spoils - Rabbit Hide
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 856 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 124] = { -- Spoils - Honey
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4370 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 125] = { -- Spoils - Sheepskin
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 505 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 126] = { -- Spoils - Lizard Skin
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 852 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 127] = { -- Spoils - Beetle Shell
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 889 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 128] = { -- Spoils - Zeruhn Soot
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 560 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 129] = { -- Spoils - Silver Name Tag
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 13116 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 130] = { -- Spoils - Quadav Helm
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 501 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 132] = { -- Spoils - Treant Bulb
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 953 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 133] = { -- Spoils - Wild Onion
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4387 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 134] = { -- Spoils - Sleepshroom
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4374 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 135] = { -- Spoils - Sand Bat Fang
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 1015 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 136] = { -- Spoils - Zinc Ore
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 642 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 137] = { -- Spoils - Giant Bird Feather
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 842 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 138] = { -- Spoils - Three-leaf Mandragora Bud
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 1154 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 139] = { -- Spoils - Four-leaf Mandragora Bud
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 4369 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 140] = { -- Spoils - Cornette
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 17344 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 141] = { -- Spoils - Yuhtunga Sulfur
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 934 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 142] = { -- Spoils - Snobby Letter
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 1150 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 143] = { -- Spoils - Yagudo Bead Necklace
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 498 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 144] = { -- Spoils - Woozyshroom
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4373 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 145] = { -- Spoils - Beehive Chip
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 912 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 146] = { -- Spoils - Remi Shell
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 1016 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

        [ 147] = { -- Spoils - Twinstone Earring
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 13360 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, unity = 10 },
        },

      -----------------------------------
      -- Combat (Region) - Original Areas 1
      -----------------------------------

        [ 215] = { -- Conflict: West Ronfaure
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{100} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 4439 } },
        },

        [ 216] = { -- Subjugation: Jaggedy-Eared Jack
            trigger = triggers.mobKill,
            reqs = { mobID = set{17187111} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 217] = { -- Conflict: East Ronfaure
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{101} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 12577 } },
        },

        [ 218] = { -- Subjugation: Swamfisk
            trigger = triggers.mobKill,
            reqs = { mobID = set{17191189, 17191291} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 219] = { -- Conflict: Ghelsba Outpost
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{140} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 13331 } },
        },

        [ 220] = { -- Subjugation: Thousandarm Deshglesh
            trigger = triggers.mobKill,
            reqs = { mobID = set{17350826} },
            reward = { sparks = 250, xp = 550 },
        },

        [ 221] = { -- Conflict: Fort Ghelsba
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{141} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 13333 } },
        },

        [ 222] = { -- Subjugation: Hundredscar Hajwaj
            trigger = triggers.mobKill,
            reqs = { mobID = set{17354828} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 223] = { -- Conflict: Yughott Grotto
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{142} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 13336 } },
        },

        [ 224] = { -- Subjugation: Ashmaker Gotblut
            trigger = triggers.mobKill,
            reqs = { mobID = set{17358932} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 225] = { -- Conflict: King Ranperre's Tomb
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{190} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 100, unity = 5, item = { 13443 } },
        },

        [ 226] = { -- Subjugation: Barbastelle
            trigger = triggers.mobKill,
            reqs = { mobID = set{17555721} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 227] = { -- Conflict: Bostaunieux Oubliette
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{167} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, unity = 5, item = { 11532 } },
        },

        [ 228] = { -- Subjugation: Bloodsucker
            trigger = triggers.mobKill,
            reqs = { mobID = set{17461478} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 229] = { -- Conflict: Valkurm Dunes
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{103} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13456 } },
        },

        [ 230] = { -- Subjugation: Valkurm Emperor
            trigger = triggers.mobKill,
            reqs = { mobID = set{17199438} },
            reward = { sparks = 250, xp = 550 },
        },

        [ 231] = { -- Conflict: Konschtat Highlands
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{108} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13472 } },
        },

        [ 232] = { -- Subjugation: Bendigeit Vran
            trigger = triggers.mobKill,
            reqs = { mobID = set{17220001} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 233] = { -- Conflict: Gusgen Mines
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{196} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 100, unity = 5, item = { 13471 } },
        },

        [ 234] = { -- Subjugation: Juggler Hecatomb
            trigger = triggers.mobKill,
            reqs = { mobID = set{17580248} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 235] = { -- Conflict: La Theine Plateau
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{102} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13444 } },
        },

        [ 236] = { -- Subjugation: Bloodtear Baldurf
            trigger = triggers.mobKill,
            reqs = { mobID = set{17195318} },
            reward = { sparks = 500, xp = 1000 },
        },


        [ 237] = { -- Conflict: Ordelle's Caves
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{193} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 100, unity = 5, item = { 13470 } },
        },

        [ 238] = { -- Subjugation: Morbolger
            trigger = triggers.mobKill,
            reqs = { mobID = set{17568127} },
            reward = { sparks = 500, xp = 1000 },
        },

      -----------------------------------
      -- Combat (Region) - Original Areas 2
      -----------------------------------

        [ 239] = { -- Conflict: Jugner Forest
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{104} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { {4381, 12} } },
        },

        [ 240] = { -- Subjugation: King Arthro
            trigger = triggers.mobKill,
            reqs = { mobID = set{17203216} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 241] = { -- Conflict: Batallia Downs
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{105} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13685 } },
        },

        [ 242] = { -- Subjugation: Lumber Jack
            trigger = triggers.mobKill,
            reqs = { mobID = set{17207308} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 243] = { -- Conflict: Eldieme Necropolis
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{195} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { 13198 } },
        },

        [ 244] = { -- Subjugation: Cwn Cyrff
            trigger = triggers.mobKill,
            reqs = { mobID = set{17576054} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 245] = { -- Conflict: Davoi
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{149} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 12554 } },
        },

        [ 246] = { -- Subjugation: Hawkeyed Dnatbat
            trigger = triggers.mobKill,
            reqs = { mobID = set{17387567} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 247] = { -- Conflict: N. Gustaberg
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{106} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 4488 } },
        },

        [ 248] = { -- Subjugation: Maighdean Uaine
            trigger = triggers.mobKill,
            reqs = { mobID = set{17211702, 17211714} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 249] = { -- Conflict: S. Gustaberg
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{107} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 12592 } },
        },

        [ 250] = { -- Subjugation: Carnero
            trigger = triggers.mobKill,
            reqs = { mobID = set{17215613, 17215626} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 251] = { -- Conflict: Zeruhn Mines
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{172} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 100, unity = 5, item = { 13335 } },
        },

        [ 252] = { -- Conflict: Palborough Mines
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{143} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 13330 } },
        },

        [ 253] = { -- Subjugation: Zi-Ghi Bone-eater
            trigger = triggers.mobKill,
            reqs = { mobID = set{17363208} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 254] = { -- Conflict: Dangruf Wadi
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{191} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 100, unity = 5, item = { 13473 } },
        },

        [ 255] = { -- Subjugation: Teporingo
            trigger = triggers.mobKill,
            reqs = { mobID = set{17559584} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 256] = { -- Conflict: Pashhow Marshlands
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{109} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { {5721, 12} } },
        },

        [ 257] = { -- Subjugation: Ni'Zho Bladebender
            trigger = triggers.mobKill,
            reqs = { mobID = set{17223797} },
            reward = { sparks = 250, xp = 700 },
        },

        [ 258] = { -- Conflict: Rolanberry Fields
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{110} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 15487 } },
        },

        [ 259] = { -- Subjugation: Simurgh
            trigger = triggers.mobKill,
            reqs = { mobID = set{17228242} },
            reward = { sparks = 250, xp = 1000 },
        },

        [ 260] = { -- Conflict: Crawler's Nest
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{197} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { 13271 } },
        },

        [ 261] = { -- Subjugation: Demonic Tiphia
            trigger = triggers.mobKill,
            reqs = { mobID = set{17584398} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 262] = { -- Conflict: Beadeaux
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{147} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13703 } },
        },

        [ 263] = { -- Subjugation: Zo'Khu Blackcloud
            trigger = triggers.mobKill,
            reqs = { mobID = set{17379564} },
            reward = { sparks = 250, xp = 700 },
        },

      -----------------------------------
      -- Combat (Region) - Original Areas 3
      -----------------------------------

        [ 264] = { -- Conflict: West Sarutabaruta
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{115} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 4498 } },
        },

        [ 265] = { -- Subjugation: Nunyenunc
            trigger = triggers.mobKill,
            reqs = { mobID = set{17248517} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 266] = { -- Conflict: East Sarutabaruta
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{116} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 12601 } },
        },

        [ 267] = { -- Subjugation: Spiny Spipi
            trigger = triggers.mobKill,
            reqs = { mobID = set{17252657} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 268] = { -- Conflict: Giddeus
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{145} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, unity = 5, item = { 13337 } },
        },

        [ 269] = { -- Subjugation: Hoo Mjuu the Torrent
            trigger = triggers.mobKill,
            reqs = { mobID = set{17371515} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 270] = { -- Conflict: Toraimarai Canal
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{169} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, unity = 5, item = { 13586 } },
        },

        [ 271] = { -- Subjugation: Oni Carcass
            trigger = triggers.mobKill,
            reqs = { mobID = set{17469587} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 272] = { -- Conflict: Inner Horutoto Ruins
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{192} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 100, unity = 5, item = { 13332 } },
        },

        [ 273] = { -- Subjugation: Maltha
            trigger = triggers.mobKill,
            reqs = { mobID = set{17563749} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 274] = { -- Conflict: Outer Horutoto Ruins
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{194} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 100, unity = 5, item = { 13334 } },
        },

        [ 275] = { -- Subjugation: Bomb King
            trigger = triggers.mobKill,
            reqs = { mobID = set{17572094, 17572142, 17572146} },
            reward = { sparks = 250, xp = 500 },
        },

        [ 276] = { -- Conflict: Buburimu Peninsula
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{118} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13474 } },
        },

        [ 277] = { -- Subjugation: Helldiver
            trigger = triggers.mobKill,
            reqs = { mobID = set{17260907} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 278] = { -- Conflict: Tahrongi Canyon
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{117} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13468 } },
        },

        [ 279] = { -- Subjugation: Serpopard Ishtar
            trigger = triggers.mobKill,
            reqs = { mobID = set{17256563, 17256690} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 280] = { -- Conflict: Maze of Shakhrami
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{198} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 100, unity = 5, item = { 13321 } },
        },

        [ 281] = { -- Subjugation: Argus
            trigger = triggers.mobKill,
            reqs = { mobID = set{17588674} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 282] = { -- Conflict: Meriphataud Mountains
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{119} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { {4413, 12} } },
        },

        [ 283] = { -- Subjugation: Daggerclaw Dracos
            trigger = triggers.mobKill,
            reqs = { mobID = set{17264818} },
            reward = { sparks = 250, xp = 600 },
        },

        [ 284] = { -- Conflict: Sauromugue Champaign
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{120} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13577 } },
        },

        [ 285] = { -- Subjugation: Roc
            trigger = triggers.mobKill,
            reqs = { mobID = set{17269106} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 286] = { -- Conflict: Garlaige Citadel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{200} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { 15907 } },
        },

        [ 287] = { -- Subjugation: Serket
            trigger = triggers.mobKill,
            reqs = { mobID = set{17596720} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 288] = { -- Conflict: Castle Oztroja
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{151} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13723 } },
        },

        [ 289] = { -- Subjugation: Lii Jixa the Somnolist
            trigger = triggers.mobKill,
            reqs = { mobID = set{17395896} },
            reward = { sparks = 250, xp = 800 },
        },

      -----------------------------------
      -- Combat (Region) - Original Areas 4
      -----------------------------------

        [ 290] = { -- Conflict: Beaucedine Glacier
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{111} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 16261 } },
        },

        [ 291] = { -- Subjugation: Nue
            trigger = triggers.mobKill,
            reqs = { mobID = set{17231971} },
            reward = { sparks = 250, xp = 700 },
        },

        [ 292] = { -- Conflict: Ranguemont Pass
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{166} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 100, unity = 5, item = { 13323 } },
        },

        [ 293] = { -- Subjugation: Gloom Eye
            trigger = triggers.mobKill,
            reqs = { mobID = set{17457204} },
            reward = { sparks = 250, xp = 700 },
        },

        [ 294] = { -- Conflict: Fei'Yin
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{204} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { 13324 } },
        },

        [ 295] = { -- Subjugation: Goliath
            trigger = triggers.mobKill,
            reqs = { mobID = set{17613046, 17613048, 17613052, 17613054} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 296] = { -- Conflict: Xarcabard
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{112} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 13315 } },
        },

        [ 297] = { -- Subjugation: Biast
            trigger = triggers.mobKill,
            reqs = { mobID = set{17235988} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 298] = { -- Conflict: Castle Zvahl Baileys
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{161} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 750, unity = 5, item = { 13688 } },
        },

        [ 299] = { -- Subjugation: Duke Haborym
            trigger = triggers.mobKill,
            reqs = { mobID = set{17436923} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 300] = { -- Conflict: Castle Zvahl Keep
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{162} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 750, unity = 5, item = { 13689 } },
        },

        [ 301] = { -- Subjugation: Baron Vapula
            trigger = triggers.mobKill,
            reqs = { mobID = set{17440963} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 302] = { -- Conflict: Qufim Island
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{126} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 16301 } },
        },

        [ 303] = { -- Subjugation: Dosetsu Tree
            trigger = triggers.mobKill,
            reqs = { mobID = set{17293640} },
            reward = { sparks = 500, xp = 1000 },
        },

        [ 304] = { -- Conflict: Lower Delkfutt's Tower
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{184} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 100, unity = 5, item = { {5147, 12} } },
        },

        [ 305] = { -- Subjugation: Epialtes
            trigger = triggers.mobKill,
            reqs = { mobID = set{17530881} },
            reward = { sparks = 250, xp = 700 },
        },

        [ 306] = { -- Conflict: Middle Delkfutt's Tower
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{157} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 100, unity = 5, item = { {5149, 12} } },
        },

        [ 307] = { -- Subjugation: Ogygos
            trigger = triggers.mobKill,
            reqs = { mobID = set{17420592} },
            reward = { sparks = 250, xp = 700 },
        },

        [ 308] = { -- Conflict: Upper Delkfutt's Tower
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{158} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { {5757, 12} } },
        },

        [ 309] = { -- Subjugation: Enkelados
            trigger = triggers.mobKill,
            reqs = { mobID = set{17424385, 17424423} },
            reward = { sparks = 250, xp = 800 },
        },

        [ 380] = { -- Conflict: Behemoth's Dominion
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{127} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { {4398, 12} } },
        },

      -----------------------------------
      -- Combat (Region) - Adoulin 1
      -----------------------------------

      -----------------------------------
      -- Combat (Region) - Adoulin 2
      -----------------------------------

      -----------------------------------
      -- Combat (Region) - Zilart 1
      -----------------------------------

        [ 390] = { -- Conflict: Sanctuary of Zi'Tah
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{121} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { {4151, 12} } },
        },

        [ 392] = { -- Conflict: Ro'Maeve
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{122} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { {4156, 12} } },
        },

        [ 394] = { -- Conflict: Boyahda Tree
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{153} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, unity = 5, item = { {4166, 12} } },
        },

        [ 396] = { -- Conflict: Dragon's Aery
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{154} },
            flags = set{"repeat"},
            reward = { sparks = 17, xp = 850, unity = 5, item = { 4136 } },
        },

        [ 398] = { -- Conflict: Eastern Altepa Desert
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{114} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { {4164, 12} } },
        },

        [ 400] = { -- Conflict: Western Altepa Desert
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{125} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { {4165, 12} } },
        },

        [ 402] = { -- Conflict: Quicksand Caves
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{208} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, unity = 5, item = { 13637 } },
        },

        [ 404] = { -- Conflict: Gustav Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{212} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, unity = 5, item = { 13579 } },
        },

        [ 406] = { -- Conflict: Kuftal Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{174} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, unity = 5, item = { 16233 } },
        },

        [ 408] = { -- Conflict: Cape Terrigan
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{113} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 16263 } },
        },

        [ 410] = { -- Conflict: Valley of Sorrows
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{128} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 13108 } },
        },

        [ 412] = { -- Conflict: Yuhtunga Jungle
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{123} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13125 } },
        },

      -----------------------------------
      -- Combat (Region) - Zilart 2
      -----------------------------------

        [ 414] = { -- Conflict: Sea Serpent Grotto
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{176 } },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 100, unity = 5, item = { 13207 } },
        },

        [ 416] = { -- Conflict: Yhoator Jungle
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{124} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13273 } },
        },

        [ 418] = { -- Conflict: Temple of Uggalepih
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{159} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, unity = 5, item = { 15913 } },
        },

        [ 420] = { -- Conflict: Den of Rancor
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{160} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, unity = 5, item = { 13208 } },
        },

        [ 422] = { -- Conflict: Ifrit's Cauldron
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{205} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, unity = 5, item = { 13344 } },
        },

        [ 424] = { -- Conflict: Ru'Aun Gardens
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{130} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13346 } },
        },

        [ 426] = { -- Conflict: Ve'Lugannon Palace
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{177} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 100, unity = 7, item = { 13348 } },
        },

        [ 428] = { -- Conflict: Shrine of Ru'Avitau
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{178} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 100, unity = 7, item = { 13343 } },
        },

        [ 430] = { -- Conflict: Labyrinth of Onzozo
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{213} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 13345 } },
        },

        [ 432] = { -- Conflict: Korroloka Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{173} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13347 } },
        },

      -----------------------------------
      -- Combat (Region) - Promathia 1
      -----------------------------------

        [ 434] = { -- Conflict: Oldton Movalpolos
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{11} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13350 } },
        },

        [ 436] = { -- Conflict: Newton Movalpolos
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{12} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 13349 } },
        },

        [ 438] = { -- Conflict: Lufaise Meadows
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{24} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 14725 } },
        },

        [ 440] = { -- Conflict: Misareaux Coast
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{25} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13417 } },
        },

        [ 442] = { -- Conflict: Phomiuna Aqueducts
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{27} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13325 } },
        },

        [ 444] = { -- Conflict: Riverne - Site #A01
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{30} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13461 } },
        },

        [ 446] = { -- Conflict: Riverne - Site #B01
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{29} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 15813 } },
        },

        [ 448] = { -- Conflict: Sacrarium
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{28} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 13485 } },
        },

        [ 450] = { -- Conflict: Promyvion - Holla
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{16} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13487 } },
        },

        [ 452] = { -- Conflict: Promyvion - Dem
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{18} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13489 } },
        },

        [ 454] = { -- Conflict: Promyvion - Mea
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{20} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13484 } },
        },

        [ 456] = { -- Conflict: Yuhtunga Jungle
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{22} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 13486 } },
        },

      -----------------------------------
      -- Combat (Region) - Promathia 2
      -----------------------------------

        [ 458] = { -- Conflict: Al'Taieu
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{33} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13488 } },
        },

        [ 460] = { -- Conflict: Grand Palace of Hu'Xzoi
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{34} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13491 } },
        },

        [ 462] = { -- Conflict: Garden of Ru'Hmet
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{35} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 17285 } },
        },

        [ 464] = { -- Conflict: Carpenters' Landing
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{2} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13490 } },
        },

        [ 468] = { -- Conflict: Bibiki Bay
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{4} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13546 } },
        },

        [ 472] = { -- Conflict: Attohwa Chasm
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{7} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13464 } },
        },

        [ 474] = { -- Conflict: Pso'Xja
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{9} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 13445 } },
        },

        [ 476] = { -- Conflict: Uleguerand Range
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{5} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 13591 } },
        },

      -----------------------------------
      -- Combat (Region) - Aht Urhgan
      -----------------------------------

        [ 533] = { -- Conflict: Bhaflau Thickets
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{52} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, unity = 6, item = { 12324 } },
        },

        [ 535] = { -- Conflict: Mamook
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{65} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 12309 } },
        },

        [ 537] = { -- Conflict: Wajaom Woodlands
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{51} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, unity = 6, item = { 13275 } },
        },

        [ 539] = { -- Conflict: Aydeewa Subterrane
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{68} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, unity = 6, item = { 13197 } },
        },

        [ 541] = { -- Conflict: Halvung
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{62} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 15890 } },
        },

        [ 543] = { -- Conflict: Mount Zhayolm
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{61} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13629 } },
        },

        [ 545] = { -- Conflict: Caedarva Mire
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{79} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, unity = 6, item = { 13212 } },
        },

        [ 547] = { -- Conflict: Arrapago Reef
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{54} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 16235 } },
        },

        [ 549] = { -- Conflict: Alza. Undersea Ruins
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{72} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13587 } },
        },

      -----------------------------------
      -- Combat (Region) - Goddess 1
      -----------------------------------

        [ 553] = { -- Conflict: East Ronfaure [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{81} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13092 } },
        },

        [ 555] = { -- Conflict: Jugner Forest [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{82} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, unity = 5, item = { 12311 } },
        },

        [ 557] = { -- Conflict: Batallia Downs [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{84} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 13087 } },
        },

        [ 559] = { -- Conflict: La Vaule [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{85} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 13329 } },
        },

        [ 561] = { -- Conflict: Eldieme Necropolis [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{175} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 16231 } },
        },

        [ 563] = { -- Conflict: North Gustaberg [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{88} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13088 } },
        },

        [ 565] = { -- Conflict: Grauberg [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{89} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 13316 } },
        },

        [ 567] = { -- Conflict: Vunkerl Inlet [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{83} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 14727 } },
        },

        [ 569] = { -- Conflict: Pashhow Marshlands [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{90} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 13312 } },
        },

        [ 571] = { -- Conflict: Rolanberry Fields [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{91} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 12308 } },
        },

        [ 573] = { -- Conflict: Beadeaux [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{92} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 15991 } },
        },

        [ 575] = { -- Conflict: Crawlers' Nest [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{171} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 15993 } },
        },


      -----------------------------------
      -- Combat (Region) - Goddess 2
      -----------------------------------

        [ 577] = { -- Conflict: West Sarutabaruta [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{95} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, unity = 5, item = { 13079 } },
        },

        [ 579] = { -- Conflict: Fort Karugo-Narugo [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{96} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, unity = 5, item = { 16265 } },
        },

        [ 581] = { -- Conflict: Meriph. Mountains [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{97} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 12302 } },
        },

        [ 583] = { -- Conflict: Sauro. Champaign [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{98} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, unity = 5, item = { 16170 } },
        },

        [ 585] = { -- Conflict: Castle Oztroja [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{99} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 15803 } },
        },

        [ 587] = { -- Conflict: Garlaige Citadel [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{164} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, unity = 5, item = { 13466 } },
        },

        [ 589] = { -- Conflict: Beaucedine Glacier [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{136} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, unity = 7, item = { 15805 } },
        },

        [ 591] = { -- Conflict: Xarcabard [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{137} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 12385 } },
        },

        [ 593] = { -- Conflict: Castle Zvahl Baileys [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{138} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 15539 } },
        },

        [ 595] = { -- Conflict: Castle Zvahl Keep [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{155} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 15780 } },
        },

      -----------------------------------
      -- Combat (Region) - Abyssea 1
      -----------------------------------

        [ 613] = { -- Conflict: Abyssea - La Theine
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{132} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 10914 } },
        },

        [ 614] = { -- Conflict: Abyssea - Konschtat
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{15} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 15891 } },
        },

        [ 615] = { -- Conflict: Abyssea - Tahrongi
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{45} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 11765 } },
        },

        [ 616] = { -- Conflict: Abyssea - Attohwa
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{215} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 11763 } },
        },

        [ 617] = { -- Conflict: Abyssea - Misareaux
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{216} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 10966 } },
        },

        [ 618] = { -- Conflict: Abyssea - Vunkerl
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{217} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 10964 } },
        },

        [ 619] = { -- Conflict: Abyssea - Altepa
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{218} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 10968 } },
        },

        [ 620] = { -- Conflict: Abyssea - Uleguerand
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{253} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 11664 } },
        },

        [ 621] = { -- Conflict: Abyssea - Grauberg
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{254} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, unity = 8, item = { 11644 } },
        },

      -----------------------------------
      -- Combat (Region) - Escha 1
      -----------------------------------

      -----------------------------------
      -- Combat (Region) - Escha 2
      -----------------------------------

      -----------------------------------
      -- Content (Other)                 
      -----------------------------------

        [ 727] = { -- Subjugation: Kirin
            trigger = triggers.mobKill,
            reqs = { mobID = set{17506670} },
            flags = set{"repeat"},
            reward = { sparks = 1000, xp = 5000 },
        },

        [ 728] = { -- Subjugation: Genbu
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309980} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500 },
        },

        [ 729] = { -- Subjugation: Suzaku
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309983} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500 },
        },

        [ 730] = { -- Subjugation: Seiryu
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309981} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500 },
        },

        [ 731] = { -- Subjugation: Byakko
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309982} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500 },
        },

      -----------------------------------
      -- Achievements - Job Levels 1             
      -----------------------------------

        [1200] = { -- Level 30 Warrior +
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WAR, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6152, 12} } },
        },

        [1201] = { -- Level 50 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WAR, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6151, 12} } },
        },

        [1202] = { -- Level 75 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WAR, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3190, 4} } },
        },

        [1203] = { -- Level 99 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WAR, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1204] = { -- Level 30 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.MNK, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6147, 12} } },
        },

        [1205] = { -- Level 50 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.MNK, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1206] = { -- Level 75 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.MNK, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3191, 4} } },
        },

        [1207] = { -- Level 99 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.MNK, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1208] = { -- Level 30 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WHM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6167, 12} } },
        },

        [1209] = { -- Level 50 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WHM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6166, 12} } },
        },

        [1210] = { -- Level 75 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WHM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3192, 4} } },
        },

        [1211] = { -- Level 99 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.WHM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1212] = { -- Level 30 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6170, 12} } },
        },

        [1213] = { -- Level 50 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6171, 12} } },
        },

        [1214] = { -- Level 75 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3193, 4} } },
        },

        [1215] = { -- Level 99 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1216] = { -- Level 30 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RDM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6169, 12} } },
        },

        [1217] = { -- Level 50 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RDM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6168, 12} } },
        },

        [1218] = { -- Level 75 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RDM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3194, 4} } },
        },

        [1219] = { -- Level 99 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RDM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1220] = { -- Level 30 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.THF, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1221] = { -- Level 50 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.THF, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6149, 12} } },
        },

        [1222] = { -- Level 75 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.THF, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3195, 4} } },
        },

        [1223] = { -- Level 99 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.THF, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4069, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 2             
      -----------------------------------

        [1224] = { -- Level 30 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PLD, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6149, 12} } },
        },

        [1225] = { -- Level 50 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PLD, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6164, 12} } },
        },

        [1226] = { -- Level 75 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PLD, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3196, 4} } },
        },

        [1227] = { -- Level 99 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PLD, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1228] = { -- Level 30 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRK, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6153, 12} } },
        },

        [1229] = { -- Level 50 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRK, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6150, 12} } },
        },

        [1230] = { -- Level 75 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRK, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3197, 4} } },
        },

        [1231] = { -- Level 99 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRK, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1232] = { -- Level 30 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BST, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6151, 12} } },
        },

        [1233] = { -- Level 50 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BST, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6153, 12} } },
        },

        [1234] = { -- Level 75 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BST, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3198, 4} } },
        },

        [1235] = { -- Level 99 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BST, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1236] = { -- Level 30 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BRD, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6172, 12} } },
        },

        [1237] = { -- Level 50 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BRD, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6173, 12} } },
        },

        [1238] = { -- Level 75 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BRD, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3199, 4} } },
        },

        [1239] = { -- Level 99 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BRD, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1240] = { -- Level 30 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RNG, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6159, 12} } },
        },

        [1241] = { -- Level 50 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RNG, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6160, 12} } },
        },

        [1242] = { -- Level 75 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RNG, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3200, 4} } },
        },

        [1243] = { -- Level 99 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RNG, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1244] = { -- Level 30 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SAM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6156, 12} } },
        },

        [1245] = { -- Level 50 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SAM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6154, 12} } },
        },

        [1246] = { -- Level 75 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SAM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3201, 4} } },
        },

        [1247] = { -- Level 99 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SAM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {4065, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 3             
      -----------------------------------

        [1248] = { -- Level 30 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.NIN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6155, 12} } },
        },

        [1249] = { -- Level 50 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.NIN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6175, 12} } },
        },

        [1250] = { -- Level 75 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.NIN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3202, 4} } },
        },

        [1251] = { -- Level 99 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.NIN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1252] = { -- Level 30 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRG, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6154, 12} } },
        },

        [1253] = { -- Level 50 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRG, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1254] = { -- Level 75 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRG, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3203, 4} } },
        },

        [1255] = { -- Level 99 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DRG, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1256] = { -- Level 30 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SMN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6176, 12} } },
        },

        [1257] = { -- Level 50 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SMN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1258] = { -- Level 75 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SMN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3204, 4} } },
        },

        [1259] = { -- Level 99 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SMN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1260] = { -- Level 30 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLU, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6149, 12} } },
        },

        [1261] = { -- Level 50 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLU, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6177, 12} } },
        },

        [1262] = { -- Level 75 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLU, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3205, 4} } },
        },

        [1263] = { -- Level 99 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.BLU, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1264] = { -- Level 30 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.COR, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1265] = { -- Level 50 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.COR, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6160, 12} } },
        },

        [1266] = { -- Level 75 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.COR, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3206, 4} } },
        },

        [1267] = { -- Level 99 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.COR, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1268] = { -- Level 30 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PUP, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6147, 12} } },
        },

        [1269] = { -- Level 50 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PUP, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6148, 12} } },
        },

        [1270] = { -- Level 75 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PUP, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3207, 4} } },
        },

        [1271] = { -- Level 99 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.PUP, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 4             
      -----------------------------------

        [1272] = { -- Level 30 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DNC, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1273] = { -- Level 50 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DNC, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6147, 12} } },
        },

        [1274] = { -- Level 75 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DNC, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3208, 4} } },
        },

        [1275] = { -- Level 99 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.DNC, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1276] = { -- Level 30 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SCH, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6158, 12} } },
        },

        [1277] = { -- Level 50 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SCH, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6157, 12} } },
        },

        [1278] = { -- Level 75 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SCH, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3209, 4} } },
        },

        [1279] = { -- Level 99 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.SCH, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1280] = { -- Level 30 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.GEO, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6178, 12} } },
        },

        [1281] = { -- Level 50 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.GEO, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6179, 12} } },
        },

        [1282] = { -- Level 75 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.GEO, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {6092, 1} } },
        },

        [1283] = { -- Level 99 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.GEO, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4069, 1} } },
        },

        [1284] = { -- Level 30 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RUN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6150, 12} } },
        },

        [1285] = { -- Level 50 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RUN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6149, 12} } },
        },

        [1286] = { -- Level 75 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RUN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {5103, 1} } },
        },

        [1287] = { -- Level 99 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { tpz.job.RUN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4070, 1} } },
        },

      -----------------------------------
      -- Other - Daily Objectives
      -----------------------------------

        [4082] = { -- Vanquish Multiple Enemies (D)
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { mobXP = true },
            flags = set{"daily"},
            reward = { sparks = 100, xp = 500, unity = 300, item = { 8711 } },
        },

        [4083] = { -- Buff Allies (D)
            trigger = triggers.buffAlly,
            goal = 20,
            flags = set{"daily"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4084] = { -- Heal for 500+ HP (D)
            trigger = triggers.healAlly,
            goal = 100,
            reqs = { healMin = 500 },
            flags = set{"daily"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },


      -----------------------------------
      -- Timed Records - No Category
      -----------------------------------

        [4008] = {   -- Vanquish Aquans
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.AQUAN} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4009] = {   -- Vanquish Beasts
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.BEAST} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4010] = {   -- Vanquish Plantoids
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.PLANTOID} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4011] = {   -- Vanquish Lizards
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.LIZARD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4012] = {   -- Vanquish Vermin
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.VERMIN} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4013] = { -- Gain Experience
            trigger = triggers.expGain,
            goal = 5000,
            increment = 0,
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
            check = function(self, player, params)
                    if params.exp and params.exp > 0 then
                        params.progress = params.progress + params.exp
                        return true
                    end
                    return false
                end,
        },

        [4014] = {   -- Spoils (Seals)
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{1126, 1127, 2955, 2956, 2957} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4015] = {   -- Vanquish Birds (TODO: No abyssea zone kills for vanquishes when exists)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.BIRD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4016] = {   -- Vanquish Amorphs
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.AMORPH} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4017] = {   -- Vanquish Undead
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.UNDEAD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4018] = {   -- Vanquish Arcana
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{tpz.eco.ARCANA} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4019] = {   -- Crack Treasure Caskets (Triggered from caskets.lua)
            goal = 10,
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4020] = {  -- Physical Damage Kills
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = tpz.attackType.PHYSICAL },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },

        [4021] = {  -- Magic Damage Kills
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = tpz.attackType.MAGICAL },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, unity = 300, item = { 8711 } },
        },
    }
end