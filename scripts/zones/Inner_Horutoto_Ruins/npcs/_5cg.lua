-----------------------------------
-- Area: Inner Horutoto Ruins
--  NPC: _5cg (Gate of Fire)
-- !pos -332 0 99 192
-----------------------------------
local ID = require("scripts/zones/Inner_Horutoto_Ruins/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.DOOR_FIRMLY_CLOSED)
    return 1
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
