-----------------------------------
-- Area: Windurst Woods
--  NPC: Varun
-- Type: Standard NPC
-- !pos 7.800 -3.5 -10.064 241
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("rockracketeer_sold") == 5 and npcUtil.tradeHas(trade, 598) then -- Sharp Stone
        player:startEvent(102, 2100)
    end
end

entity.onTrigger = function(player, npc)
    local rockRacketeer = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
    local rockRacketeerCS = player:getCharVar("rockracketeer_sold")

    if rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 3 then
        player:startEvent(100) -- talk about lost stone
    elseif rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 4 then
        player:startEvent(101, 0, 598) -- send player to Palborough Mines

    else
        player:startEvent(432)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 100 then
        player:setCharVar("rockracketeer_sold", 4)
    elseif csid == 101 then
        player:setCharVar("rockracketeer_sold", 5)
    elseif csid == 102 and npcUtil.completeQuest(player, WINDURST, xi.quest.id.windurst.ROCK_RACKETEER, {gil=2100, var="rockracketeer_sold"}) then
        player:confirmTrade()
    end
end

return entity
