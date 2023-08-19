-----------------------------------
-- Area: Bastok Markets
--  NPC: Zhikkom
-- Standard Merchant NPC
-- !pos -288.669 -10.319 -135.064 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_SWORD,    278, 3,
        xi.items.IRON_SWORD,     8236, 2,
        xi.items.MYTHRIL_SWORD, 35776, 1,
        xi.items.BROADSWORD,    24344, 1,
        xi.items.DEGEN,         10632, 3,
        xi.items.TUCK,          13391, 1,
        xi.items.SAPARA,          807, 3,
        xi.items.SCIMITAR,       4706, 2,
        xi.items.FALCHION,      70720, 1,
        xi.items.XIPHOS,          698, 3,
        xi.items.SPATHA,         1934, 3,
        xi.items.BILBO,          3634, 3,
    }

    player:showText(npc, ID.text.ZHIKKOM_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
