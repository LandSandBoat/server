-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Jadamo
-- Race Overview
-- pos -66.5120 -15.0000 -131.5493

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(335)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity