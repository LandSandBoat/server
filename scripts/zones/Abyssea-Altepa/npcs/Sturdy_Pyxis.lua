-----------------------------------
-- Area: Abyssea
-- NPC: Sturdy Pyxis
-----------------------------------
require("scripts/globals/abyssea/sturdypyxis")
-----------------------------------
local entity = {}

entity.onTrade = function(player,npc,trade)
    xi.pyxis.onPyxisTrade(player,npc,trade)
end

entity.onTrigger = function(player,npc)
    xi.pyxis.onPyxisTrigger(player,npc)
end

entity.onEventUpdate = function(player,csid,option,input)
    xi.pyxis.onPyxisEventUpdate(player,csid,option,input)
end

entity.onEventFinish = function(player,csid,option,npc)
    xi.pyxis.onPyxisEventFinish(player,csid,option,npc)
end

return entity
