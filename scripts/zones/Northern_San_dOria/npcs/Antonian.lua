-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Antonian
-- Regional Marchant NPC
-- Only sells when San d'Oria controlls Aragoneu.
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ARAGONEU) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.ANTONIAN_CLOSED_DIALOG)
    else
        local stock =
        {
            631,   36,    -- Horo Flour
            629,   43,    -- Millioncorn
            4415, 111,    -- Roasted Corn
            841,   36,    -- Yagudo Feather
            4505,  90,    -- Sunflower Seeds
        }

        player:showText(npc, ID.text.ANTONIAN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
