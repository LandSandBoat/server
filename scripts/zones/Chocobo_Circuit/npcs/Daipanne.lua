-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Daipanne
-- Standard Info NPC
-- pos -384.6037 -4.0000 -454.1636
-- event 308 312 316 320 324 325 326 327
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(308)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity