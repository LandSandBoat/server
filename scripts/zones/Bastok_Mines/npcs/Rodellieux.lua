-----------------------------------
-- Area: Bastok_Mines
--  NPC: Rodellieux
-- Fauregandi Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.FAUREGANDI) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.RODELLIEUX_CLOSED_DIALOG)
    else
        local stock =
        {
            4571,    90,    -- Beaugreens
            4363,    39,    -- Faerie Apple
            691,     54,     -- Maple Log
        }

        player:showText(npc, ID.text.RODELLIEUX_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
