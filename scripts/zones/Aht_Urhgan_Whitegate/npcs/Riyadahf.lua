-----------------------------------
-- Area: Aht'Urhgan Whitegate
--  NPC: Riyadahf
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/magic_maps")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    CheckMaps(player, npc, 563)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 563 then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
