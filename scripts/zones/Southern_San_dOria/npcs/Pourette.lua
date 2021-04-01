-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Pourette
-- Derfland Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.DERFLAND) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.POURETTE_CLOSED_DIALOG)
    else
        local stock =
        {
            4352,  128,    -- Derfland Pear
            617,   142,    -- Ginger
            4545,   62,    -- Gysahl Greens
            1412, 1656,    -- Olive Flower
            633,    14,    -- Olive Oil
            951,   110,    -- Wijnruit
        }

        player:showText(npc, ID.text.POURETTE_OPEN_DIALOG)
        xi.shop.general(player, stock, SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
