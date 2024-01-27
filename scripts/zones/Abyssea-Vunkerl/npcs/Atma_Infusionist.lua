-----------------------------------
-- Zone: Abyssea - Vunkerl
--  NPC: Atma Infusionist
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.atma.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.atma.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.atma.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.atma.onEventFinish(player, csid, option, npc)
end

return entity
