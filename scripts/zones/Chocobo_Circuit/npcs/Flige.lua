-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Flige
-- Grandstand Exit
-- pos -35.4830 -15.0000 -132.1756

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(329)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity