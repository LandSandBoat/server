-----------------------------------
-- A Vicasques Sermon
-- !addquest 0 9
-- NPC: Abioleget !pos 128.771 0.000 118.538 231
-- NPC: Andelain !pos 664.231 -12.849 -539.413 101
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
local ronfaureID = require("scripts/zones/East_Ronfaure/IDs")

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_VICASQUE_S_SERMON)

quest.reward =
{
    fame = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item = xi.items.BRASS_RING,
    title = xi.title.THE_BENEVOLENT_ONE,
}

quest.sections =
{
    -- Speak to Abioleget after completing Waters of the Cheval
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATERS_OF_THE_CHEVAL) == QUEST_COMPLETED and
                player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 2
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abioleget'] =
            {
                onTrigger = function(player, npc)
                    return quest:progressEvent(589)
                end,
            },

            onEventFinish =
            {
                [589] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },

    -- Trade Blue peas to Andelain in East Ronfure
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abioleget'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(600)
                    elseif quest:getVar(player, 'Prog') == 0 then
                        return quest:messageSpecial(ID.text.ABIOLEGET_PEAS, xi.items.BLUE_PEAS, 70)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local gil = trade:getGil()
                    local count = trade:getItemCount()

                    if gil == 70 and count == 1 then
                        player:tradeComplete()
                        npcUtil.giveItem(player, xi.items.BLUE_PEAS)
                        return quest:event(591)
                    end
                end,
            },

            onEventFinish =
            {
                [600] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.EAST_RONFAURE] =
        {
            ['Andelain'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:messageSpecial(ronfaureID.text.NO_MORE_NO_LESS, xi.items.BLUE_PEAS)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:messageSpecial(ronfaureID.text.THANKS_TO_GODDESS)
                    else
                        return quest:messageSpecial(ronfaureID.text.NAME_IS_ANDELAIN)
                    end
                end,

                onTrade = function(player, npc, trade)
                    local count = trade:getItemCount()
                    local bluePeas = trade:getItemQty(618)
                    if
                        npcUtil.tradeHasExactly(trade, xi.items.BLUE_PEAS) and
                        quest:getVar(player, 'Prog') == 0
                    then
                        player:tradeComplete()
                        quest:setVar(player, 'Prog', 1)
                        player:showText(npc, ronfaureID.text.THANKS_TO_GODDESS)
                        return quest:event(19)
                    elseif bluePeas > 1 and count == bluePeas then
                        player:showText(npc, ronfaureID.text.ONLY_NEED_ONE, xi.items.BLUE_PEAS)
                    else
                        player:showText(npc, ronfaureID.text.CANNOT_ACCEPT_THIS)
                        return quest:event(19)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    player:showText(npc, ronfaureID.text.GATES_OF_PARADISE)
                end,
            },
        },
    },
}

return quest
