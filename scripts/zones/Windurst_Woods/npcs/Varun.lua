-----------------------------------
-- Area: Windurst Woods
--   NPC: Varun
-- Type: Standard NPC
-- !pos 7.800 -3.5 -10.064 241
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getCharVar("rockracketeer_sold") == 5 and npcUtil.tradeHas(trade, 598) then -- Sharp Stone
        player:startEvent(102, 2100)
    end
end

function onTrigger(player, npc)
    local rockRacketeer = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER)
    local rockRacketeerCS = player:getCharVar("rockracketeer_sold")

    if rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 3 then
        player:startEvent(100) -- talk about lost stone
    elseif rockRacketeer == QUEST_ACCEPTED and rockRacketeerCS == 4 then
        player:startEvent(101, 0, 598) -- send player to Palborough Mines

    else
        player:startEvent(432)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 100 then
        player:setCharVar("rockracketeer_sold", 4)
    elseif csid == 101 then
        player:setCharVar("rockracketeer_sold", 5)
    elseif csid == 102 and npcUtil.completeQuest(player, WINDURST, tpz.quest.id.windurst.ROCK_RACKETEER, {gil=2100, var="rockracketeer_sold"}) then
        player:confirmTrade()
    end
end
