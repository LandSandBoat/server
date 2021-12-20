-----------------------------------
-- Area: Abyssea
-- NPC: Sturdy Pyxis
-----------------------------------
require("scripts/globals/abyssea/sturdypyxis/npc")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.pyxis.npc.onPyxisTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.pyxis.npc.onPyxisTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, input)
    xi.pyxis.npc.onPyxisEventUpdate(player, csid, option, input)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.pyxis.npc.onPyxisEventFinish(player, csid, option, npc)
end

return entity
