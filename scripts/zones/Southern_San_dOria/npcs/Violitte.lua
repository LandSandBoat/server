-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Violitte
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/magic_maps")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)
    CheckMaps(player, npc, 595)
end

entity.onEventUpdate = function(player, csid, option)
    if (csid == 595) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

entity.onEventFinish = function(player, csid, option)

end

return entity
