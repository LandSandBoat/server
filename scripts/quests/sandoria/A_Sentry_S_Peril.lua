-----------------------------------
-- A Sentry's Peril
-- Gleen - Southern Sandoria, !pos -122 -2 15 230
-- Aaveleon - West Ronfaure, !pos -431 -45 343 100
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.A_SENTRY_S_PERIL)

quest.reward = {
    fame = 30,
    title = xi.title.RONFAURIAN_RESCUER,
    item = xi.items.BRONZE_SUBLIGAR,
}

quest.sections = {
    -- Section: Begin quest
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

    -- Section: Deliver ointment and return with ointment case
    {
        check = function(player, status)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] = {
            ['Glenne'] = {
                onTrigger = function(player, npc)
                    if player:hasItem(xi.items.DOSE_OF_OINTMENT) or player:hasItem(xi.items.OINTMENT_CASE) then
                        return quest:event(520)
                    else
                        -- Reaquire ointment
                        return quest:progressEvent(644)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.OINTMENT_CASE) then
                        return quest:progressEvent(513)
                    end
                end,
            },

            onEventFinish = {
                [644] = function(player, csid, option, npc)
                    npcUtil.giveItem(player, xi.items.DOSE_OF_OINTMENT)
                end,
                [513] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:confirmTrade()
                    end
                end,
            },
        },

        [xi.zone.WEST_RONFAURE] = {
            ['Aaveleon'] = {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, xi.items.DOSE_OF_OINTMENT) then
                        if player:getFreeSlotsCount() == 0 then
                            return quest:event(118)
                        else
                            return quest:progressEvent(100)
                        end
                    else
                        return quest:event(106)
                    end
                end,
            },

            onEventFinish = {
                [100] = function(player, csid, option)
                    if npcUtil.giveItem(player, xi.items.OINTMENT_CASE) then
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
    },
}


return quest
