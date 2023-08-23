-----------------------------------
-- Area: Abyssea
-- NPC: Sturdy Pyxis
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.pyxis.npc.onPyxisTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.pyxis.npc.onPyxisTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.pyxis.npc.onPyxisEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.pyxis.npc.onPyxisEventFinish(player, csid, option, npc)
end

return entity
