-----------------------------------
-- Area: Bastok Mines
--  NPC: Galdeo
--  Li'Telor Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(tpz.region.LITELOR) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.GALDEO_CLOSED_DIALOG)
    else
        local stock =
        {
            623,   119,    -- Bay Leaves
            4154, 6440,    -- Holy Water
        }

        player:showText(npc, ID.text.GALDEO_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
