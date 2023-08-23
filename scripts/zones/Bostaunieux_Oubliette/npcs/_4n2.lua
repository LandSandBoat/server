-----------------------------------
-- Area: Bostaunieux Obliette
--  NPC: _4n2 (Sewer Lid)
-- !pos -19.000 -17.899 20.000 167
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SEEMS_LOCKED)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
