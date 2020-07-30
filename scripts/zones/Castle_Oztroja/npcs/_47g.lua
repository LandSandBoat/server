-----------------------------------
-- Area:  Castle Oztroja
-- NPC:   _47g (Handle)
-- Notes: Opens door _471
-- !pos -182 -15 -19 151
-----------------------------------
local CASTLE_OZTROJA = require("scripts/zones/Castle_Oztroja/globals")

function onTrigger(player, npc)
    CASTLE_OZTROJA.handleOnTrigger(npc)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
