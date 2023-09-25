-----------------------------------
-- Mithran Delicacies
-----------------------------------
-- Log ID: 4, Quest ID: 97
-- Anguenet: !pos 215.5699 -2.0176 -527.8190 2
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------
local carpentersID = require('scripts/zones/Carpenters_Landing/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.MITHRAN_DELICACIES)

quest.reward =
{
    item = xi.items.BLACKENED_SIREDON,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Anguenet'] = quest:progressEvent(21, 0, xi.items.MUDDY_SIREDON),

            onEventFinish =
            {
                [21] = function(player, csid, option, npc)
                    if option == 4 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Anguenet'] = quest:progressEvent(21, 0, xi.items.MUDDY_SIREDON),

            ['Lourdaude'] =
            {
                onTrade = function(player, npc, trade)
                    if player:getFreeSlotsCount() == 0 then
                        return quest:messageSpecial(carpentersID.text.FULL_INVENTORY_AFTER_TRADE, xi.items.BLACKENED_SIREDON)
                    elseif
                        npcUtil.tradeHasExactly(trade,  xi.items.MUDDY_SIREDON) and
                        quest:getVar(player, 'Status') == 0
                    then
                        return quest:progressEvent(24, 0, 0, 100)
                    elseif
                        npcUtil.tradeHasExactly(trade, { { "gil", 100 } }) and
                        quest:getVar(player, 'Status') == 1
                    then
                        return quest:progressEvent(25)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 1 then
                        return quest:progressEvent(22, 0, 0, 100)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 1)
                    player:confirmTrade()
                end,

                [25] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        quest:setVar(player, 'Status', 0)
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

        [xi.zone.CARPENTERS_LANDING] =
        {
            ['Lourdaude'] =
            {
                onTrade = function(player, npc, trade)
                    if player:getFreeSlotsCount() == 0 then
                        return quest:messageSpecial(carpentersID.text.FULL_INVENTORY_AFTER_TRADE, xi.items.BLACKENED_SIREDON)
                    elseif
                        npcUtil.tradeHasExactly(trade,  xi.items.MUDDY_SIREDON) and
                        quest:getVar(player, 'Status') == 0
                    then
                        return quest:progressEvent(24, 0, 0, 100)
                    elseif
                        npcUtil.tradeHasExactly(trade, { { "gil", 100 } }) and
                        quest:getVar(player, 'Status') == 1
                    then
                        return quest:progressEvent(25)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Status') == 1 then
                        return quest:progressEvent(22, 0, 0, 100)
                    end
                end,
            },

            onEventFinish =
            {
                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Status', 1)
                    player:confirmTrade()
                end,

                [25] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Status') == 1 then
                        quest:setVar(player, 'Status', 0)
                        player:confirmTrade()
                        npcUtil.giveItem(player, xi.items.BLACKENED_SIREDON)
                    end
                end,
            },
        },
    },
}

return quest
