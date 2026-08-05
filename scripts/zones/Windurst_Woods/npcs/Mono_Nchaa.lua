-----------------------------------
-- Area: Windurst Woods
--  NPC: Mono Nchaa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SHORTBOW,                    43, 2 },
        { xi.item.SELF_BOW,                   536, 2 },
        { xi.item.WRAPPED_BOW,               7920, 1 },
        { xi.item.LIGHT_CROSSBOW,             180, 2 },
        { xi.item.HAWKEYE,                     61, 2 },
        { xi.item.BOOMERANG,                 1750, 2 },
        { xi.item.WOODEN_ARROW,                 4, 2 },
        { xi.item.BONE_ARROW,                   5, 3 },
        { xi.item.CROSSBOW_BOLT,                6, 3 },
        { xi.item.ICE_ARROW,                  140, 1 },
        { xi.item.LIGHTNING_ARROW,            140, 1 },
        { xi.item.SCROLL_OF_HUNTERS_PRELUDE, 2880, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MONONCHAA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
