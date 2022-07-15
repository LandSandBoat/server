-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Jolande
-- Standard Info NPC
-- pos -496.4251 -0.0169 -370.3765
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(346)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
