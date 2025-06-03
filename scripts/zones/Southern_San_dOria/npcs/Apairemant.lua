-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Apairemant
-- Gustaberg Regional Merchant
-- !pos 72 2 0 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.GUSTABERG) == xi.nation.SANDORIA then
        local stock =
        {
            { xi.item.PINCH_OF_SULFUR,  803 },
            { xi.item.POPOTO,            50 },
            { xi.item.BAG_OF_RYE_FLOUR,  42 },
            { xi.item.EGGPLANT,          46 },
        }

        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.APAIREMANT_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    else
        player:showText(npc, zones[xi.zone.SOUTHERN_SAN_DORIA].text.APAIREMANT_CLOSED_DIALOG)
    end
end

return entity
