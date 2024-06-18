-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Ethereal Junction
-- !pos -118.876 -4.088 -515.731 116
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.unityWanted.junctionOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.unityWanted.junctionOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.unityWanted.junctionOnEventFinish(player, csid, option, npc)
end

return entity
