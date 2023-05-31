-----------------------------------
-- The Vicasque's Sermon
-----------------------------------
-- Log ID: 0, Quest ID: 9
-- Abioleget : !pos 128.771 0 118.538 231
-- Andelain  : !pos 664.231 -12.849 -539.413 101
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------
local eastRonfaureID     = require('scripts/zones/East_Ronfaure/IDs')
local northernSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_VICASQUES_SERMON)

quest.reward =
{
    fame     = 30,
    fameArea = xi.quest.fame_area.SANDORIA,
    item     = xi.items.BRASS_RING,
    title    = xi.title.THE_BENEVOLENT_ONE,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.WATERS_OF_THE_CHEVAL)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Abioleget'] = quest:progressEvent(589),

            onEventFinish =
            {
                [589] = function(player, csid, option, npc)
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
            ['Abioleget'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, { { 'gil', 70 } }) then
                        return quest:progressEvent(591)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(600)
                    else
                        return quest:messageName(northernSandoriaID.text.WILL_PROVIDE_PITTANCE, xi.items.POD_OF_BLUE_PEAS, 70)
                    end
                end,
            },

            onEventFinish =
            {
                [591] = function(player, csid, option, npc)
                    if npcUtil.giveItem(player, xi.items.POD_OF_BLUE_PEAS) then
                        player:confirmTrade()
                    end
                end,

                [600] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.EAST_RONFAURE] =
        {
            ['Andelain'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHas(trade, xi.items.POD_OF_BLUE_PEAS) then
                        if quest:getVar(player, 'Prog') == 1 then
                            return quest:messageName(eastRonfaureID.text.APPRECIATE_OFFER_DECLINE, xi.items.POD_OF_BLUE_PEAS)
                        else
                            player:messageSpecial(eastRonfaureID.text.THANKS_TO_GODDESS)
                            return quest:progressEvent(19)
                        end
                    else
                        return quest:messageSpecial(eastRonfaureID.text.CANNOT_ACCEPT_ALMS)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(19)
                    else
                        return quest:messageName(eastRonfaureID.text.MAY_ONLY_EAT, xi.items.POD_OF_BLUE_PEAS)
                    end
                end,
            },

            onEventFinish =
            {
                [19] = function(player, csid, option, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        player:confirmTrade()
                        quest:setVar(player, 'Prog', 1)
                    end

                    player:messageSpecial(eastRonfaureID.text.GATES_OF_PARADISE_OPEN)
                end,
            },
        },
    },
}

return quest
