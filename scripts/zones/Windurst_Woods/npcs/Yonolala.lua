-----------------------------------
-- Area: Windurst Woods
-- NPC : Yonolala
-- Unity NPC
-----------------------------------
require("scripts/globals/unity")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.unity.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.unity.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.unity.onEventFinish(player, csid, option)
end

return entity
