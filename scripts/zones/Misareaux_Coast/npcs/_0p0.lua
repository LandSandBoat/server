-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate (Snowmint Point)
-- !pos 260 9 -435 25
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SNOWMINT_POINT_LOCKED)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
