-----------------------------------
-- Area: Windurst Woods
--  NPC: Gioh Ajihri
-- Starts & Finishes Repeatable Quest: Twinstone Bonding
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar("GiohAijhriSpokenTo") == 1 and
        not player:needToZone() and
        npcUtil.tradeHas(trade, 13360)
    then
        player:startEvent(490)
    end
end

entity.onTrigger = function(player, npc)
    local twinstoneBonding = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)

    if twinstoneBonding == QUEST_COMPLETED then
        if player:needToZone() then
            player:startEvent(491, 0, 13360)
        else
            player:startEvent(488, 0, 13360)
        end
    elseif twinstoneBonding == QUEST_ACCEPTED then
        player:startEvent(488, 0, 13360)
    elseif
        twinstoneBonding == QUEST_AVAILABLE and
        player:getFameLevel(xi.quest.fame_area.WINDURST) >= 2
    then
        player:startEvent(487, 0, 13360)
    else
        player:startEvent(424)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 487 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING)
        player:setCharVar("GiohAijhriSpokenTo", 1)
    elseif csid == 490 then
        player:confirmTrade()
        player:needToZone(true)
        player:setCharVar("GiohAijhriSpokenTo", 0)

        if player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING) == QUEST_ACCEPTED then
            npcUtil.completeQuest(player, xi.quest.log_id.WINDURST, xi.quest.id.windurst.TWINSTONE_BONDING, { item = 17154, fame = 80, fameArea = xi.quest.fame_area.WINDURST, title = xi.title.BOND_FIXER })
        else
            player:addFame(xi.quest.fame_area.WINDURST, 10)
            npcUtil.giveCurrency(player, 'gil', 900)
        end
    elseif csid == 488 then
        player:setCharVar("GiohAijhriSpokenTo", 1)
    end
end

return entity
