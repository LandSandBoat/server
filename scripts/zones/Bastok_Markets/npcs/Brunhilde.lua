-----------------------------------
-- Area: Bastok Markets
--  NPC: Brunhilde
-- !pos -305.775 -10.319 -152.173 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_CAP,               174, 3,
        xi.item.FACEGUARD,               1508, 3,
        xi.item.BRASS_MASK,             13312, 2,
        xi.item.SALLET,                 33134, 2,
        xi.item.MYTHRIL_SALLET,         59109, 1,
        xi.item.BRONZE_HARNESS,           266, 3,
        xi.item.SCALE_MAIL,              2319, 3,
        xi.item.BRASS_SCALE_MAIL,       20267, 2,
        xi.item.BREASTPLATE,            51105, 1,
        xi.item.BRONZE_MITTENS,           145, 3,
        xi.item.SCALE_FINGER_GAUNTLETS,  1237, 3,
        xi.item.BRASS_FINGER_GAUNTLETS, 10782, 2,
        xi.item.GAUNTLETS,              26956, 1,
    }

    player:showText(npc, ID.text.BRUNHILDE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
