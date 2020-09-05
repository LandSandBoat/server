-----------------------------------
-- Area: Port San d'Oria
--  NPC: Nimia
-- Elshimo Lowlands Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.ELSHIMOLOWLANDS) ~= tpz.nation.SANDORIA then
        player:showText(npc, ID.text.NIMIA_CLOSED_DIALOG)
    else
        local stock =
        {
            612,    55,    -- Kazham Peppers
            4432,   55,    -- Kazham Pineapple
            4390,   36,    -- Mithran Tomato
            626,   234,    -- Black Pepper
            630,    88,    -- Ogre Pumpkin
            632,   110,    -- Kukuru Bean
            1411, 1656,    -- Phalaenopsis
        }

        player:showText(npc, ID.text.NIMIA_OPEN_DIALOG)
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
