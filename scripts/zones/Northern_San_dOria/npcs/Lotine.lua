-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Lotine
-- !pos -137.504 11.999 171.090 231
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)
    if rand == 1 then
        player:startEvent(652)
    else
        player:startEvent(656)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
