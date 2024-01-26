-----------------------------------
-- Unexpected Treasure
-----------------------------------
-- Log ID: 0, Quest ID: 70
-- Morunaude: !gotoid 17723523
-- Calovour: !gotoid 17723524
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.UNEXPECTED_TREASURE)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    gil = 12000,

}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 4 and
                player:hasKeyItem(xi.ki.SMALL_TEACUP)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Morunaude'] = quest:progressEvent(635, 0, xi.ki.SMALL_TEACUP, xi.items.CUPBOARD),

            onEventFinish =
            {
                [635] = function(player, csid, option, npc)
                        quest:begin(player)
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
            ['Morunaude'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(636, 0, xi.ki.SMALL_TEACUP, xi.items.CUPBOARD)
                    end
                end,
            },

            ['Calovour'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.SPRIG_OF_MISTLETOE) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(639, 0, 0, 0, xi.items.SPRIG_OF_MISTLETOE)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(637, 0, xi.ki.SMALL_TEACUP, xi.items.CUPBOARD, xi.items.SPRIG_OF_MISTLETOE)
                    else
                        return quest:event(638, 0, 0, 0, xi.items.SPRIG_OF_MISTLETOE)
                    end
                end,
            },

            onEventFinish =
            {
                [637] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [639] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Calovour'] =
            {
                onTrigger = function(player, npc)
                    return quest:event(640):replaceDefault()
                end,
            },
        },
    },
}

return quest
