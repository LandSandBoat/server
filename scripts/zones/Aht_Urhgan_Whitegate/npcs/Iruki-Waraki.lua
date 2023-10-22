-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Iruki-Waraki
-- Type: Standard NPC
--  Involved in quest: No Strings Attached
-- !pos 101.329 -6.999 -29.042 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/pets")
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
