-----------------------------------
-- Area: Bastok Markets
--  NPC: Brunhilde
-- Standard Merchant NPC
-- !pos -305.775 -10.319 -152.173 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_CAP,               174, 3,
        xi.items.FACEGUARD,               1508, 3,
        xi.items.BRASS_MASK,             13312, 2,
        xi.items.SALLET,                 33134, 2,
        xi.items.MYTHRIL_SALLET,         59109, 1,
        xi.items.BRONZE_HARNESS,           266, 3,
        xi.items.SCALE_MAIL,              2319, 3,
        xi.items.BRASS_SCALE_MAIL,       20267, 2,
        xi.items.BREASTPLATE,            51105, 1,
        xi.items.BRONZE_MITTENS,           145, 3,
        xi.items.SCALE_FINGER_GAUNTLETS,  1237, 3,
        xi.items.BRASS_FINGER_GAUNTLETS, 10782, 2,
        xi.items.GAUNTLETS,              26956, 1,
    }

    player:showText(npc, ID.text.BRUNHILDE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
