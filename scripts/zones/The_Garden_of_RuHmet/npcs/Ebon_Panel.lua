-----------------------------------
-- Area: The Garden of RuHmet
--  NPC: Ebon_Panel
-- !pos 100.000 -5.180 -337.661 35 | Mithra Tower
-- !pos 740.000 -5.180 -342.352 35 | Elvaan Tower
-- !pos 257.650 -5.180 -699.999 35 | Tarutaru Tower
-- !pos 577.648 -5.180 -700.000 35 | Galka Tower
-- !pos 422.351 -5.180 -100.000 35 | Hume Tower
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
require("scripts/globals/missions")
require("scripts/globals/titles")
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
