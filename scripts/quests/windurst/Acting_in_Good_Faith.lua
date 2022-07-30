-----------------------------------
-- Acting in Good Faith
-----------------------------------
-- !addquest 2 64
-- Gantineaux : !pos
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
local ID = require("scripts/zones/The_Eldieme_Necropolis/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ACTING_IN_GOOD_FAITH)

quest.reward =
{
    item = xi.items.SCROLL_OF_TELEPORT_MEA,
    fame = 30,
    fameArea = xi.quest.fame_area.WINDURST,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                   player:getFameLevel(xi.quest.fame_area.WINDURST) >= 4 and
                   player:getMainLvl() >= 10
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Gantineaux'] = quest:progressEvent(10019),

            onEventFinish =
            {
                [10019] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SPIRIT_INCENSE)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.WINDURST_WATERS] =
        {
            ['Gantineaux'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SPIRIT_INCENSE) then
                        return quest:progressEvent(10020)
                    elseif player:hasKeyItem(xi.ki.GANTINEUXS_LETTER) then
                        return quest:progressEvent(10022)
                    else
                        return quest:progressEvent(10021)
                    end
                end,
            },

            onEventFinish =
            {
                [10021] = function(player, csid, option, npc)
                    npcUtil.giveKeyIte(player, xi.ki.GANTINEUXS_LETTER)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.ki.SPIRIT_INCENSE) then
                        return quest:progressEvent(10020)
                    end
                end,
            },

            onEventFinish =
            {
                [10021] = function(player, csid, option, npc)
                    npcUtil.giveKeyIte(player, xi.ki.GANTINEUXS_LETTER)
                end,
            },
        },

        [xi.zone.THE_ELDIEME_NECROPOLIS] =
        {
            ['qm1'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SPIRIT_INCENSE) then
                        return quest:progressEvent(50)
                    end
                end,
            },

            onEventFinish =
            {
                [50] = function(player, csid, option, npc)
                    player:messageSpecial(ID.text.SPIRIT_INCENSE_EMITS_PUTRID_ODOR, xi.ki.SPIRIT_INCENSE)
                    player:delKeyItem(xi.ki.SPIRIT_INCENSE)
                end,
            },
        },
    },
}

return quest
