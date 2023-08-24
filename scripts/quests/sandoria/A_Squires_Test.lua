-----------------------------------
--  A Squires Test
--  NPC: Balasiel
--  !pos -136 -11 64 230
--  !addquest 0 10
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SQUIRE_S_TEST)

quest.reward =
{
    item     = xi.items.SPATHA,
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    title    = xi.title.KNIGHT_IN_TRAINING,

}

quest.sections =
{
    -- Section: Quest available.
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getMainLvl() >= 7
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Refuse') == 1 then
                        return quest:progressEvent(631)
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(616)
                    end
                end,
            },

            onEventFinish =
            {
                [616] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:setVar(player, 'Refuse', 1)
                    elseif option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [631] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        quest:setVar(player, 'Refuse', 0)
                        quest:setVar(player, 'Prog', 1)
                    end
                end,
            },
        },
    },

    -- Section: Quest accepted
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Balasiel'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:messageSpecial(ID.text.REVIVAL_TREE_ROOT, xi.items.REVIVAL_TREE_ROOT)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 1 and
                        npcUtil.tradeHasExactly(trade, xi.items.REVIVAL_TREE_ROOT)
                    then
                        return quest:progressEvent(617)
                    end
                end,
            },

            onEventFinish =
            {
                [617] = function(player, csid, option, npc)
                    quest:complete(player)
                    player:tradeComplete()
                end,
            },
        },
    },
}

return quest
