-----------------------------------
-- Area: Bastok Markets
--  NPC: Somn-Paemn
-- Sarutabaruta Regional Goods
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.SARUTABARUTA) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.SOMNPAEMN_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.items.RARAB_TAIL,                      24,
            xi.items.LAUAN_LOG,                       37,
            xi.items.POPOTO,                          49,
            xi.items.SARUTA_ORANGE,                   33,
            xi.items.CLUMP_OF_WINDURSTIAN_TEA_LEAVES, 20,
        }

        player:showText(npc, ID.text.SOMNPAEMN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
