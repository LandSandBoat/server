-----------------------------------
-- Area: Windurst Woods
--  NPC: Nya Labiccio
-- Only sells when Windurst controlls Gustaberg Region
-- Confirmed shop stock, August 2013
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.GUSTABERG) == xi.nation.WINDURST then
        local stock =
        {
            { xi.item.PINCH_OF_SULFUR,  803 },
            { xi.item.POPOTO,            50 },
            { xi.item.BAG_OF_RYE_FLOUR,  42 },
            { xi.item.EGGPLANT,          46 },
        }

        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.NYALABICCIO_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    else
        player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.NYALABICCIO_CLOSED_DIALOG)
    end
end

return entity
