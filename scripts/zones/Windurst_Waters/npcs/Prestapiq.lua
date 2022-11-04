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
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.MOVALPOLOS)

    if regionOwner ~= xi.nation.WINDURST then
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
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
