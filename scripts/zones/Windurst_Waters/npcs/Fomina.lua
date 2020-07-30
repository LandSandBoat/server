-----------------------------------
-- Area: Windurst Waters
--  NPC: Fomina
-- Only sells when Windurst controlls Elshimo Lowlands
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.ELSHIMOLOWLANDS)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.FOMINA_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.FOMINA_OPEN_DIALOG)

        local stock =
        {
            612,     55,  -- Kazham Peppers
            4432,    55,  -- Kazham Pineapple
            4390,    36,  -- Mithran Tomato
            626,    234,  -- Black Pepper
            630,     88,  -- Ogre Pumpkin
            632,    110,  -- Kukuru Bean
            1411,  1656   -- Phalaenopsis
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
