-----------------------------------
-- Area: Rabao
--  NPC: Ashu Bolkhomo
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/magic_maps")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

end

entity.onTrigger = function(player, npc)
    CheckMaps(player, npc, 1006)
end

entity.onEventUpdate = function(player, csid, option)
    if (csid == 1006) then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

entity.onEventFinish = function(player, csid, option)

end

return entity
