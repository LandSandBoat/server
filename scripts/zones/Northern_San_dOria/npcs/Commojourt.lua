-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Commojourt
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)

    if rand == 1 then
        player:startEvent(653)
    else
        player:startEvent(657)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
