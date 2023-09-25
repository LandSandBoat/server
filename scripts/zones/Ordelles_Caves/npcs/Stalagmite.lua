-----------------------------------
-- Area: Ordelles Caves
--  NPC: Stalagmite
-- Involved In Quest: Sharpening the Sword
-- !pos -51 0.1 3 193
-----------------------------------
local ID = require("scripts/zones/Ordelles_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
