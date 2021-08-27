-----------------------------------
-- Area: Port Jeuno
--  NPC: Door: Arrivals (from San d'Oria)
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:startEvent(54)
    return 1

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
