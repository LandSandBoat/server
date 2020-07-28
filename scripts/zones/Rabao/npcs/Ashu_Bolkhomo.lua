-----------------------------------
-- Area: Rabao
--  NPC: Ashu Bolkhomo
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/magic_maps")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    CheckMaps(player, npc, 1006)
end

function onEventUpdate(player, csid, option)
    if (csid == 1006) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

function onEventFinish(player, csid, option)

end
