-----------------------------------
-- Area: Southern San d'Oria
-- NPC : Urbiolaine
-- Unity NPC
-----------------------------------
require("scripts/globals/unity")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.unity.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.unity.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.unity.onEventFinish(player, csid, option)
end

return entity
