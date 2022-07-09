-----------------------------------
-- Area: Nashmau
--  NPC: Paparoon
-- Standard Info NPC
-----------------------------------
require("scripts/globals/npc_util")
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Nashmau/IDs")
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
