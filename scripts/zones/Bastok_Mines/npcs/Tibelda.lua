-----------------------------------
-- Area: Bastok Mines
--  NPC: Tibelda
-- Valdeaunia Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VALDEAUNIA) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.TIBELDA_CLOSED_DIALOG)
    else
        local stock =
        {
            4382,  29,    --Frost Turnip
            638,  170,     --Sage
        }

        player:showText(npc, ID.text.TIBELDA_OPEN_DIALOG)
        xi.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
