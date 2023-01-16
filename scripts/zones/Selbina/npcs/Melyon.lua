-----------------------------------
-- Area: Selbina
--  NPC: Melyon
-- Starts and Finishes Quest: Only the Best (R)
-- Involved in Quest: Riding on the Clouds
-- !pos 25 -6 6 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST) ~= QUEST_AVAILABLE then
        if npcUtil.tradeHas(trade, { { 4366, 5 } }) then -- La Theine Cabbage x5
            player:startEvent(62, 0, 4366)
        elseif npcUtil.tradeHas(trade, { { 629, 3 } }) then -- Millioncorn x3
            player:startEvent(63, 0, 629)
        elseif npcUtil.tradeHas(trade, 919) then -- Boyahda Moss x1
            player:startEvent(64, 0, 919)
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST) == QUEST_AVAILABLE then
        player:startEvent(60, 4366, 629, 919) -- Start quest "Only the Best"
    else
        player:startEvent(61, 4366, 629, 919) -- During & after completed quest "Only the Best"
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 60 and option == 10 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST)
    elseif csid == 62 and option == 11 then
        npcUtil.giveCurrency(player, 'gil', 100)
        player:addFame(xi.quest.fame_area.BASTOK, 10)
        player:addFame(xi.quest.fame_area.SANDORIA, 10)
        player:addFame(xi.quest.fame_area.JEUNO, 10)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    elseif csid == 63 and option == 12 then
        npcUtil.giveCurrency(player, 'gil', 120)
        player:addFame(xi.quest.fame_area.BASTOK, 20)
        player:addFame(xi.quest.fame_area.SANDORIA, 20)
        player:addFame(xi.quest.fame_area.JEUNO, 20)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    elseif csid == 64 and option == 13 then
        npcUtil.giveCurrency(player, 'gil', 600)
        player:addFame(xi.quest.fame_area.BASTOK, 30)
        player:addFame(xi.quest.fame_area.SANDORIA, 30)
        player:addFame(xi.quest.fame_area.JEUNO, 30)
        player:completeQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.ONLY_THE_BEST)
        player:confirmTrade()
    end
end

return entity
