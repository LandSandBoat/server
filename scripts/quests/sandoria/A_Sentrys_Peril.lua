-----------------------------------
-- A Sentry's Peril
-- Glenne - Southern Sandoria, !pos -122 -2 15 230
-- Aaveleon - West Ronfaure, !pos -431 -45 343 100
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/items')
-----------------------------------
local westRonfaureID = require("scripts/zones/West_Ronfaure/IDs")
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SENTRYS_PERIL)

quest.reward = {
    fame = 30,
    title = xi.title.RONFAURIAN_RESCUER,
    item = xi.items.BRONZE_SUBLIGAR,
}

quest.sections = {
    -- Talk to Glenne; she's worried about her husband, Aaveleon, a guard out on patrol, and gives you some healing ointment to take to him.
    {
        check = function(player, status)
            return status == QUEST_AVAILABLE
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Glenne'] = quest:progressEvent(510),

            onEventFinish = {
                [510] = function(player, csid, option, npc)
                    if option == 0 and npcUtil.giveItem(player, xi.items.DOSE_OF_OINTMENT) then
                        quest:begin(player)
                    end
                end,
            },
        }
    },

    -- Find him on the road to Ghelsba Outpost in West Ronfaure (G-6).
    -- Trade Ointment to him and he'll give you the Ointment Case, so you can give it back to his wife.
    {
        check = function(player, status)
            return status == QUEST_ACCEPTED and quest:getVar(player, 'TradedAaveleon') == 0
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Glenne'] = {
                onTrade = function(player, npc, trade)
                    return quest:event(514) -- "I cannot accept this. Take it back."
                end,

                onTrigger = function(player, npc)
                    if player:hasItem(xi.items.DOSE_OF_OINTMENT) then
                        return quest:event(520) -- reminder to deliver ointment
                    else
                        return quest:progressEvent(644) -- reacquire ointment
                    end
                end,
            },

            onEventFinish = {
                [644] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.DOSE_OF_OINTMENT)
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] = {
            ['Aaveleon'] = {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.DOSE_OF_OINTMENT) then
                        if player:getFreeSlotsCount() == 0 then
                            return quest:event(118) -- "Ah...but it seems you're already carrying too much."
                        else
                            return quest:progressEvent(100)
                        end
                    else
                        return quest:event(106) -- "What's this? I can't accept gifts from strangers."
                    end
                end,
            },

            onEventFinish = {
                [100] = function(player, csid, option)
                    if npcUtil.giveItem(player, xi.items.OINTMENT_CASE) then
                        player:confirmTrade()
                        quest:setVar(player, 'TradedAaveleon', 1)
                    end
                end,
            },
        },
    },

    -- Trade the Ointment Case to Glenne to complete the quest.
    {
        check = function(player, status)
            return status == QUEST_ACCEPTED and quest:getVar(player, 'TradedAaveleon') == 1
        end,

        [xi.zone.WEST_RONFAURE] = {
            ['Aaveleon'] = {
                onTrigger = function(player, npc)
                    if player:hasItem(xi.items.OINTMENT_CASE) then
                        return quest:message(westRonfaureID.text.AAVELEON_HEALED) -- "My wounds are healed, thanks to you!"
                    else
                        return quest:progressEvent(126, xi.items.OINTMENT_CASE) -- reacquire ointment case
                    end
                end,
            },

            onEventFinish = {
                [126] = function(player, csid, option)
                    if option == 1 then
                        npcUtil.giveItem(player, xi.items.OINTMENT_CASE)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Glenne'] = {
                onTrigger = function(player, npc)
                    return quest:event(520) -- reminder to deliver ointment
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.OINTMENT_CASE) then
                        return quest:progressEvent(513)
                    else
                        return quest:event(514) -- "I cannot accept this. Take it back."
                    end
                end,
            },

            onEventFinish = {
                [513] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },
    },

    -- Section: After quest completion
    {
        check = function(player, status)
            return status == QUEST_COMPLETED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Glenne'] = quest:event(521),
        },

        [xi.zone.WEST_RONFAURE] = {
            ['Aaveleon'] = quest:message(westRonfaureID.text.AAVELEON_HEALED),
        },
    },
}

return quest
