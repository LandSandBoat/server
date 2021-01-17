-----------------------------------
-- Area: Bastok_Mines
--  NPC: Faustin
-- Ronfaure Regional Merchant
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.RONFAURE) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.FAUSTIN_CLOSED_DIALOG)
    else
        local stock =
        {
            639, 110,    -- Chestnut
            4389, 29,    -- San d'Orian Carrot
            610,  55,    -- San d'Orian Flour
            4431, 69,     -- San d'Orian Grape
        }

        player:showText(npc, ID.text.FAUSTIN_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
