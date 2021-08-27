-----------------------------------
-- Area: Port San d'Oria
--  NPC: Milva
-- Sarutabaruta Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.SARUTABARUTA) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.MILVA_CLOSED_DIALOG)
    else
        local stock =
        {
            4444, 22,    -- Rarab Tail
            689,  33,    -- Lauan Log
            619,  43,    -- Popoto
            4392, 29,    -- Saruta Orange
            635,  18,    -- Windurstian Tea Leaves
        }

        player:showText(npc, ID.text.MILVA_OPEN_DIALOG)
        xi.shop.general(player, stock, SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
