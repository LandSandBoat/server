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
            reward =  { item = { {4376,6} }, keyItem = xi.ki.MEMORANDOLL, sparks = 100, xp = 300 }
        },

        [   2] = { -- Vanquish 1 Enemy +
            trigger = triggers.mobKill,
            reward =  { sparks = 100, xp = 500 }
        },

        [   3] = { -- Undertake a FoV Training Regime
            reward =  { sparks = 100, xp = 500 }
        },

        [   4] = { -- Heal without magic
            reward =  { sparks = 100, xp = 500 }
        },

        [   5] = { -- All for One
            reward =  { sparks = 100, xp = 300, accolades = 1000, keyItem = xi.ki.CONCORDOLL }
        },

        [  11] = { -- Undertake a GoV Training Regime
            reward =  { sparks = 100, xp = 500 }
        },

        -- 499 Stepping into an Ambuscade

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

        --[[ TODO
        [1447] = { -- Exploring the Trove
            reward =  { sparks = 100, xp = 500 }
        },
        ]]

        [1448] = { -- Assist Channel
            reward =  { sparks = 100, xp = 300 }
        },

      -----------------------------------
      -- Tutorial -> Intermediate
      -----------------------------------
        [1045] = { -- Achieve Level 99 (gives Kupon A-PK109 x5)
            check = function(self, player, params)
                return player:getMainLvl() >= self.reqs.mJobLvl and true or false
            end,
            flags = set{"retro"},
            reqs = { mJobLvl = 99 }, 
            reward =  { 
                sparks = 200,
                xp = 300,
                item = { { 8733, 5 } },
            }
        },

        [1046] = { -- An Eminent Scholar (gives Kupon W-EMI)
            check = function(self, player, params)
                return player:getCurrency("spark_of_eminence") >= self.reqs.collectSparks and true or false
            end,
            trigger = triggers.talkToRoeNpc,
            reqs = { collectSparks = 2000 },
            reward =  {
                sparks = 200, 
                xp = 200, 
                item = { 9188 } 
            }
        },

        [1047] = { -- An Eminent Scholar 2 (gives Kupon A-EMI)
            check = function(self, player, params)
                return player:getCurrency("spark_of_eminence") >= self.reqs.collectSparks and true or false
            end,
            trigger = triggers.talkToRoeNpc,
            reqs = { collectSparks = 4000 },
            reward =  {
                sparks = 200,
                xp = 200,
                item = { 9226 }
            }
        },

        [1048] = { -- An Eminent Scholar 3 (gives Kupon A-EMI)
            check = function(self, player, params)
                return player:getCurrency("spark_of_eminence") >= self.reqs.collectSparks and true or false
            end,
            trigger = triggers.talkToRoeNpc,
            reqs = { collectSparks = 6000 },
            reward =  {
                sparks = 200,
                xp = 200,
                item = { 9226 }
            }
        },

        [1049] = { -- Always Stand on 117 (gives Cipher: Koru-Moru)
            check = function(self, player, params)
                local count = 0
                for _, slot in pairs( {
                    xi.slot.MAIN, 
                    xi.slot.SUB, 
                    xi.slot.RANGED, 
                    xi.slot.HEAD,
                    xi.slot.BODY,
                    xi.slot.HANDS,
                    xi.slot.LEGS,
                    xi.slot.FEET,
                } ) do
                    local item = player:getEquippedItem(slot)
                    if item and item:getILvl() and item:getILvl() == self.reqs.hasEquip.ilevel then
                        count = count + 1
                    end
                end
                return count >= self.reqs.hasEquip.count and true or false
            end,
            trigger = triggers.talkToRoeNpc,
            reqs = { hasEquip = { ilevel = 117, count = 3 } },
            reward =  {
                sparks = 200,
                xp = 300,
                item = { 10140 }
            }
        },
        

      -----------------------------------
      -- Tutorial -> Synthesis
      -----------------------------------

        [ 100] = { -- Speak to Carpenters' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 101] = { -- Speak to Blacksmiths' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 102] = { -- Speak to Goldsmiths' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 103] = { -- Speak to Weavers' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 104] = { -- Speak to Tanners' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 105] = { -- Speak to Boneworkers' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 106] = { -- Speak to Alchemists' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 107] = { -- Speak to Culinarians' Guild Master
            reward =  { sparks = 100, xp = 500 }
        },

        [ 108] = { -- Woodworking: Padded Box
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 2775 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 109] = { -- Smithing: Bronze Knife
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 16465, 16491 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 110] = { -- Goldsmithing: Copper Ring
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 13454, 13492 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 111] = { -- Weaving: Headgear
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 12464, 12471 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 112] = { -- Tanning: Leather Bandana
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 12440, 12542 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 113] = { -- Boneworking: Shell Powder
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 1883 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 114] = { -- Alchemy: Black Ink
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 929 } },
            reward = { sparks = 100, xp = 500 },
        },

        [ 115] = { -- Cooking: Pebble Soup
            trigger = triggers.synthSuccess,
            reqs = { itemID = set{ 4455, 4592 } },
            reward = { sparks = 100, xp = 500 },
        },

      -----------------------------------
      -- Tutorial -> Quests 1
      -----------------------------------

        [ 500] = { -- Mog House Exit: San d'Oria
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GROWING_FLOWERS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 501] = { -- Mog House Exit: Bastok
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.A_LADY_S_HEART} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 502] = { -- Mog House Exit: Windurst
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.FLOWER_CHILD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 503] = { -- Mog House Exit: Jeuno
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PRETTY_LITTLE_THINGS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 504] = { -- Mog House Exit: Aht Urhgan
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.KEEPING_NOTES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        -- TODO: [505] Obtain a Support Job (Has two potential quest completes for objective)

        [ 506] = { -- Obtain an Alter Ego: San d'Oria
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRUST_SANDORIA} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 507] = { -- Obtain an Alter Ego: Bastok
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUST_BASTOK} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 508] = { -- Obtain an Alter Ego: Windurst
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.TRUST_WINDURST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500 },
        },

        [ 509] = { -- Obtain a Chocobo License
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_S_WOUNDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 600 },
        },

        [ 510] = { -- Obtain Job: Paladin
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 511] = { -- Obtain Job: Dark Knight
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 512] = { -- Obtain Job: Beastmaster
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 513] = { -- Obtain Job: Bard
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_OLD_MONUMENT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 514] = { -- Obtain Job: Ranger
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_FANGED_ONE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 515] = { -- Obtain Job: Samurai
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.FORGE_YOUR_DESTINY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 516] = { -- Obtain Job: Ninja
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.AYAME_AND_KAEDE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 517] = { -- Obtain Job: Dragoon
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_HOLY_CREST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 518] = { -- Obtain Job: Summoner
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.I_CAN_HEAR_A_RAINBOW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 519] = { -- Obtain Job: Blue Mage
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AN_EMPTY_VESSEL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 520] = { -- Obtain Job: Corsair
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.LUCK_OF_THE_DRAW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 521] = { -- Obtain Job: Puppetmaster
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NO_STRINGS_ATTACHED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 522] = { -- Obtain Job: Dancer
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LAKESIDE_MINUET} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 523] = { -- Obtain Job: Scholar
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_LITTLE_KNOWLEDGE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 524] = { -- Obtain Job: Geomancer
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 525] = { -- Obtain Job: Runefencer
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.CHILDREN_OF_THE_RUNE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 1)
      -----------------------------------

        [ 629] = { -- WAR Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 630] = { -- WAR Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 631] = { -- WAR Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_GIFT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 632] = { -- MNK Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.GHOSTS_OF_THE_PAST} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 633] = { -- MNK Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_FIRST_MEETING} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 634] = { -- MNK Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRUE_STRENGTH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 635] = { -- WHM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.MESSENGER_FROM_BEYOND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 636] = { -- WHM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PRELUDE_OF_BLACK_AND_WHITE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 637] = { -- WHM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PIEUJE_S_DECISION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 638] = { -- BLM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_THREE_MAGI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 639] = { -- BLM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.RECOLLECTIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 640] = { -- BLM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_ROOT_OF_THE_PROBLEM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 641] = { -- RDM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_CRIMSON_TRIAL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 642] = { -- RDM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.ENVELOPED_IN_DARKNESS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 643] = { -- RDM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 644] = { -- THF Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_TENSHODO_SHOWDOWN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 645] = { -- THF Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.AS_THICK_AS_THIEVES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 646] = { -- THF Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.HITTING_THE_MARQUISATE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 647] = { -- PLD Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SHARPENING_THE_SWORD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 648] = { -- PLD Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_BOY_S_DREAM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 649] = { -- PLD Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNDER_OATH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 650] = { -- DRK Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_LEGACY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 651] = { -- DRK Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.DARK_PUPPET} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 652] = { -- DRK Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_EVIL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 653] = { -- BST Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 654] = { -- BST Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 655] = { -- BST Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.A_NEW_DAWN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 2)
      -----------------------------------

        [ 656] = { -- BRD Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PAINFUL_MEMORY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 657] = { -- BRD Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_REQUIEM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 658] = { -- BRD Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_CIRCLE_OF_TIME} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 659] = { -- RNG Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.SIN_HUNTING} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 660] = { -- RNG Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.FIRE_AND_BRIMSTONE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 661] = { -- RNG Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.UNBRIDLED_PASSION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 662] = { -- SAM Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_SACRED_KATANA} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 663] = { -- SAM Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.YOMI_OKURI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 664] = { -- SAM Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 665] = { -- NIN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TWENTY_IN_PIRATE_YEARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 666] = { -- NIN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.I_LL_TAKE_THE_BIG_BOX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 667] = { -- NIN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRUE_WILL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 668] = { -- DRG Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_CRAFTSMAN_S_WORK} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 669] = { -- DRG Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.CHASING_QUOTAS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 670] = { -- DRG Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.KNIGHT_STALKER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 671] = { -- SMN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_PUPPET_MASTER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 672] = { -- SMN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 673] = { -- SMN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 674] = { -- BLU Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.BEGINNINGS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 675] = { -- BLU Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OMENS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 676] = { -- BLU Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.TRANSFORMATIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 677] = { -- COR Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.EQUIPPED_FOR_ALL_OCCASIONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 678] = { -- COR Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.NAVIGATING_THE_UNFRIENDLY_SEAS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 679] = { -- COR Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 680] = { -- PUP Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.THE_WAYWARD_AUTOMATION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 681] = { -- PUP Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OPERATION_TEATIME} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 682] = { -- PUP Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.PUPPETMASTER_BLUES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Artifact 3)
      -----------------------------------

        [ 683] = { -- DNC Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_UNFINISHED_WALTZ} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 684] = { -- DNC Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_ROAD_TO_DIVADOM} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 685] = { -- DNC Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COMEBACK_QUEEN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 686] = { -- SCH Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.ON_SABBATICAL} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 687] = { -- SCH Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.DOWNWARD_HELIX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 688] = { -- SCH Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.SEEING_BLOOD_RED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 689] = { -- GEO Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FOR_WHOM_THE_BELL_TOLLS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 690] = { -- GEO Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_BLOODLINE_OF_ZACARIAH} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 691] = { -- GEO Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.THE_COMMUNION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 692] = { -- RUN Artifact Quest I
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.FORGING_NEW_BONDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 693] = { -- RUN Artifact Quest II
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.LEGACIES_LOST_AND_FOUND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 694] = { -- RUN Artifact Quest III
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.DESTINYS_DEVICE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Level Cap Increase
      -----------------------------------

        [ 705] = { -- Level Cap Increase: 55 +
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.IN_DEFIANT_CHALLENGE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 706] = { -- Level Cap Increase: 60
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 707] = { -- Level Cap Increase: 65
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 708] = { -- Level Cap Increase: 70
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 709] = { -- Level Cap Increase: 75
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 710] = { -- Level Cap Increase: 80
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.NEW_WORLDS_AWAIT} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 711] = { -- Level Cap Increase: 85
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.EXPANDING_HORIZONS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 712] = { -- Level Cap Increase: 90
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_STARS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 713] = { -- Level Cap Increase: 95
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.DORMANT_POWERS_DISLODGED} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 714] = { -- Level Cap Increase: 99
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_INFINITY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Storage Expansion
      -----------------------------------

        [ 715] = { -- Inventory Expansion 35
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_I} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 716] = { -- Inventory Expansion 40
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_II} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 717] = { -- Inventory Expansion 45
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_III} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 718] = { -- Inventory Expansion 50
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IV} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 719] = { -- Inventory Expansion 55
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_V} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 720] = { -- Inventory Expansion 60
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VI} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 721] = { -- Inventory Expansion 65
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VII} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 722] = { -- Inventory Expansion 70
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_VIII} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 723] = { -- Inventory Expansion 75
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_IX} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 724] = { -- Inventory Expansion 80
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_GOBBIEBAG_PART_X} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 939] = { -- Mog Safe Expansion: 60
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.GIVE_A_MOOGLE_A_BREAK} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 940] = { -- Mog Safe Expansion: 70
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_MOOGLE_PICNIC} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 941] = { -- Mog Safe Expansion: 80
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.MOOGLES_IN_THE_WILD} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Quests (Weapon Skills)
      -----------------------------------

        [ 839] = { -- Asuran Fists
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WALLS_OF_YOUR_MIND} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 840] = { -- Evisceration
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.CLOAK_AND_DAGGER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 841] = { -- Savage Blade
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.OLD_WOUNDS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 842] = { -- Ground Strike
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.INHERITANCE} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 843] = { -- Decimation
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.JEUNO, xi.quest.id.jeuno.AXE_THE_COMPETITION} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 844] = { -- Steel Cyclone
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_WEIGHT_OF_YOUR_LIMITS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 845] = { -- Spiral Hell
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.SOULS_IN_SHADOW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 846] = { -- Impulse Drive
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.METHODS_CREATE_MADNESS} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 847] = { -- Blade: Ku
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.BUGI_SODEN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 848] = { -- Tachi: Kasha
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.THE_POTENTIAL_WITHIN} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 849] = { -- Black Halo
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.ORASTERY_WOES} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 850] = { -- Retribution
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.BLOOD_AND_GLORY} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 851] = { -- Empyreal Arrow
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.WINDURST, xi.quest.id.windurst.FROM_SAPLINGS_GROW} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

        [ 852] = { -- Detonator
            trigger = triggers.questComplete,
            reqs = { questComplete = {xi.quest.log_id.BASTOK, xi.quest.id.bastok.SHOOT_FIRST_ASK_QUESTIONS_LATER} },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 300 },
        },

      -----------------------------------
      -- Tutorial -> Missions (San d'Oria)
      -----------------------------------

        [1313] = { -- San d'Oria Rank 1-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SMASH_THE_ORCISH_SCOUTS} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1314] = { -- San d'Oria Rank 1-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BAT_HUNT} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1315] = { -- San d'Oria Rank 1-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.SAVE_THE_CHILDREN} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1316] = { -- San d'Oria Rank 2-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RESCUE_DRILL} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1317] = { -- San d'Oria Rank 2-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_DAVOI_REPORT} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1318] = { -- San d'Oria Rank 2-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1319] = { -- San d'Oria Rank 3-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.INFILTRATE_DAVOI} },
            flags = set{"retro"},
            reward = { item = { {4096,6} }, sparks = 300, xp = 500 },
        },

        [1320] = { -- San d'Oria Rank 3-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_CRYSTAL_SPRING} },
            flags = set{"retro"},
            reward = { item = { {4097,6} }, sparks = 300, xp = 500 },
        },

        [1321] = { -- San d'Oria Rank 3-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.APPOINTMENT_TO_JEUNO} },
            flags = set{"retro"},
            reward = { item = { {4096,8} }, sparks = 300, xp = 500 },
        },

        [1322] = { -- San d'Oria Rank 4
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.MAGICITE} },
            flags = set{"retro"},
            reward = { item = { {4097,8} }, sparks = 300, xp = 500 },
        },

        [1323] = { -- San d'Oria Rank 5-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_RUINS_OF_FEI_YIN} },
            flags = set{"retro"},
            reward = { item = { {4096,8} }, sparks = 300, xp = 500 },
        },

        [1324] = { -- San d'Oria Rank 5-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SHADOW_LORD} },
            flags = set{"retro"},
            reward = { item = { {4097,8} }, sparks = 300, xp = 500 },
        },

        [1325] = { -- San d'Oria Rank 6-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LEAUTE_S_LAST_WISHES} },
            flags = set{"retro"},
            reward = { item = { {4096,10} }, sparks = 300, xp = 500 },
        },

        [1326] = { -- San d'Oria Rank 6-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.RANPERRE_S_FINAL_REST} },
            flags = set{"retro"},
            reward = { item = { {4097,10} }, sparks = 300, xp = 500 },
        },

        [1327] = { -- San d'Oria Rank 7-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE} },
            flags = set{"retro"},
            reward = { item = { {4096,10} }, sparks = 300, xp = 500 },
        },

        [1328] = { -- San d'Oria Rank 7-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SECRET_WEAPON} },
            flags = set{"retro"},
            reward = { item = { {4097,10} }, sparks = 300, xp = 500 },
        },

        [1329] = { -- San d'Oria Rank 8-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.COMING_OF_AGE} },
            flags = set{"retro"},
            reward = { item = { {4096,12} }, sparks = 300, xp = 500 },
        },

        [1330] = { -- San d'Oria Rank 8-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.LIGHTBRINGER} },
            flags = set{"retro"},
            reward = { item = { {4097,12} }, sparks = 300, xp = 500 },
        },

        [1331] = { -- San d'Oria Rank 9-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.BREAKING_BARRIERS} },
            flags = set{"retro"},
            reward = { item = { {4096,12} }, sparks = 300, xp = 500 },
        },

        [1332] = { -- San d'Oria Rank 9-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT} },
            flags = set{"retro"},
            reward = { item = { {4097,12} }, sparks = 300, xp = 500 },
        },

      -----------------------------------
      -- Tutorial -> Missions (Bastok)
      -----------------------------------

        [1333] = { -- Bastok Rank 1-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_ZERUHN_REPORT} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1334] = { -- Bastok Rank 1-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1335] = { -- Bastok Rank 1-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.FETICHISM} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1336] = { -- Bastok Rank 2-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CRYSTAL_LINE} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1337] = { -- Bastok Rank 2-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.WADING_BEASTS} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1338] = { -- Bastok Rank 2-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1339] = { -- Bastok Rank 3-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_FOUR_MUSKETEERS} },
            flags = set{"retro"},
            reward = { item = { {4100,6} }, sparks = 300, xp = 500 },
        },

        [1340] = { -- Bastok Rank 3-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.TO_THE_FORSAKEN_MINES} },
            flags = set{"retro"},
            reward = { item = { {4101,6} }, sparks = 300, xp = 500 },
        },

        [1341] = { -- Bastok Rank 3-3
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.JEUNO} },
            flags = set{"retro"},
            reward = { item = { {4100,8} }, sparks = 300, xp = 500 },
        },

        [1342] = { -- Bastok Rank 4
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.MAGICITE} },
            flags = set{"retro"},
            reward = { item = { {4101,8} }, sparks = 300, xp = 500 },
        },

        [1343] = { -- Bastok Rank 5-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.DARKNESS_RISING} },
            flags = set{"retro"},
            reward = { item = { {4100,8} }, sparks = 300, xp = 500 },
        },

        [1344] = { -- Bastok Rank 5-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.XARCABARD_LAND_OF_TRUTHS} },
            flags = set{"retro"},
            reward = { item = { {4101,8} }, sparks = 300, xp = 500 },
        },

        [1345] = { -- Bastok Rank 6-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.RETURN_OF_THE_TALEKEEPER} },
            flags = set{"retro"},
            reward = { item = { {4100,10} }, sparks = 300, xp = 500 },
        },

        [1346] = { -- Bastok Rank 6-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATE_S_COVE} },
            flags = set{"retro"},
            reward = { item = { {4101,10} }, sparks = 300, xp = 500 },
        },

        [1347] = { -- Bastok Rank 7-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_FINAL_IMAGE} },
            flags = set{"retro"},
            reward = { item = { {4100,10} }, sparks = 300, xp = 500 },
        },

        [1348] = { -- Bastok Rank 7-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.ON_MY_WAY} },
            flags = set{"retro"},
            reward = { item = { {4101,10} }, sparks = 300, xp = 500 },
        },

        [1349] = { -- Bastok Rank 8-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_CHAINS_THAT_BIND_US} },
            flags = set{"retro"},
            reward = { item = { {4100,12} }, sparks = 300, xp = 500 },
        },

        [1350] = { -- Bastok Rank 8-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.ENTER_THE_TALEKEEPER} },
            flags = set{"retro"},
            reward = { item = { {4101,12} }, sparks = 300, xp = 500 },
        },

        [1351] = { -- Bastok Rank 9-1
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_SALT_OF_THE_EARTH} },
            flags = set{"retro"},
            reward = { item = { {4100,12} }, sparks = 300, xp = 500 },
        },

        [1352] = { -- Bastok Rank 9-2
            trigger = triggers.missionComplete,
            reqs = { missionComplete = {xi.mission.log_id.BASTOK, xi.mission.id.bastok.WHERE_TWO_PATHS_CONVERGE} },
            flags = set{"retro"},
            reward = { item = { {4101,12} }, sparks = 300, xp = 500 },
        },

      -----------------------------------
      -- Tutorial -> Missions (Windurst)
      -----------------------------------

      [1353] = { -- Windurst Rank 1-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HORUTOTO_RUINS_EXPERIMENT} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1354] = { -- Windurst Rank 1-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_HEART_OF_THE_MATTER} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1355] = { -- Windurst Rank 1-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_PRICE_OF_PEACE} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1356] = { -- Windurst Rank 2-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.LOST_FOR_WORDS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1357] = { -- Windurst Rank 2-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_TESTING_TIME} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1358] = { -- Windurst Rank 2-3 +
                 -- Note: For testing purposes, this mission required changes to Kupipi.lua
                 --       missionStatus for THE_THREE_KINGDOMS should == 1, since it was accepted before onTrigger
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1359] = { -- Windurst Rank 3-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.TO_EACH_HIS_OWN_RIGHT} },
          flags = set{"retro"},
          reward = { item = { {4098,6} }, sparks = 300, xp = 500 },
      },

      [1360] = { -- Windurst Rank 3-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.WRITTEN_IN_THE_STARS} },
          flags = set{"retro"},
          reward = { item = { {4099,6} }, sparks = 300, xp = 500 },
      },

      [1361] = { -- Windurst Rank 3-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.A_NEW_JOURNEY} },
          flags = set{"retro"},
          reward = { item = { {4098,8} }, sparks = 300, xp = 500 },
      },

      [1362] = { -- Windurst Rank 4 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.MAGICITE} },
          flags = set{"retro"},
          reward = { item = { {4099,8} }, sparks = 300, xp = 500 },
      },

      [1363] = { -- Windurst Rank 5-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_FINAL_SEAL} },
          flags = set{"retro"},
          reward = { item = { {4098,8} }, sparks = 300, xp = 500 },
      },

      [1364] = { -- Windurst Rank 5-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SHADOW_AWAITS} },
          flags = set{"retro"},
          reward = { item = { {4099,8} }, sparks = 300, xp = 500 },
      },

      [1365] = { -- Windurst Rank 6-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.FULL_MOON_FOUNTAIN} },
          flags = set{"retro"},
          reward = { item = { {4098,10} }, sparks = 300, xp = 500 },
      },

      [1366] = { -- Windurst Rank 6-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.SAINTLY_INVITATION} },
          flags = set{"retro"},
          reward = { item = { {4099,10} }, sparks = 300, xp = 500 },
      },

      [1367] = { -- Windurst Rank 7-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_SIXTH_MINISTRY} },
          flags = set{"retro"},
          reward = { item = { {4098,10} }, sparks = 300, xp = 500 },
      },

      [1368] = { -- Windurst Rank 7-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.AWAKENING_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { item = { {4099,10} }, sparks = 300, xp = 500 },
      },

      [1369] = { -- Windurst Rank 8-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.VAIN} },
          flags = set{"retro"},
          reward = { item = { {4098,12} }, sparks = 300, xp = 500 },
      },

      [1370] = { -- Windurst Rank 8-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_JESTER_WHO_D_BE_KING} },
          flags = set{"retro"},
          reward = { item = { {4099,12} }, sparks = 300, xp = 500 },
      },

      [1371] = { -- Windurst Rank 9-1
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.DOLL_OF_THE_DEAD} },
          flags = set{"retro"},
          reward = { item = { {4098,12} }, sparks = 300, xp = 500 },
      },

      [1372] = { -- Windurst Rank 9-2
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING} },
          flags = set{"retro"},
          reward = { item = { {4099,12} }, sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Rhapsodies of Vana'diel)
      -----------------------------------

      [1373] = { -- Rhapsodies of Vana'diel 1-1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ROV, xi.mission.id.rov.FLAMES_OF_PRAYER} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1374] = { -- Rhapsodies of Vana'diel 1-2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ROV, xi.mission.id.rov.A_LAND_AFTER_TIME} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1375] = { -- Rhapsodies of Vana'diel 1-3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ROV, xi.mission.id.rov.SET_FREE} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      [1416] = { -- Rhapsodies of Vana'diel 2-1 (Not Implemented in Release)
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ROV, xi.mission.id.rov.CRASHING_WAVES} },
          flags = set{"retro"},
          reward = { item = { {8711,2} }, sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Zilart)
      -----------------------------------

      [1377] = { -- Zilart Mission 1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_NEW_FRONTIER} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1378] = { -- Zilart Mission 2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.WELCOME_TNORG} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1379] = { -- Zilart Mission 3 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.KAZHAMS_CHIEFTAINESS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1380] = { -- Zilart Mission 4 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_UGGALEPIH} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1381] = { -- Zilart Mission 5 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.HEADSTONE_PILGRIMAGE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1382] = { -- Zilart Mission 6 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THROUGH_THE_QUICKSAND_CAVES} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1383] = { -- Zilart Mission 7 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CHAMBER_OF_ORACLES} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1384] = { -- Zilart Mission 8 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1385] = { -- Zilart Mission 9 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1386] = { -- Zilart Mission 10 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_TEMPLE_OF_DESOLATION} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1387] = { -- Zilart Mission 11 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_HALL_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1388] = { -- Zilart Mission 12 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_MITHRA_AND_THE_CRYSTAL} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1389] = { -- Zilart Mission 13 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_GATE_OF_THE_GODS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1390] = { -- Zilart Mission 14 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.ARK_ANGELS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1391] = { -- Zilart Mission 15 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_SEALED_SHRINE} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1392] = { -- Zilart Mission 16 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_CELESTIAL_NEXUS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      -----------------------------------
      -- Tutorial -> Missions (Chains of Promathia)
      -----------------------------------

      [1393] = { -- Chains of Promathia Chapter 1 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.THE_MOTHERCRYSTALS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1394] = { -- Chains of Promathia Chapter 2 +
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.ANCIENT_VOWS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1395] = { -- Chains of Promathia Chapter 3
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1396] = { -- Chains of Promathia Chapter 4
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.SLANDEROUS_UTTERINGS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1397] = { -- Chains of Promathia Chapter 5
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.THREE_PATHS} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1398] = { -- Chains of Promathia Chapter 6
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.ONE_TO_BE_FEARED} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1399] = { -- Chains of Promathia Chapter 7
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.THE_WARRIOR_S_PATH} },
          flags = set{"retro"},
          reward = { sparks = 300, xp = 500 },
      },

      [1400] = { -- Chains of Promathia Chapter 8
          trigger = triggers.missionComplete,
          reqs = { missionComplete = {xi.mission.log_id.COP, xi.mission.id.cop.DAWN} },
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
            reward = { sparks = 1000, xp = 5000, accolades = 100 },
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
            reward = { sparks = 2000, xp = 6000 , accolades = 200 },
        },

        [ 117] = { -- Level Sync to Vanquish II
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true , levelSync = true},
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 600 , accolades = 20  },
        },

        [  16] = { -- Deal 500+ Damage
            trigger = triggers.dmgDealt,
            goal = 200,
            reqs = { dmgMin = 500 },
            flags = set{"repeat"},
            reward = { sparks = 1000, xp = 5000, accolades = 100 },
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
            reward = { sparks = 100, xp = 500, accolades = 10 },
        },

      -----------------------------------
      -- Combat (Wide Area) -> Spoils 1
      -----------------------------------

        [  71] = { -- Spoils - Fire Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4096 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  72] = { -- Spoils - Ice Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4097 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  73] = { -- Spoils - Wind Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4098 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  74] = { -- Spoils - Earth Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4099 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  75] = { -- Spoils - Lightning Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4100 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  76] = { -- Spoils - Water Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4101 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  77] = { -- Spoils - Light Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4102 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  78] = { -- Spoils - Dark Crystals
            trigger = triggers.itemLooted,
            goal = 10,
            reqs = { itemID = set{ 4103 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  84] = { -- Spoils - Flame Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3297 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  85] = { -- Spoils - Snow Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3298 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  86] = { -- Spoils - Breeze Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3299 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  87] = { -- Spoils - Soil Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3300 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  88] = { -- Spoils - Thunder Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3301 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  89] = { -- Spoils - Aqua Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3302 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  90] = { -- Spoils - Light Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3303 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  91] = { -- Spoils - Shadow Geode
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3304 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  92] = { -- Spoils - Ifritite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3520 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  93] = { -- Spoils - Shivite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3521 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  94] = { -- Spoils - Garudite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3522 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  95] = { -- Spoils - Titanite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3523 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  96] = { -- Spoils - Ramuite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3524 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  97] = { -- Spoils - Leviatite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3525 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  98] = { -- Spoils - Carbite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3526 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

        [  99] = { -- Spoils - Fenrite
            trigger = triggers.itemLooted,
            goal = 3,
            reqs = { itemID = set{ 3527 } },
            flags = set{"repeat"},
            reward = { sparks = 200, xp = 1000, accolades = 20 },
        },

      -----------------------------------
      -- Combat (Wide Area) -> Spoils 2
      -----------------------------------

        [ 120] = { -- Spoils - Bat Wing
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 922 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 121] = { -- Spoils - Black Tiger Fang
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 884 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 122] = { -- Spoils - Flint Stone
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 768 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 123] = { -- Spoils - Rabbit Hide
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 856 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 124] = { -- Spoils - Honey
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4370 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 125] = { -- Spoils - Sheepskin
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 505 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 126] = { -- Spoils - Lizard Skin
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 852 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 127] = { -- Spoils - Beetle Shell
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 889 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 128] = { -- Spoils - Zeruhn Soot
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 560 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 129] = { -- Spoils - Silver Name Tag
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 13116 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 130] = { -- Spoils - Quadav Helm
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 501 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 132] = { -- Spoils - Treant Bulb
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 953 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 133] = { -- Spoils - Wild Onion
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4387 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 134] = { -- Spoils - Sleepshroom
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4374 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 135] = { -- Spoils - Sand Bat Fang
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 1015 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 136] = { -- Spoils - Zinc Ore
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 642 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 137] = { -- Spoils - Giant Bird Feather
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 842 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 138] = { -- Spoils - Three-leaf Mandragora Bud
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 1154 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 139] = { -- Spoils - Four-leaf Mandragora Bud
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 4369 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 140] = { -- Spoils - Cornette
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 17344 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 141] = { -- Spoils - Yuhtunga Sulfur
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 934 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 142] = { -- Spoils - Snobby Letter
            trigger = triggers.itemLooted,
            goal = 1,
            reqs = { itemID = set{ 1150 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 143] = { -- Spoils - Yagudo Bead Necklace
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 498 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 144] = { -- Spoils - Woozyshroom
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 4373 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 145] = { -- Spoils - Beehive Chip
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 912 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 146] = { -- Spoils - Remi Shell
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 1016 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

        [ 147] = { -- Spoils - Twinstone Earring
            trigger = triggers.itemLooted,
            goal = 2,
            reqs = { itemID = set{ 13360 } },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 300, accolades = 10 },
        },

      -----------------------------------
      -- Combat (Region) - Original Areas 1
      -----------------------------------

        [ 215] = { -- Conflict: West Ronfaure
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{100} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 4439 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 12577 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 13331 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 13333 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 13336 } },
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
            reward = { sparks = 10, xp = 100, accolades = 5, item = { 13443 } },
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
            reward = { sparks = 15, xp = 100, accolades = 5, item = { 11532 } },
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
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13456 } },
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
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13472 } },
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
            reward = { sparks = 11, xp = 100, accolades = 5, item = { 13471 } },
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
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13444 } },
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
            reward = { sparks = 12, xp = 100, accolades = 5, item = { 13470 } },
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
            reward = { sparks = 12, xp = 600, accolades = 5, item = { {4381, 12} } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13685 } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { 13198 } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 12554 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 4488 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 12592 } },
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
            reward = { sparks = 10, xp = 100, accolades = 5, item = { 13335 } },
        },

        [ 252] = { -- Conflict: Palborough Mines
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{143} },
            flags = set{"repeat"},
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 13330 } },
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
            reward = { sparks = 10, xp = 100, accolades = 5, item = { 13473 } },
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
            reward = { sparks = 12, xp = 600, accolades = 5, item = { {5721, 12} } },
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
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 15487 } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { 13271 } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13703 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 4498 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 12601 } },
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
            reward = { sparks = 10, xp = 500, accolades = 5, item = { 13337 } },
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
            reward = { sparks = 15, xp = 100, accolades = 5, item = { 13586 } },
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
            reward = { sparks = 10, xp = 100, accolades = 5, item = { 13332 } },
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
            reward = { sparks = 10, xp = 100, accolades = 5, item = { 13334 } },
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
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13474 } },
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
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13468 } },
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
            reward = { sparks = 12, xp = 100, accolades = 5, item = { 13321 } },
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
            reward = { sparks = 12, xp = 600, accolades = 5, item = { {4413, 12} } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13577 } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { 15907 } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13723 } },
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
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 16261 } },
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
            reward = { sparks = 11, xp = 100, accolades = 5, item = { 13323 } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { 13324 } },
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
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 13315 } },
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
            reward = { sparks = 15, xp = 750, accolades = 5, item = { 13688 } },
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
            reward = { sparks = 15, xp = 750, accolades = 5, item = { 13689 } },
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
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 16301 } },
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
            reward = { sparks = 13, xp = 100, accolades = 5, item = { {5147, 12} } },
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
            reward = { sparks = 13, xp = 100, accolades = 5, item = { {5149, 12} } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { {5757, 12} } },
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
            reward = { sparks = 14, xp = 100, accolades = 5, item = { {4398, 12} } },
        },

      -----------------------------------
      -- Combat (Region) - Adoulin 1
      -----------------------------------

        [ 310] = { -- Conflict: Rala Waterways I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Spoutdrenched_Toad"}, zone = set{258} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 311] = { -- Conflict: Rala Waterways II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Stillwater_Funguar"}, zone = set{258} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 312] = { -- Conflict: Rala Waterways III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Pewter_Diremite"}, zone = set{258} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 313] = { -- Conflict: Ceizak Battlegrounds I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Blanched_Mandragora"}, zone = set{261} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 314] = { -- Conflict: Ceizak Battlegrounds II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Careening_Twitherym"}, zone = set{261} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 315] = { -- Conflict: Ceizak Battlegrounds III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Resplendent_Luckybug"}, zone = set{261} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 316] = { -- Conflict: Yahse Hunting Grounds I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Calfcleaving_Chapuli"}, zone = set{260} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 317] = { -- Conflict: Yahse Hunting Grounds II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Twitherym_Infestation"}, zone = set{260} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 318] = { -- Conflict: Yahse Hunting Grounds III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Nettled_Wasp"}, zone = set{260} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, capacity = 100, accolades = 10 },
        },

        [ 319] = { -- Conflict: Foret de Hennitiel I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Perfidious_Crab"}, zone = set{262} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 320] = { -- Conflict: Foret de Hennitiel II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Scummy_Slug"}, zone = set{262} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 321] = { -- Conflict: Foret de Hennitiel III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Vorst_Gnat"}, zone = set{262} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 322] = { -- Conflict: Morimar Basalt Fields I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Sinewy_Matamata"}, zone = set{265} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 323] = { -- Conflict: Morimar Basalt Fields II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Tephra_Lizard"}, zone = set{265} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 324] = { -- Conflict: Morimar Basalt Fields III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Maca_Maca"}, zone = set{265} },
            flags = set{"repeat"},
            reward = { sparks = 110, xp = 500, capacity = 100, accolades = 11 },
        },

        [ 325] = { -- Conflict: Yorcia Weald I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Snapweed"}, zone = set{263} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

        [ 326] = { -- Conflict: Yorcia Weald II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Cheeky_Opo-opo"}, zone = set{263} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

        [ 327] = { -- Conflict: Yorcia Weald III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Bronzecap"}, zone = set{263} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

        [ 328] = { -- Conflict: Marjami Ravine I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Vinelash_Vulture"}, zone = set{266} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

        [ 329] = { -- Conflict: Marjami Ravine II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Stryx"}, zone = set{266} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

        [ 330] = { -- Conflict: Marjami Ravine III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Lapinion"}, zone = set{266} },
            flags = set{"repeat"},
            reward = { sparks = 120, xp = 500, capacity = 100, accolades = 12 },
        },

      -----------------------------------
      -- Combat (Region) - Adoulin 2
      -----------------------------------

        [ 331] = { -- Conflict: Kamihr Drifts I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Snowpelt_Rabbit"}, zone = set{267} },
            flags = set{"repeat"},
            reward = { sparks = 130, xp = 500, capacity = 100, accolades = 13 },
        },

        [ 332] = { -- Conflict: Kamihr Drifts II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Cicatricose_Raaz"}, zone = set{267} },
            flags = set{"repeat"},
            reward = { sparks = 130, xp = 500, capacity = 100, accolades = 13 },
        },

        [ 333] = { -- Conflict: Kamihr Drifts III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Shaggy_Ovim"}, zone = set{267} },
            flags = set{"repeat"},
            reward = { sparks = 130, xp = 500, capacity = 100, accolades = 13 },
        },

        [ 334] = { -- Conflict: Sih Gates I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Bonaria"}, zone = set{268} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 335] = { -- Conflict: Sih Gates II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Loathsome_Obdella"}, zone = set{268} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 336] = { -- Conflict: Sih Gates III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Ferocious_Funguar"}, zone = set{268} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 337] = { -- Conflict: Moh Gates I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Conflagrant_Eruca"}, zone = set{269} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 338] = { -- Conflict: Moh Gates II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Erythemic_Eft"}, zone = set{269} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 339] = { -- Conflict: Moh Gates III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Writhing_Obdella"}, zone = set{269} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 340] = { -- Conflict: Cirdas Caverns I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Subterrane_Spider"}, zone = set{270} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 341] = { -- Conflict: Cirdas Caverns II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Livid_Umbril"}, zone = set{270} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 342] = { -- Conflict: Cirdas Caverns III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Flatus_Acuex"}, zone = set{270} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 343] = { -- Conflict: Dho Gates I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Velkk_Magus"}, zone = set{272} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 344] = { -- Conflict: Dho Gates II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Ripsaw_Jagil"}, zone = set{272} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 345] = { -- Conflict: Dho Gates III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Unyielding_Tarichuk"}, zone = set{272} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 346] = { -- Conflict: Woh Gates I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Metalcruncher_Worm"}, zone = set{273} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 347] = { -- Conflict: Woh Gates II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Drusy_Twitherym"}, zone = set{273} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 348] = { -- Conflict: Woh Gates III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Wheezing_Acuex"}, zone = set{273} },
            flags = set{"repeat"},
            reward = { sparks = 160, xp = 500, capacity = 100, accolades = 16 },
        },

        [ 494] = { -- Conflict: Outer Ra'Kaznar I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Restless_Twitherym"}, zone = set{274} },
            flags = set{"repeat"},
            reward = { sparks = 170, xp = 500, capacity = 100, accolades = 17 },
        },

        [ 495] = { -- Conflict: Outer Ra'Kaznar II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Bristlehair_Bat"}, zone = set{274} },
            flags = set{"repeat"},
            reward = { sparks = 170, xp = 500, capacity = 100, accolades = 17 },
        },

        [ 496] = { -- Conflict: Outer Ra'Kaznar III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Astringent_Acuex"}, zone = set{274} },
            flags = set{"repeat"},
            reward = { sparks = 170, xp = 500, capacity = 100, accolades = 17 },
        },

        [ 762] = { -- Conflict: Ra'Kaznar Inner Court I
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Bilespouting_Acuex"}, zone = set{276} },
            flags = set{"repeat"},
            reward = { sparks = 180, xp = 600, capacity = 100, accolades = 18 },
        },

        [ 763] = { -- Conflict: Ra'Kaznar Inner Court II
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Scowling_Vodoriga"}, zone = set{276} },
            flags = set{"repeat"},
            reward = { sparks = 180, xp = 600, capacity = 100, accolades = 18 },
        },

        [ 764] = { -- Conflict: Ra'Kaznar Inner Court III
            trigger = triggers.mobKill,
            goal = 5,
            reqs = { mobName = set{"Unrepentant_Byrgen"}, zone = set{276} },
            flags = set{"repeat"},
            reward = { sparks = 180, xp = 600, capacity = 100, accolades = 18 },
        },

      -----------------------------------
      -- Combat (Region) - Zilart 1
      -----------------------------------

        [ 390] = { -- Conflict: Sanctuary of Zi'Tah
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{121} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { {4151, 12} } },
        },

        [ 392] = { -- Conflict: Ro'Maeve
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{122} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { {4156, 12} } },
        },

        [ 394] = { -- Conflict: Boyahda Tree
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{153} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, accolades = 5, item = { {4166, 12} } },
        },

        [ 396] = { -- Conflict: Dragon's Aery
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{154} },
            flags = set{"repeat"},
            reward = { sparks = 17, xp = 850, accolades = 5, item = { 4136 } },
        },

        [ 398] = { -- Conflict: Eastern Altepa Desert
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{114} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { {4164, 12} } },
        },

        [ 400] = { -- Conflict: Western Altepa Desert
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{125} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { {4165, 12} } },
        },

        [ 402] = { -- Conflict: Quicksand Caves
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{208} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, accolades = 5, item = { 13637 } },
        },

        [ 404] = { -- Conflict: Gustav Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{212} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, accolades = 5, item = { 13579 } },
        },

        [ 406] = { -- Conflict: Kuftal Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{174} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 100, accolades = 5, item = { 16233 } },
        },

        [ 408] = { -- Conflict: Cape Terrigan
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{113} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 16263 } },
        },

        [ 410] = { -- Conflict: Valley of Sorrows
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{128} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 13108 } },
        },

        [ 412] = { -- Conflict: Yuhtunga Jungle
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{123} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13125 } },
        },

      -----------------------------------
      -- Combat (Region) - Zilart 2
      -----------------------------------

        [ 414] = { -- Conflict: Sea Serpent Grotto
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{176 } },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 100, accolades = 5, item = { 13207 } },
        },

        [ 416] = { -- Conflict: Yhoator Jungle
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{124} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13273 } },
        },

        [ 418] = { -- Conflict: Temple of Uggalepih
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{159} },
            flags = set{"repeat"},
            reward = { sparks = 15, xp = 100, accolades = 5, item = { 15913 } },
        },

        [ 420] = { -- Conflict: Den of Rancor
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{160} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, accolades = 5, item = { 13208 } },
        },

        [ 422] = { -- Conflict: Ifrit's Cauldron
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{205} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 100, accolades = 5, item = { 13344 } },
        },

        [ 424] = { -- Conflict: Ru'Aun Gardens
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{130} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13346 } },
        },

        [ 426] = { -- Conflict: Ve'Lugannon Palace
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{177} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 100, accolades = 7, item = { 13348 } },
        },

        [ 428] = { -- Conflict: Shrine of Ru'Avitau
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{178} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 100, accolades = 7, item = { 13343 } },
        },

        [ 430] = { -- Conflict: Labyrinth of Onzozo
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{213} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 13345 } },
        },

        [ 432] = { -- Conflict: Korroloka Tunnel
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{173} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13347 } },
        },

      -----------------------------------
      -- Combat (Region) - Promathia 1
      -----------------------------------

        [ 434] = { -- Conflict: Oldton Movalpolos
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{11} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13350 } },
        },

        [ 436] = { -- Conflict: Newton Movalpolos
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{12} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 13349 } },
        },

        [ 438] = { -- Conflict: Lufaise Meadows
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{24} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 14725 } },
        },

        [ 440] = { -- Conflict: Misareaux Coast
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{25} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13417 } },
        },

        [ 442] = { -- Conflict: Phomiuna Aqueducts
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{27} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13325 } },
        },

        [ 444] = { -- Conflict: Riverne - Site #A01
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{30} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13461 } },
        },

        [ 446] = { -- Conflict: Riverne - Site #B01
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{29} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 15813 } },
        },

        [ 448] = { -- Conflict: Sacrarium
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{28} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 13485 } },
        },

        [ 450] = { -- Conflict: Promyvion - Holla
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{16} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13487 } },
        },

        [ 452] = { -- Conflict: Promyvion - Dem
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{18} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13489 } },
        },

        [ 454] = { -- Conflict: Promyvion - Mea
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{20} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13484 } },
        },

        [ 456] = { -- Conflict: Promyvion - Vahzl
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{22} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 13486 } },
        },

      -----------------------------------
      -- Combat (Region) - Promathia 2
      -----------------------------------

        [ 458] = { -- Conflict: Al'Taieu
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{33} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13488 } },
        },

        [ 460] = { -- Conflict: Grand Palace of Hu'Xzoi
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{34} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13491 } },
        },

        [ 462] = { -- Conflict: Garden of Ru'Hmet
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{35} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 17285 } },
        },

        [ 464] = { -- Conflict: Carpenters' Landing
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{2} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13490 } },
        },

        [ 468] = { -- Conflict: Bibiki Bay
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{4} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13546 } },
        },

        [ 472] = { -- Conflict: Attohwa Chasm
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{7} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13464 } },
        },

        [ 474] = { -- Conflict: Pso'Xja
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{9} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 13445 } },
        },

        [ 476] = { -- Conflict: Uleguerand Range
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{5} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 13591 } },
        },

      -----------------------------------
      -- Combat (Region) - Aht Urhgan
      -----------------------------------

        [ 533] = { -- Conflict: Bhaflau Thickets
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{52} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, accolades = 6, item = { 12324 } },
        },

        [ 535] = { -- Conflict: Mamook
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{65} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 12309 } },
        },

        [ 537] = { -- Conflict: Wajaom Woodlands
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{51} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, accolades = 6, item = { 13275 } },
        },

        [ 539] = { -- Conflict: Aydeewa Subterrane
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{68} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, accolades = 6, item = { 13197 } },
        },

        [ 541] = { -- Conflict: Halvung
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{62} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 15890 } },
        },

        [ 543] = { -- Conflict: Mount Zhayolm
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{61} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13629 } },
        },

        [ 545] = { -- Conflict: Caedarva Mire
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{79} },
            flags = set{"repeat"},
            reward = { sparks = 60, xp = 800, accolades = 6, item = { 13212 } },
        },

        [ 547] = { -- Conflict: Arrapago Reef
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{54} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 16235 } },
        },

        [ 549] = { -- Conflict: Alza. Undersea Ruins
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{72} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13587 } },
        },

      -----------------------------------
      -- Combat (Region) - Goddess 1
      -----------------------------------

        [ 553] = { -- Conflict: East Ronfaure [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{81} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13092 } },
        },

        [ 555] = { -- Conflict: Jugner Forest [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{82} },
            flags = set{"repeat"},
            reward = { sparks = 14, xp = 700, accolades = 5, item = { 12311 } },
        },

        [ 557] = { -- Conflict: Batallia Downs [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{84} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 13087 } },
        },

        [ 559] = { -- Conflict: La Vaule [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{85} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 13329 } },
        },

        [ 561] = { -- Conflict: Eldieme Necropolis [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{175} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 16231 } },
        },

        [ 563] = { -- Conflict: North Gustaberg [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{88} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13088 } },
        },

        [ 565] = { -- Conflict: Grauberg [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{89} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 13316 } },
        },

        [ 567] = { -- Conflict: Vunkerl Inlet [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{83} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 14727 } },
        },

        [ 569] = { -- Conflict: Pashhow Marshlands [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{90} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 13312 } },
        },

        [ 571] = { -- Conflict: Rolanberry Fields [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{91} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 12308 } },
        },

        [ 573] = { -- Conflict: Beadeaux [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{92} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 15991 } },
        },

        [ 575] = { -- Conflict: Crawlers' Nest [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{171} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 15993 } },
        },


      -----------------------------------
      -- Combat (Region) - Goddess 2
      -----------------------------------

        [ 577] = { -- Conflict: West Sarutabaruta [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{95} },
            flags = set{"repeat"},
            reward = { sparks = 11, xp = 550, accolades = 5, item = { 13079 } },
        },

        [ 579] = { -- Conflict: Fort Karugo-Narugo [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{96} },
            flags = set{"repeat"},
            reward = { sparks = 12, xp = 600, accolades = 5, item = { 16265 } },
        },

        [ 581] = { -- Conflict: Meriph. Mountains [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{97} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 12302 } },
        },

        [ 583] = { -- Conflict: Sauro. Champaign [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{98} },
            flags = set{"repeat"},
            reward = { sparks = 13, xp = 650, accolades = 5, item = { 16170 } },
        },

        [ 585] = { -- Conflict: Castle Oztroja [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{99} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 15803 } },
        },

        [ 587] = { -- Conflict: Garlaige Citadel [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{164} },
            flags = set{"repeat"},
            reward = { sparks = 16, xp = 800, accolades = 5, item = { 13466 } },
        },

        [ 589] = { -- Conflict: Beaucedine Glacier [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{136} },
            flags = set{"repeat"},
            reward = { sparks = 70, xp = 850, accolades = 7, item = { 15805 } },
        },

        [ 591] = { -- Conflict: Xarcabard [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{137} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 12385 } },
        },

        [ 593] = { -- Conflict: Castle Zvahl Baileys [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{138} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 15539 } },
        },

        [ 595] = { -- Conflict: Castle Zvahl Keep [S]
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{155} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 15780 } },
        },

      -----------------------------------
      -- Combat (Region) - Abyssea 1
      -----------------------------------

        [ 613] = { -- Conflict: Abyssea - La Theine
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{132} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 10914 } },
        },

        [ 614] = { -- Conflict: Abyssea - Konschtat
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{15} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 15891 } },
        },

        [ 615] = { -- Conflict: Abyssea - Tahrongi
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{45} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 11765 } },
        },

        [ 616] = { -- Conflict: Abyssea - Attohwa
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{215} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 11763 } },
        },

        [ 617] = { -- Conflict: Abyssea - Misareaux
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{216} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 10966 } },
        },

        [ 618] = { -- Conflict: Abyssea - Vunkerl
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{217} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 10964 } },
        },

        [ 619] = { -- Conflict: Abyssea - Altepa
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{218} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 10968 } },
        },

        [ 620] = { -- Conflict: Abyssea - Uleguerand
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{253} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 11664 } },
        },

        [ 621] = { -- Conflict: Abyssea - Grauberg
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { zone = set{254} },
            flags = set{"repeat"},
            reward = { sparks = 80, xp = 900, accolades = 8, item = { 11644 } },
        },

      -----------------------------------
      -- Combat (Region) - Escha 1
      -----------------------------------

      -----------------------------------
      -- Combat (Region) - Escha 2
      -----------------------------------

      -----------------------------------
      -- Harvesting - Original Areas
      -----------------------------------

        [ 180] = { -- Harvesting: East Ronfaure
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{101} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 181] = { -- Harvesting: Ghelsba Outpost
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{140} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 182] = { -- Harvesting: Gusgen Mines
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{196} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 183] = { -- Harvesting: Jugner Forest
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{104} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 184] = { -- Harvesting: Zeruhn Mines
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{172} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 185] = { -- Harvesting: Palborough Mines
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{143} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 186] = { -- Harvesting: West Sarutabaruta
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{115} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 187] = { -- Harvesting: Giddeus
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{145} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 188] = { -- Harvesting: Buburimu Peninsula
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{118} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 189] = { -- Harvesting: Tahrongi Canyon
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{117} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 190] = { -- Harvesting: Maze of Shakhrami
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{198} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 389] = { -- Harvesting: Yughott Grotto
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{142} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

      -----------------------------------
      -- Harvesting - Adoulin 1
      -----------------------------------

      -----------------------------------
      -- Harvesting - Zilart
      -----------------------------------

        [ 478] = { -- Harvesting: Yuhtunga Jungle
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{123} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 479] = { -- Harvesting: Yhoator Jungle
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{124} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 480] = { -- Harvesting: Ifrit's Cauldron
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{205} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 485] = { -- Harvesting: Korroloka Tunnel
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{173} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

      -----------------------------------
      -- Harvesting - Promathia
      -----------------------------------

        [ 481] = { -- Harvesting: Oldton Movalpolos
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{11} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 482] = { -- Harvesting: Newton Movalpolos
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{12} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 483] = { -- Harvesting: Lufaise Meadows
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{24} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 484] = { -- Harvesting: Misareaux Coast
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{25} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 486] = { -- Harvesting: Carpenters' Landing
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{2} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 487] = { -- Harvesting: Attohwa Chasm
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{7} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

      -----------------------------------
      -- Harvesting - Aht Urhgan
      -----------------------------------

        [ 599] = { -- Harvesting: Bhaflau Thickets
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{52} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 600] = { -- Harvesting: Mamook
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{65} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 601] = { -- Harvesting: Wajaom Woodlands
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{51} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 602] = { -- Harvesting: Halvung
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{62} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 603] = { -- Harvesting: Mount Zhayolm
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{61} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 604] = { -- Harvesting: Caedarva Mire
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{79} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

      -----------------------------------
      -- Harvesting - Goddess
      -----------------------------------

        [ 606] = { -- Harvesting: East Ronfaure [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{81} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 607] = { -- Harvesting: Jugner Forest [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{82} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

        [ 608] = { -- Harvesting: North Gustaberg [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{88} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {605, 12} } },
        },

        [ 609] = { -- Harvesting: Grauberg [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{89} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 610] = { -- Harvesting: West Sarutabaruta [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{95} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1020, 12} } },
        },

        [ 611] = { -- Harvesting: Fort Karugo-Narugo [S]
            trigger = triggers.helmSuccess,
            goal = 5,
            reqs = { zone = set{96} },
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10, item = { {1021, 12} } },
        },

      -----------------------------------
      -- Content (Other)                 
      -----------------------------------

        [  63] = { -- Total Suc. Chocobo Digs
            trigger = triggers.chocoboDigSuccess,
            goal = 30,
            flags = set{"repeat"},
            reward = { sparks = 100, xp = 500, accolades = 10 },
        },

        [ 727] = { -- Subjugation: Kirin
            trigger = triggers.mobKill,
            reqs = { mobID = set{17506670} },
            flags = set{"repeat"},
            reward = { sparks = 1000, xp = 5000, accolades = 100, item = { 8711 } },
        },

        [ 728] = { -- Subjugation: Genbu
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309980} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 30 },
        },

        [ 729] = { -- Subjugation: Suzaku
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309983} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 30 },
        },

        [ 730] = { -- Subjugation: Seiryu
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309981} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 30 },
        },

        [ 731] = { -- Subjugation: Byakko
            trigger = triggers.mobKill,
            reqs = { mobID = set{17309982} },
            flags = set{"repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 30 },
        },

      -----------------------------------
      -- Achievements - Job Levels 1             
      -----------------------------------

        [1200] = { -- Level 30 Warrior +
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WAR, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6152, 12} } },
        },

        [1201] = { -- Level 50 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WAR, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6151, 12} } },
        },

        [1202] = { -- Level 75 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WAR, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3190, 4} } },
        },

        [1203] = { -- Level 99 Warrior
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WAR, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1204] = { -- Level 30 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.MNK, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6147, 12} } },
        },

        [1205] = { -- Level 50 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.MNK, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1206] = { -- Level 75 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.MNK, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3191, 4} } },
        },

        [1207] = { -- Level 99 Monk
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.MNK, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1208] = { -- Level 30 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WHM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6167, 12} } },
        },

        [1209] = { -- Level 50 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WHM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6166, 12} } },
        },

        [1210] = { -- Level 75 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WHM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3192, 4} } },
        },

        [1211] = { -- Level 99 White Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.WHM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1212] = { -- Level 30 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6170, 12} } },
        },

        [1213] = { -- Level 50 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6171, 12} } },
        },

        [1214] = { -- Level 75 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3193, 4} } },
        },

        [1215] = { -- Level 99 Black Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1216] = { -- Level 30 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RDM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6169, 12} } },
        },

        [1217] = { -- Level 50 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RDM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6168, 12} } },
        },

        [1218] = { -- Level 75 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RDM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3194, 4} } },
        },

        [1219] = { -- Level 99 Red Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RDM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1220] = { -- Level 30 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.THF, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1221] = { -- Level 50 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.THF, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6149, 12} } },
        },

        [1222] = { -- Level 75 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.THF, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3195, 4} } },
        },

        [1223] = { -- Level 99 Thief
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.THF, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4069, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 2             
      -----------------------------------

        [1224] = { -- Level 30 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PLD, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6149, 12} } },
        },

        [1225] = { -- Level 50 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PLD, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6164, 12} } },
        },

        [1226] = { -- Level 75 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PLD, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3196, 4} } },
        },

        [1227] = { -- Level 99 Paladin
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PLD, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1228] = { -- Level 30 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRK, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6153, 12} } },
        },

        [1229] = { -- Level 50 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRK, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6150, 12} } },
        },

        [1230] = { -- Level 75 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRK, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3197, 4} } },
        },

        [1231] = { -- Level 99 Dark Knight
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRK, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1232] = { -- Level 30 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BST, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6151, 12} } },
        },

        [1233] = { -- Level 50 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BST, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6153, 12} } },
        },

        [1234] = { -- Level 75 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BST, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3198, 4} } },
        },

        [1235] = { -- Level 99 Beastmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BST, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1236] = { -- Level 30 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BRD, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6172, 12} } },
        },

        [1237] = { -- Level 50 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BRD, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6173, 12} } },
        },

        [1238] = { -- Level 75 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BRD, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3199, 4} } },
        },

        [1239] = { -- Level 99 Bard
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BRD, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1240] = { -- Level 30 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RNG, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6159, 12} } },
        },

        [1241] = { -- Level 50 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RNG, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6160, 12} } },
        },

        [1242] = { -- Level 75 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RNG, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3200, 4} } },
        },

        [1243] = { -- Level 99 Ranger
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RNG, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1244] = { -- Level 30 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SAM, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6156, 12} } },
        },

        [1245] = { -- Level 50 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SAM, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6154, 12} } },
        },

        [1246] = { -- Level 75 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SAM, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3201, 4} } },
        },

        [1247] = { -- Level 99 Samurai
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SAM, 99 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {4065, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 3             
      -----------------------------------

        [1248] = { -- Level 30 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.NIN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6155, 12} } },
        },

        [1249] = { -- Level 50 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.NIN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6175, 12} } },
        },

        [1250] = { -- Level 75 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.NIN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3202, 4} } },
        },

        [1251] = { -- Level 99 Ninja
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.NIN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

        [1252] = { -- Level 30 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRG, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6154, 12} } },
        },

        [1253] = { -- Level 50 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRG, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1254] = { -- Level 75 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRG, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3203, 4} } },
        },

        [1255] = { -- Level 99 Dragoon
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DRG, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1256] = { -- Level 30 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SMN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6176, 12} } },
        },

        [1257] = { -- Level 50 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SMN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6158, 12} } },
        },

        [1258] = { -- Level 75 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SMN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3204, 4} } },
        },

        [1259] = { -- Level 99 Summoner
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SMN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1260] = { -- Level 30 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLU, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6149, 12} } },
        },

        [1261] = { -- Level 50 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLU, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6177, 12} } },
        },

        [1262] = { -- Level 75 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLU, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3205, 4} } },
        },

        [1263] = { -- Level 99 Blue Mage
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.BLU, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4064, 2} } },
        },

        [1264] = { -- Level 30 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.COR, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1265] = { -- Level 50 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.COR, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6160, 12} } },
        },

        [1266] = { -- Level 75 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.COR, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3206, 4} } },
        },

        [1267] = { -- Level 99 Corsair
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.COR, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4065, 2} } },
        },

        [1268] = { -- Level 30 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PUP, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6147, 12} } },
        },

        [1269] = { -- Level 50 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PUP, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6148, 12} } },
        },

        [1270] = { -- Level 75 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PUP, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3207, 4} } },
        },

        [1271] = { -- Level 99 Puppetmaster
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.PUP, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4066, 2} } },
        },

      -----------------------------------
      -- Achievements - Job Levels 4             
      -----------------------------------

        [1272] = { -- Level 30 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DNC, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6148, 12} } },
        },

        [1273] = { -- Level 50 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DNC, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6147, 12} } },
        },

        [1274] = { -- Level 75 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DNC, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3208, 4} } },
        },

        [1275] = { -- Level 99 Dancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.DNC, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4067, 2} } },
        },

        [1276] = { -- Level 30 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SCH, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6158, 12} } },
        },

        [1277] = { -- Level 50 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SCH, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6157, 12} } },
        },

        [1278] = { -- Level 75 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SCH, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {3209, 4} } },
        },

        [1279] = { -- Level 99 Scholar
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.SCH, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4068, 2} } },
        },

        [1280] = { -- Level 30 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.GEO, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6178, 12} } },
        },

        [1281] = { -- Level 50 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.GEO, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6179, 12} } },
        },

        [1282] = { -- Level 75 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.GEO, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {6092, 1} } },
        },

        [1283] = { -- Level 99 Geomancer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.GEO, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4069, 1} } },
        },

        [1284] = { -- Level 30 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RUN, 30 } },
            flags = set{"retro"},
            reward = { sparks = 100, xp = 500, item = { {6150, 12} } },
        },

        [1285] = { -- Level 50 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RUN, 50 } },
            flags = set{"retro"},
            reward = { sparks = 200, xp = 500, item = { {6149, 12} } },
        },

        [1286] = { -- Level 75 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RUN, 75 } },
            flags = set{"retro"},
            reward = { sparks = 300, xp = 500, item = { {5103, 1} } },
        },

        [1287] = { -- Level 99 Runefencer
            trigger = triggers.levelUp,
            reqs = { jobLvl = { xi.job.RUN, 99 } },
            flags = set{"retro"},
            reward = { sparks = 400, xp = 500, item = { {4070, 1} } },
        },

      -----------------------------------
      -- Unity - Shared A
      -----------------------------------

        [3000] = { -- Unity Communique A (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3002] = { -- Vanquish Multiple Enemies A (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3003] = {   -- Vanquish Aquans A (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.AQUAN} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3004] = {  -- Vanquish Amorphs with Physical Damage A (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.AMORPH} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3005] = {   -- Vanquish Beasts with Magic A (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.BEAST} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3006] = { -- Total Successful Woodworking Syntheses A (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.WOODWORKING },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3007] = { -- Total Successful Leatherworking Syntheses A (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.LEATHERCRAFT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3008] = { -- Total Suc. Mining Attempts A (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 4 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity - Shared B
      -----------------------------------

        [3009] = { -- Unity Communique B (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3010] = { -- Chocobo Digging B (UC)
            trigger = triggers.chocoboDigSuccess,
            goal = 10,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3011] = { -- Vanquish Multiple Enemies B (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3012] = {   -- Vanquish Arcana B (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.ARCANA} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3013] = {  -- Vanquish Undead with Physical Damage B (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.UNDEAD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3014] = {   -- Vanquish Plantoids with Magic B (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.PLANTOID} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3015] = { -- Total Successful Blacksmithing Syntheses B (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.SMITHING },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3017] = { -- Total Suc. Logging Attempts B (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 3 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity - Shared C
      -----------------------------------

        [3018] = { -- Unity Communique C (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3020] = { -- Vanquish Multiple Enemies C (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3021] = {   -- Vanquish Vermin C (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.VERMIN} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3022] = {  -- Vanquish Birds with Physical Damage C (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.BIRD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3023] = {   -- Vanquish Lizards with Magic C (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.LIZARD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3024] = { -- Total Successful Goldsmithing Syntheses C (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.GOLDSMITHING },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3026] = { -- Total Suc. Harvesting Attempts C (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 1 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity - Shared D
      -----------------------------------

        [3027] = { -- Unity Communique D (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3029] = { -- Vanquish Multiple Enemies D (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3030] = {   -- Vanquish Beasts D (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.BEAST} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3031] = {  -- Vanquish Aquans with Physical Damage D (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.AQUAN} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3032] = {   -- Vanquish Amorphs with Magic D (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.AMORPH} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3033] = { -- Total Successful Cloth Syntheses D (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.CLOTHCRAFT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3034] = { -- Total Successful Bone Syntheses D (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.BONECRAFT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3035] = { -- Total Suc. Mining Attempts D (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 4 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity - Shared E
      -----------------------------------

        [3036] = { -- Unity Communique E (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3038] = { -- Vanquish Multiple Enemies E (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3039] = {   -- Vanquish Plantoids E (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.PLANTOID} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3040] = {  -- Vanquish Arcana with Physical Damage E (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.ARCANA} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3041] = {   -- Vanquish Undead with Magic E (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.UNDEAD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3042] = { -- Total Successful Cooking Syntheses E (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.COOKING },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3044] = { -- Total Suc. Logging Attempts E (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 3 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity - Shared F
      -----------------------------------

        [3045] = { -- Unity Communique F (UC)
            trigger = triggers.unityChat,
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 100 },
        },

        [3046] = { -- Level Sync to Vanquish Enemies F (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true , levelSync = true},
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500 , accolades = 100 },
        },

        [3047] = { -- Vanquish Multiple Enemies F (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3048] = {   -- Vanquish Lizards F (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.LIZARD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3049] = {  -- Vanquish Vermin with Physical Damage F (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL, mobSystem = set{xi.eco.VERMIN} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 400 },
        },

        [3050] = {   -- Vanquish Birds with Magic F (UC)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL, mobSystem = set{xi.eco.BIRD} },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3051] = { -- Total Successful Alchemy Syntheses F (UC)
            trigger = triggers.synthSuccess,
            goal = 10,
            reqs = { skillType = xi.skill.ALCHEMY },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3053] = { -- Total Suc. Harvesting Attempts F (UC)
            trigger = triggers.helmSuccess,
            goal = 10,
            reqs = { skillType = 1 },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

      -----------------------------------
      -- Unity Leader - Pieuje - Week 0
      -----------------------------------

        -- TODO: Assign a Unity Leader requirement to these
        [3488] = { -- Club Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.CLUB, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3489] = { -- Conflict: Rala Waterways (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{258}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3490] = { -- Vanquish Rabbits (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{206}, mobXP = true, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3491] = { -- Subjugation: Rambukk (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17191044}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3492] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Pieuje - Week 1
      -----------------------------------

        [3493] = { -- Spoils - Bat Fangs (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 891 }, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3494] = { -- Conflict: La Theine Plateau (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{102}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3495] = { -- Vanquish Bats (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{46, 47}, mobXP = true, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3496] = { -- Subjugation: Tumbling Truffle (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17195259}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Pieuje - Week 2
      -----------------------------------

        [3498] = { -- Staff Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.STAFF, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3499] = { -- Conflict: Eldieme Necropolis (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{195}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3500] = { -- Vanquish Treants (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{245}, mobXP = true, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3501] = { -- Subjugation: Duke Decapod (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17252725}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3502] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Pieuje - Week 3
      -----------------------------------

        [3503] = { -- Spoils - Bomb Ash (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 928 }, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3504] = { -- Conflict: Davoi (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{149}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3505] = { -- Vanquish Bombs (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{56}, mobXP = true, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3506] = { -- Subjugation: Poisonhand Gnadgad (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17387644}, unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3507] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.PIEUJE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Ayame - Week 0
      -----------------------------------

        [3508] = { -- Great Katana Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.GREAT_KATANA, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3509] = { -- Conflict: North Gustaberg (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{106}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3510] = { -- Vanquish Worms (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{258}, mobXP = true, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3511] = { -- Subjugation: Stinging Sophie (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17211537, 17211561}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3512] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Ayame - Week 1
      -----------------------------------

        [3513] = { -- Spoils - Cockatrice Meat (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 4435 }, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3514] = { -- Conflict: Yahse Hunting Grounds (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{260}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3515] = { -- Vanquish Cockatrices (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{70}, mobXP = true, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3516] = { -- Subjugation: Tococo (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17215778}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Ayame - Week 2
      -----------------------------------

        [3518] = { -- Archery Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.ARCHERY, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3519] = { -- Conflict: Crawlers' Nest (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{197}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3520] = { -- Vanquish Lizards (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{174}, mobXP = true, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3521] = { -- Subjugation: Aqrabuamelu (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17584416}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3522] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Ayame - Week 3
      -----------------------------------

        [3523] = { -- Spoils - Land Crab Meat (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 4400 }, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3524] = { -- Conflict: Beadeaux (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{147}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3525] = { -- Vanquish Crabs (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{75, 76, 77, 372}, mobXP = true, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3526] = { -- Subjugation: Ge'Dha Evileye (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17379450}, unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3527] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 5,
            reqs = { unityLeader = xi.roe.leaders.AYAME },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Invincible Shield - Week 0
      -----------------------------------

        [3528] = { -- Axe Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.AXE, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3529] = { -- Conflict: South Gustaberg (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{107}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3530] = { -- Vanquish Sea Monks (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{218, 219}, mobXP = true, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3531] = { -- Subjugation: Leaping Lizzy (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17215868, 17215888}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3532] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Invincible Shield - Week 1
      -----------------------------------

        [3533] = { -- Spoils - Sleepshroom (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 4374 }, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3534] = { -- Conflict: Pashhow Marshlands (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{109}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3535] = { -- Vanquish Funguars (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{116}, mobXP = true, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3536] = { -- Subjugation: Bloodpool Vorax (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17224019}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Invincible Shield - Week 2
      -----------------------------------

        [3538] = { -- Great Axe Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.GREAT_AXE, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3539] = { -- Conflict: Ceizak Battlegrounds (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{261}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3540] = { -- Vanquish Flies (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{113, 374}, mobXP = true, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3541] = { -- Subjugation: Be'Hya Hundredwall (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17363258}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3542] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Invincible Shield - Week 3
      -----------------------------------

        [3543] = { -- Spoils - Raptor Skin (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 853 }, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3544] = { -- Conflict: Beaucedine Glacier (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{111}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3545] = { -- Vanquish Raptors (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{210, 376, 377}, mobXP = true, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3546] = { -- Subjugation: Gargantua (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17232079}, unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3547] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 5,
            reqs = { unityLeader = xi.roe.leaders.INVINCIBLE_SHIELD },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Apururu - Week 0
      -----------------------------------

        [3548] = { -- Club Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.CLUB, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3549] = { -- Conflict: West Sarutabaruta (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{115}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3550] = { -- Vanquish Bees (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{48}, mobXP = true, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3551] = { -- Subjugation: Tom Tit Tat (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17248468, 17248486}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3552] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Apururu - Week 1
      -----------------------------------

        [3553] = { -- Spoils - Silk Thread (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 816 }, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3554] = { -- Conflict: Buburimu Peninsula (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{118}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3555] = { -- Vanquish Crawlers (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{79}, mobXP = true, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3556] = { -- Subjugation: Buburimboo (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17261003}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Apururu - Week 2
      -----------------------------------

        [3558] = { -- Staff Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.STAFF, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3559] = { -- Conflict: Castle Oztroja (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{151}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3560] = { -- Vanquish Ghosts (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{121}, mobXP = true, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3561] = { -- Subjugation: Mee Deggi the Punisher (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17395800}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3562] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Apururu - Week 3
      -----------------------------------

        [3563] = { -- Spoils - Saruta Cotton (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 834 }, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3564] = { -- Conflict: Foret de Hennetiel (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{262}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3565] = { -- Vanquish Mandragoras (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{178}, mobXP = true, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3566] = { -- Subjugation: Juu Duzu the Whirlwind (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17371300}, unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3567] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.APURURU },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Maat - Week 0
      -----------------------------------

        [3568] = { -- Hand-to-Hand Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.HAND_TO_HAND, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3569] = { -- Conflict: Yorcia Weald (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{263}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3570] = { -- Vanquish Leeches (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{172, 369}, mobXP = true, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3571] = { -- Subjugation: Canal Moocher (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17469578}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3572] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Maat - Week 1
      -----------------------------------

        [3573] = { -- Spoils - Spider Web (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 838 }, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3574] = { -- Conflict: Rolanberry Fields (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{110}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3575] = { -- Vanquish Spiders (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{235}, mobXP = true, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3576] = { -- Subjugation: Eldritch Edge (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17228150}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Maat - Week 2
      -----------------------------------

        [3578] = { -- Great Sword Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.GREAT_SWORD, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3579] = { -- Conflict: Meriphataud Mountains (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{119}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3580] = { -- Vanquish Wyverns (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{266, 268}, mobXP = true, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3581] = { -- Subjugation: Patripatan (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17264972}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3582] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Maat - Week 3
      -----------------------------------

        [3583] = { -- Spoils - Hecteyes Eye (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 939 }, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3584] = { -- Conflict: Sauromugue Champaign (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{120}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3585] = { -- Vanquish Hecteyes (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{139}, mobXP = true, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3586] = { -- Subjugation: Bashe (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17268788}, unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3587] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.MAAT },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Aldo - Week 0
      -----------------------------------

        [3588] = { -- Dagger Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.DAGGER, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3589] = { -- Conflict: Sanctuary of Zi'Tah (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{121}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3590] = { -- Vanquish Hounds (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{142, 143}, mobXP = true, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3591] = { -- Subjugation: Bastet (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17273190}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3592] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Aldo - Week 1
      -----------------------------------

        [3593] = { -- Spoils - Doll Shard (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 1165 }, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3594] = { -- Conflict: Morimar Basalt Fields (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{265}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3595] = { -- Vanquish Dolls (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{83, 84, 85, 498}, mobXP = true, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3596] = { -- Subjugation: Nocuous Weapon (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17563801}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Aldo - Week 2
      -----------------------------------

        [3598] = { -- Marksmanship Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.MARKSMANSHIP, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3599] = { -- Conflict: Boyahda Tree (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{153}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3600] = { -- Vanquish Slimes (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{228, 229, 230}, mobXP = true, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3601] = { -- Subjugation: Aquarius (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17404000}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3602] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Aldo - Week 3
      -----------------------------------

        [3603] = { -- Spoils - Bird Egg (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 4570 }, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3604] = { -- Conflict: Western Altepa Desert (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{125}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3605] = { -- Vanquish Crow-Type Birds (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{55}, mobXP = true, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3606] = { -- Subjugation: Cactuar Cantautor (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17289560}, unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3607] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.ALDO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Jakoh Wahcondalo - Week 0
      -----------------------------------

        [3608] = { -- Dagger Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.DAGGER, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3609] = { -- Conflict: Yuhtunga Jungle (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{123}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3610] = { -- Vanquish Sheep (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{226}, mobXP = true, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3611] = { -- Subjugation: Mischievous Micholas (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17281149}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3612] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Jakoh Wahcondalo - Week 1
      -----------------------------------

        [3613] = { -- Spoils - Scorpion Claw (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 897 }, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3614] = { -- Conflict: East Sarutabaruta (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{116}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3615] = { -- Vanquish Scorpions (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{217}, mobXP = true, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3616] = { -- Subjugation: Sharp-Eared Ropipi (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17252489, 17252508}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Jakoh Wahcondalo - Week 2
      -----------------------------------

        [3618] = { -- Archery Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.ARCHERY, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3619] = { -- Conflict: Marjami Ravine (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{266}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3620] = { -- Vanquish Opo-Opos (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{188}, mobXP = true, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3621] = { -- Subjugation: Ah Puch (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17571903}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3622] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Jakoh Wahcondalo - Week 3
      -----------------------------------

        [3623] = { -- Spoils - Black Tiger Fang (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 884 }, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3624] = { -- Conflict: Sea Serpent Grotto (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{176}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3625] = { -- Vanquish Tigers (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{242}, mobXP = true, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3626] = { -- Subjugation: Fyuu the Seabellow (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17498269}, unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3627] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.JAKOH_WAHCONDALO },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Naja Salaheem - Week 0
      -----------------------------------

        [3628] = { -- Club Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.CLUB, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3629] = { -- Conflict: Bhaflau Thickets (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{52}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3630] = { -- Vanquish Evil Weapons (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{110}, mobXP = true, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3631] = { -- Subjugation: Emergent Elm (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{16990376}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3632] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Naja Salaheem - Week 1
      -----------------------------------

        [3633] = { -- Spoils - Puk Wing (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 2148 }, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3634] = { -- Conflict: West Ronfaure (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{100}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3635] = { -- Vanquish Puks (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{198}, mobXP = true, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3636] = { -- Subjugation: Fungus Beetle (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17187047}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Naja Salaheem - Week 2
      -----------------------------------

        [3638] = { -- Staff Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.STAFF, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3639] = { -- Conflict: Wajaom Woodlands (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{51}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3640] = { -- Vanquish Elementals (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{99, 100, 101, 102, 103, 104, 105, 106}, mobXP = true, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3641] = { -- Subjugation: Jaded Jody (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{16986378}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3642] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Naja Salaheem - Week 3
      -----------------------------------

        [3643] = { -- Spoils - Dhalmel Meat (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 4359 }, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3644] = { -- Conflict: Kamihr Drifts (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{267}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3645] = { -- Vanquish Dhalmel (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{80}, mobXP = true, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3646] = { -- Subjugation: Trembler Tabitha (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17588278}, unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3647] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 5,
            reqs = { unityLeader = xi.roe.leaders.NAJA_SALAHEEM },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Flaviria - Week 0
      -----------------------------------

        [3648] = { -- Polearm Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.POLEARM, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3649] = { -- Conflict: Cirdas Caverns (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{270}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3650] = { -- Vanquish Pugils (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{197}, mobXP = true, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3651] = { -- Subjugation: Hovering Hotpot (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17596628}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3652] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Flaviria - Week 1
      -----------------------------------

        [3653] = { -- Spoils - Beetle Shell (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 889 }, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3654] = { -- Conflict: East Ronfaure (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{101}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3655] = { -- Vanquish Beetles (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{49}, mobXP = true, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3656] = { -- Subjugation: Bigmouth Billy (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17191196}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Flaviria - Week 2
      -----------------------------------

        [3658] = { -- Sword Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.SWORD, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3659] = { -- Conflict: Xarcabard (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{112}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3660] = { -- Vanquish Goobbues (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{136}, mobXP = true, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3661] = { -- Subjugation: Barbaric Weapon (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17236027}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3662] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Flaviria - Week 3
      -----------------------------------

        [3663] = { -- Spoils - Bone Chip (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 880 }, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3664] = { -- Conflict: Woh Gates (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{273}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3665] = { -- Vanquish Skeletons (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{227}, mobXP = true, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3666] = { -- Subjugation: Hyakume (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17457236}, unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3667] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.FLAVIRIA },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Yoran-Oran - Week 0
      -----------------------------------

        [3668] = { -- Club Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.CLUB, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3669] = { -- Conflict: Giddeus (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{145}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3670] = { -- Vanquish Efts (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{98}, mobXP = true, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3671] = { -- Subjugation: Herbage Hunter (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17256836}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3672] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Yoran-Oran - Week 1
      -----------------------------------

        [3673] = { -- Spoils - Rotten Meat (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 16995 }, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3674] = { -- Conflict: Moh Gates (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{269}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3675] = { -- Vanquish Antica (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{25}, mobXP = true, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3676] = { -- Subjugation: Antican Praefectus (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17629281}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Yoran-Oran - Week 2
      -----------------------------------

        [3678] = { -- Staff Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.STAFF, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3679] = { -- Conflict: Toraimarai Canal (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{169}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3680] = { -- Vanquish Coeurls (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{71}, mobXP = true, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3681] = { -- Subjugation: Ose (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17649822}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3682] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Yoran-Oran - Week 3
      -----------------------------------

        [3683] = { -- Spoils - Dullahan Armor (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 8746 }, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3684] = { -- Conflict: Outer Ra'Kaznar (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{274}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3685] = { -- Vanquish Dullahan (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{447}, mobXP = true, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3686] = { -- Subjugation: Capricious Cassie (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17613130}, unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3687] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.YORAN_ORAN },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Sylvie - Week 0
      -----------------------------------

        [3688] = { -- Club Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.CLUB, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3689] = { -- Conflict: Sih Gates (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{268}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

--[[
        [3690] = { -- Vanquish Acuex (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{???}, mobXP = true, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },
--]]

        [3691] = { -- Subjugation: Intulo (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{16793742}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3692] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Sylvie - Week 1
      -----------------------------------

        [3693] = { -- Spoils - Demon Horn (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 902 }, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3694] = { -- Conflict: Konschtat Highlands (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{108}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3695] = { -- Vanquish Demons (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobSystem = set{xi.eco.DEMON}, mobXP = true, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3696] = { -- Subjugation: Marquis Naberius (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17436876}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

      -----------------------------------
      -- Unity Leader - Sylvie - Week 2
      -----------------------------------

        [3698] = { -- Staff Weapon Skills (UC)
            trigger = triggers.wSkillUse,
            goal = 30,
            reqs = { skillType = xi.skill.STAFF, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3699] = { -- Conflict: Dho Gates (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{272}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3700] = { -- Vanquish Velkk (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{342}, mobXP = true, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3701] = { -- Subjugation: Dune Widow (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17244396}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3702] = { -- Heal Unity Allies (UC)
            trigger = triggers.healUnityAlly,
            goal = 30,
            reqs = { unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Unity Leader - Sylvie - Week 3
      -----------------------------------

        [3703] = { -- Spoils - Twitherym Wing (UC)
            trigger = triggers.itemLooted,
            goal = 5,
            reqs = { itemID = set{ 3930 }, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3704] = { -- Conflict: Qufim Island (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { zone = set{126}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 300 },
        },

        [3705] = { -- Vanquish Twitherym (UC)
            trigger = triggers.mobKill,
            goal = 10,
            reqs = { mobFamily = set{338}, mobXP = true, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

        [3706] = { -- Subjugation: Atkorkamuy (UC)
            trigger = triggers.mobKill,
            reqs = { mobID = set{17293485}, unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 1000 },
        },

        [3707] = { -- Magic Bursts (UC)
            trigger = triggers.magicBurst,
            goal = 10,
            reqs = { unityLeader = xi.roe.leaders.SYLVIE },
            flags = set{"unity"},
            reward = { sparks = 100, xp = 500, accolades = 500 },
        },

      -----------------------------------
      -- Vana'versary - 15th Vana'versary I
      -----------------------------------

        [3367] = { -- Signet, brb (W)
            flags = set{"weekly"},
            reward = { sparks = 50, xp = 1115 },
        },

      -----------------------------------
      -- Other - Daily Objectives
      -----------------------------------

        [4082] = { -- Vanquish Multiple Enemies (D)
            trigger = triggers.mobKill,
            goal = 30,
            reqs = { mobXP = true },
            flags = set{"daily"},
            reward = { sparks = 100, xp = 500, accolades = 300, item = { 8711 } },
        },

        [4083] = { -- Buff Allies (D)
            trigger = triggers.buffAlly,
            goal = 20,
            flags = set{"daily"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4084] = { -- Heal for 500+ HP (D)
            trigger = triggers.healAlly,
            goal = 100,
            reqs = { healMin = 500 },
            flags = set{"daily"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },


      -----------------------------------
      -- Timed Records - No Category
      -----------------------------------

        [4008] = {   -- Vanquish Aquans
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.AQUAN} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4009] = {   -- Vanquish Beasts
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.BEAST} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4010] = {   -- Vanquish Plantoids
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.PLANTOID} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4011] = {   -- Vanquish Lizards
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.LIZARD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4012] = {   -- Vanquish Vermin
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.VERMIN} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4013] = { -- Gain Experience
            trigger = triggers.expGain,
            goal = 5000,
            increment = 0,
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
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
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4015] = {   -- Vanquish Birds (TODO: No abyssea zone kills for vanquishes when exists)
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.BIRD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4016] = {   -- Vanquish Amorphs
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.AMORPH} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4017] = {   -- Vanquish Undead
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.UNDEAD} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4018] = {   -- Vanquish Arcana
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, mobSystem = set{xi.eco.ARCANA} },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4019] = {   -- Crack Treasure Caskets (Triggered from caskets.lua)
            goal = 10,
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4020] = {  -- Physical Damage Kills
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.PHYSICAL },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

        [4021] = {  -- Magic Damage Kills
            trigger = triggers.mobKill,
            goal = 20,
            reqs = { mobXP = true, atkType = xi.attackType.MAGICAL },
            flags = set{"timed", "repeat"},
            reward = { sparks = 300, xp = 1500, accolades = 300, item = { 8711 } },
        },

      -----------------------------------
      -- Hidden Gates - No Category
      -----------------------------------

        [4085] = { -- 10 RoE Objectives Complete (All for One requirement)
        },
    }
end
