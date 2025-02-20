-----------------------------------
-- Area: Windurst Woods
--  NPC: Varun
-- !pos 7.800 -3.5 -10.064 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getCharVar('rockracketeer_sold') == 5 and
        npcUtil.tradeHas(trade, xi.item.SHARP_STONE)
    then
        -- Sharp Stone
        player:startEvent(102, 2100)
    end
end

entity.onTrigger = function(player, npc)
    local rockRacketeer = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)
    local rockRacketeerCS = player:getCharVar('rockracketeer_sold')

    if rockRacketeer == xi.questStatus.QUEST_ACCEPTED and rockRacketeerCS == 3 then
        player:startEvent(100) -- talk about lost stone
    elseif rockRacketeer == xi.questStatus.QUEST_ACCEPTED and rockRacketeerCS == 4 then
        player:startEvent(101, 0, xi.item.SHARP_STONE) -- send player to Palborough Mines

    else
        player:startEvent(432)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 100 then
        player:setCharVar('rockracketeer_sold', 4)
    elseif csid == 101 then
        player:setCharVar('rockracketeer_sold', 5)
    elseif
        csid == 102 and
        npcUtil.completeQuest(player, xi.questLog.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER, { gil = 2100, var = 'rockracketeer_sold' })
    then
        player:confirmTrade()
    end
end

return entity
