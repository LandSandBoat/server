-----------------------------------
-- Area: Windurst Waters
--  NPC: Maqu Molpih
-- Only sells when Windurst controlls Aragoneu Region
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.ARAGONEU)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.MAQUMOLPIH_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.MAQUMOLPIH_OPEN_DIALOG)

        local stock =
        {
            631,    36,  -- Horo Flour
            629,    44,  -- Millioncorn
            4415,  114,  -- Roasted Corn
            4505,   92,  -- Sunflower Seeds
            841,    36   -- Yagudo Feather
        }
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
