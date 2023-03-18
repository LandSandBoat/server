-----------------------------------
-- Area: Reisenjima (291)
-- NPC: ???
-- Notes: Grants "Ethereal droplet" temporary item.
-----------------------------------
local ID = require("scripts/zones/Reisenjima/IDs")
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:hasItem(xi.items.ETHEREAL_DROPLET, xi.inv.TEMPITEMS) then
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    else
        player:addTempItem(xi.items.ETHEREAL_DROPLET, 1)
        player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.ETHEREAL_DROPLET)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
