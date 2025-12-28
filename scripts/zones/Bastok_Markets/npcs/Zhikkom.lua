-----------------------------------
-- Area: Bastok Markets
--  NPC: Zhikkom
-- !pos -288.669 -10.319 -135.064 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_SWORD,    281, 3 },
        { xi.item.IRON_SWORD,     8316, 2 },
        { xi.item.MYTHRIL_SWORD, 35776, 1 },
        { xi.item.BROADSWORD,    24344, 1 },
        { xi.item.DEGEN,         10735, 3 },
        { xi.item.TUCK,          13391, 1 },
        { xi.item.SAPARA,          814, 3 },
        { xi.item.SCIMITAR,       4751, 2 },
        { xi.item.FALCHION,      70720, 1 },
        { xi.item.XIPHOS,          705, 3 },
        { xi.item.SPATHA,         1953, 3 },
        { xi.item.BILBO,          3669, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.ZHIKKOM_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
