-----------------------------------
-- Area: Upper Jeuno
--  NPC: Rhea Myuliah
-- Type: Standard NPC
-- !pos -56.220 -1 101.805 244
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    --Dancer AF: Comeback Queen
    if player:getCharVar("comebackQueenCS") == 1 then
        player:startEvent(10145)
    elseif player:getCharVar("comebackQueenCS") == 3 then
        player:startEvent(10149) -- dance practice
    elseif player:getCharVar("comebackQueenCS") == 5 then --player cleared Laila's story
        player:startEvent(10155)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
