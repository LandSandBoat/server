-----------------------------------
-- Area: Windurst Woods
--  NPC: Pehki Machumaht
-- Map Seller NPC
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/magic_maps")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    CheckMaps(player, npc, 10000)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 10000 then
        CheckMapsUpdate(player, option, ID.text.NOT_HAVE_ENOUGH_GIL, ID.text.KEYITEM_OBTAINED)
    end
end

entity.onEventFinish = function(player, csid, option)
end

return entity
