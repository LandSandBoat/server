-----------------------------------
-- Area: Bastok_Mines
--  NPC: Mille
-- Norvallen Regional Merchant
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.NORVALLEN) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.MILLE_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.ARROWWOOD_LOG,         20,
            xi.item.POT_OF_CRYING_MUSTARD, 29,
            xi.item.POD_OF_BLUE_PEAS,      29,
            xi.item.ASH_LOG,               99,
        }

        player:showText(npc, ID.text.MILLE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
