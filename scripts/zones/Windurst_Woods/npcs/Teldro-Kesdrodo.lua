-----------------------------------
-- Area: Windurst Woods
-- NPC : Teldro-Kesdrodo
-- Unity NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.unity.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.unity.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.unity.onEventFinish(player, csid, option, npc)
end

return entity
