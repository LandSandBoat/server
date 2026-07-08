-----------------------------------
-- Area: Port Bastok
--  NPC: Sugandhi
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_KNIFE,    172, 3 },
        { xi.item.KNIFE,          2546, 2 },
        { xi.item.KUKRI,          6458, 1 },
        { xi.item.CAT_BAGHNAKHS,   121, 3 },
        { xi.item.BRONZE_SWORD,    281, 3 },
        { xi.item.IRON_SWORD,     8316, 3 },
        { xi.item.MYTHRIL_SWORD, 36120, 2 },
        { xi.item.BROADSWORD,    24344, 1 },
        { xi.item.DEGEN,         10735, 3 },
        { xi.item.TUCK,          13391, 1 },
        { xi.item.SAPARA,          814, 3 },
        { xi.item.SCIMITAR,       4751, 2 },
        { xi.item.FALCHION,      70720, 1 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.SUGANDHI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
