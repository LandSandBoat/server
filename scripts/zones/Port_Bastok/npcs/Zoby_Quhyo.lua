-----------------------------------
-- Area: Port Bastok
--  NPC: Zoby Quhyo
-- Elshimo Lowlands Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ELSHIMOLOWLANDS) ~= tpz.nation.BASTOK then
        player:showText(npc, ID.text.ZOBYQUHYO_CLOSED_DIALOG)
    else
        local stock =
        {
            626,   234,    -- Black Pepper
            612,    55,    -- Kazham Peppers
            4432,   55,    -- Kazham Pineapple
            632,   110,    -- Kukuru Bean
            4390,   36,    -- Mithran Tomato
            630,    88,    -- Ogre Pumpkin
            1411, 1656,    -- Phalaenopsis
        }

        player:showText(npc, ID.text.ZOBYQUHYO_OPEN_DIALOG)
        tpz.shop.general(player, stock, BASTOK)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
