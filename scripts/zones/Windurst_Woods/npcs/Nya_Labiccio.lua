-----------------------------------
-- Area: Windurst Woods
--  NPC: Nya Labiccio
-- Only sells when Windurst controlls Gustaberg Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
require("scripts/globals/zone")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local RegionOwner = GetRegionOwner(xi.region.GUSTABERG)
    if RegionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.NYALABICCIO_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.NYALABICCIO_OPEN_DIALOG)

        local stock =
        {
            1108,  703, -- Sulfur
            619,    43, -- Popoto
            611,    36, -- Rye Flour
            4388,   40  -- Eggplant
        }
        xi.shop.general(player, stock, WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
