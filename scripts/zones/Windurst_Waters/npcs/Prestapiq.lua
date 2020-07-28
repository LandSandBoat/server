-----------------------------------
-- Area: Windurst Waters
--  NPC: Prestapiq
-- Only sells when Windurst controls Movalpolos
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local RegionOwner = GetRegionOwner(tpz.region.MOVALPOLOS)
    if (RegionOwner ~= tpz.nation.WINDURST) then
        player:showText(npc, ID.text.PRESTAPIQ_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.PRESTAPIQ_OPEN_DIALOG)

        local stock =
        {
            640,    11,   --Copper Ore
            4450,   694,   --Coral Fungus
            4375,  4032,   --Danceshroom
            1650,  6500,   --Kopparnickel Ore
            5165,   736    --Movalpolos Water
        }
        tpz.shop.general(player, stock, WINDURST)

    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
