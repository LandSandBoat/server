-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47h (Handle)
-- Note: Opens door _471
-- !pos -182 -15 -19 151
-----------------------------------
local CASTLE_OZTROJA = require("scripts/zones/Castle_Oztroja/globals")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    CASTLE_OZTROJA.handleOnTrigger(npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
