-----------------------------------
-- Area: Bastok Markets
--  NPC: Karine
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/magic_maps")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    CheckMaps(player, npc, 210)
end

function onEventUpdate(player, csid, option)
    if (csid == 210) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

function onEventFinish(player, csid, option)

end
