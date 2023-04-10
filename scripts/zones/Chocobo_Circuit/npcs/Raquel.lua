-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Raquel
-- !pos -146.168 0.000 -541.022 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(354)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
