-----------------------------------
-- Gates to Paradise
-----------------------------------
-- !addquest 0 18
-- Olbergieut: !gotoid 17723418
-- Faurbellant !gotoid 17195617
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
local ID = require("scripts/zones/Northern_San_dOria/IDs")
local laTheineID = require("scripts/zones/La_Theine_Plateau/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.GATES_TO_PARADISE)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.items.COTTON_CAPE,
    title = xi.title.THE_PIOUS_ONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Olbergieut'] = quest:progressEvent(619),

            onEventFinish =
            {
                [619] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WIND)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Olbergieut'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WATER) then
                        return quest:progressEvent(620)
                    elseif player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
                        return quest:messageSpecial(ID.text.OLBERGIEUT_DIALOG, xi.ki.SCRIPTURE_OF_WIND)
                    end
                end,
            },

            onEventFinish =
            {
                [620] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.SCRIPTURE_OF_WATER)
                    end
                end
            },
        },

        [xi.zone.LA_THEINE_PLATEAU] =
        {
            ['Faurbellant'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SCRIPTURE_OF_WIND) then
                        player:delKeyItem(xi.ki.SCRIPTURE_OF_WIND)
                        npcUtil.giveKeyItem(player, xi.ki.SCRIPTURE_OF_WATER)
                        return quest:messageSpecial(laTheineID.text.FAURBELLANT_2, 0, xi.ki.SCRIPTURE_OF_WIND)
                    elseif player:hasKeyItem(xi.ki.SCRIPTURE_OF_WATER) then
                        return quest:messageSpecial(laTheineID.text.FAURBELLANT_3, xi.ki.SCRIPTURE_OF_WATER)
                    end
                end,
            },
        },
    },

}

return quest
