-----------------------------------
-- Area: Quicksand Caves
--  NPC: ???
-- Involved in Mission: The Mithra and the Crystal (Zilart 12)
-- !pos -504 20 -419 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SOMETHING_IS_BURIED)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
