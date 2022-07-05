-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Happo
-- NPC spectator [roams]
-- pos -32.9832 -15 -126.9244
-- event 356 357 358
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(356)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity