-----------------------------------
-- Area: Port Bastok
--  NPC: Sugandhi
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_KNIFE,    170, 3,
        xi.item.KNIFE,          2522, 2,
        xi.item.KUKRI,          6458, 1,
        xi.item.CAT_BAGHNAKHS,   120, 3,
        xi.item.BRONZE_SWORD,    278, 3,
        xi.item.IRON_SWORD,     8236, 3,
        xi.item.MYTHRIL_SWORD, 35776, 2,
        xi.item.BROADSWORD,    24344, 1,
        xi.item.DEGEN,         10632, 3,
        xi.item.TUCK,          13391, 1,
        xi.item.SAPARA,          807, 3,
        xi.item.SCIMITAR,       4706, 2,
        xi.item.FALCHION,      70720, 1,
    }

    player:showText(npc, ID.text.SUGANDHI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
