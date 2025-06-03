-----------------------------------
-- Area: Bastok_Mines
--  NPC: Rodellieux
-- Fauregandi Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.FAUREGANDI) ~= xi.nation.BASTOK then
        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.RODELLIEUX_CLOSED_DIALOG)
    else
        local stock =
        {
            { xi.item.MAPLE_LOG,            63 },
            { xi.item.FAERIE_APPLE,         46 },
            { xi.item.CLUMP_OF_BEAUGREENS, 105 },
        }

        player:showText(npc, zones[xi.zone.BASTOK_MINES].text.RODELLIEUX_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
