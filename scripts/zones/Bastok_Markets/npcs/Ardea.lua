-----------------------------------
-- Area: Bastok Markets
--  NPC: Ardea
-- !pos -198 -6 -69 235
-- Involved in quests: Chasing Quotas, Rock Racketeer
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rockRacketeer = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.ROCK_RACKETEER)

    -- Rock Racketeer
    if
        rockRacketeer == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.SHARP_GRAY_STONE)
    then
        player:startEvent(261)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- Rock Racketeer
    if csid == 261 and option ~= 1 then
        player:delKeyItem(xi.ki.SHARP_GRAY_STONE)
        player:addGil(xi.settings.main.GIL_RATE * 10)
        player:setCharVar("rockracketeer_sold", 1)
    elseif csid == 261 and option ~= 2 then
        player:setCharVar("rockracketeer_sold", 2)
    end
end

return entity
