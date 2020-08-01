-----------------------------------
-- Area: Port Windurst
--  NPC: Sattsuh Ahkanpari
-- Elshimo Uplands Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ELSHIMOUPLANDS) ~= tpz.nation.WINDURST then
        player:showText(npc, ID.text.SATTSUHAHKANPARI_CLOSED_DIALOG)
    else
        local stock =
        {
            1413, 1656,    -- Cattleya
            628,   239,    -- Cinnamon
            4468,   73,    -- Pamamas
            721,   147,    -- Rattan Lumber
        }

        player:showText(npc, ID.text.SATTSUHAHKANPARI_OPEN_DIALOG)
        tpz.shop.general(player, stock, WINDURST)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
