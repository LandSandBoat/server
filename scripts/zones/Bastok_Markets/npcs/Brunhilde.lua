-----------------------------------
-- Area: Bastok Markets
--  NPC: Brunhilde
-- !pos -305.775 -10.319 -152.173 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_CAP,               168, 3 },
        { xi.item.FACEGUARD,               1450, 3 },
        { xi.item.BRASS_MASK,             12800, 2 },
        { xi.item.SALLET,                 31860, 2 },
        { xi.item.MYTHRIL_SALLET,         56295, 1 },
        { xi.item.BRONZE_HARNESS,           256, 3 },
        { xi.item.SCALE_MAIL,              2230, 3 },
        { xi.item.BRASS_SCALE_MAIL,       19488, 2 },
        { xi.item.BREASTPLATE,            48672, 1 },
        { xi.item.BRONZE_MITTENS,           140, 3 },
        { xi.item.SCALE_FINGER_GAUNTLETS,  1190, 3 },
        { xi.item.BRASS_FINGER_GAUNTLETS, 10368, 2 },
        { xi.item.GAUNTLETS,              25673, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.BRUNHILDE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
