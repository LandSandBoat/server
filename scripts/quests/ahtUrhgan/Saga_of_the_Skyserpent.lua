-----------------------------------
-- Saga of the Skyserpent
-- Fari-Wadi : !pos 80.453 -6.000 -137.707 50
-- qm7       : !pos -11.610 7.935 -185.469 62
-- Biyaada   : !pos -65.802 -5.999 69.273 48
-----------------------------------
require("scripts/globals/besieged")
require("scripts/globals/items")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require('scripts/globals/interaction/quest')
require("scripts/globals/zone")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.AHT_URHGAN, 100)

-- Rewards
-- Imperial Gold Piece
-- Imperial Standing (1000)
-- Title Granted	Skyserpent Aggrandizer

quest.sections = {

    -- Talk to Fari-Wari in Aht Urhgan Whitegate to start quest (K-12).
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and xi.besieged.isRughadjeenInAlZahbi()
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Fari-Wari'] = {
                onTrigger = function(player, npc)
                end,
            },

            onEventFinish = {
            },
        },
    },

    -- There is a ??? on the ground, just to your left after you pass through the gate. Click it to obtain the Lilac Ribbon Key Item.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.HALVUNG] = {
            ['qm7'] = {
                onTrigger = function(player, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LILAC_RIBBON)
                end,
            },
        },
    },

    -- Return to Fari-Wari for a story of a Besieged battle against the Mamool Ja and the Trolls two years ago.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Fari-Wari'] = {
                onTrigger = function(player, npc)
                end,
            },

            onEventFinish = {
            },
        },
    },

    -- Talk to Biyaada in Al Zahbi (G-7) (On top of NW bridge). She will tell you to wait for her at the Teahouse
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AL_ZAHBI] = {
            ['Biyaada'] = {
                onTrigger = function(player, npc)
                end,
            },

            onEventFinish = {
            },
        },
    },

    -- Return to Fari-Wari on the next game day (from the last time you spoke with him) for a cutscene and your reward.
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] = {
            ['Fari-Wari'] = {
                onTrigger = function(player, npc)
                end,
            },

            onEventFinish = {
            },
        },
    },
}


return quest
