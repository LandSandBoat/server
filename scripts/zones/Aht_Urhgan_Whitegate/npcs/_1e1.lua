-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Salaheem's Sentinels (Door)
-- !pos 23 -6 -63 50
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npc:openDoor()
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
