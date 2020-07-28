-----------------------------------
-- Area: Port Bastok
--  NPC: Rex
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/magic_maps")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    CheckMaps(player, npc, 115)
end

function onEventUpdate(player, csid, option)
    if (csid == 115) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

function onEventFinish(player, csid, option)

end
