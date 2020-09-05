-----------------------------------
-- Area: Bastok Mines
--  NPC: Galdeo
--  Li'Telor Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
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

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
