-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Violitte
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/magic_maps")
-----------------------------------

function onTrade(player, npc, trade)

end

function onTrigger(player, npc)
    CheckMaps(player, npc, 595)
end

function onEventUpdate(player, csid, option)
    if (csid == 595) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

function onEventFinish(player, csid, option)

end
