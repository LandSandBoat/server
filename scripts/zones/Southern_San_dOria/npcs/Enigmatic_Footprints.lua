-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Enigmatic Footprints
-- Entry NPC for Dynamis Divergence
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.TEAR_IN_FABRIC_OF_SPACE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
