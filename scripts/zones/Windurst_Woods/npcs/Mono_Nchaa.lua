-----------------------------------
-- Area: Windurst Woods
--  NPC: Mono Nchaa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SHORTBOW,                    45, 2 },
        { xi.item.SELF_BOW,                   557, 2 },
        { xi.item.WRAPPED_BOW,               8236, 1 },
        { xi.item.LIGHT_CROSSBOW,             187, 2 },
        { xi.item.HAWKEYE,                     62, 2 },
        { xi.item.BOOMERANG,                 1820, 2 },
        { xi.item.WOODEN_ARROW,                 4, 2 },
        { xi.item.BONE_ARROW,                   5, 3 },
        { xi.item.CROSSBOW_BOLT,                6, 3 },
        { xi.item.ICE_ARROW,                  145, 1 },
        { xi.item.LIGHTNING_ARROW,            145, 1 },
        { xi.item.SCROLL_OF_HUNTERS_PRELUDE, 2995, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MONONCHAA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
