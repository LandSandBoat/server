-----------------------------------
-- Area: Bastok Markets
--  NPC: Zhikkom
-- !pos -288.669 -10.319 -135.064 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_SWORD,    278, 3,
        xi.item.IRON_SWORD,     8236, 2,
        xi.item.MYTHRIL_SWORD, 35776, 1,
        xi.item.BROADSWORD,    24344, 1,
        xi.item.DEGEN,         10632, 3,
        xi.item.TUCK,          13391, 1,
        xi.item.SAPARA,          807, 3,
        xi.item.SCIMITAR,       4706, 2,
        xi.item.FALCHION,      70720, 1,
        xi.item.XIPHOS,          698, 3,
        xi.item.SPATHA,         1934, 3,
        xi.item.BILBO,          3634, 3,
    }

    player:showText(npc, ID.text.ZHIKKOM_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
