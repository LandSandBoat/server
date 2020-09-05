-----------------------------------
-- Area: Port San d'Oria
--  NPC: Bonmaurieut
-- Elshimo Uplands Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ELSHIMOUPLANDS) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.BONMAURIEUT_CLOSED_DIALOG)
    else
        local stock =
        {
            1413, 1656,    -- Cattleya
            628,   239,    -- Cinnamon
            4468,   73,    -- Pamamas
            721,   147,    -- Rattan Lumber
        }

        player:showText(npc, ID.text.BONMAURIEUT_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
