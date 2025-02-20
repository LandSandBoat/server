-----------------------------------
-- Area: Bastok Markets
--  NPC: Somn-Paemn
-- Sarutabaruta Regional Goods
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.SARUTABARUTA) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.SOMNPAEMN_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.RARAB_TAIL,                      24,
            xi.item.LAUAN_LOG,                       37,
            xi.item.POPOTO,                          49,
            xi.item.SARUTA_ORANGE,                   33,
            xi.item.CLUMP_OF_WINDURSTIAN_TEA_LEAVES, 20,
        }

        player:showText(npc, ID.text.SOMNPAEMN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
