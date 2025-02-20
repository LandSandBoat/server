-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Thadiene
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.SHORTBOW,                       45, 3,
        xi.item.SELF_BOW,                      557, 2,
        xi.item.WRAPPED_BOW,                  8236, 1,
        xi.item.LONGBOW,                       511, 3,
        xi.item.GREAT_BOW,                   22684, 1,
        xi.item.WOODEN_ARROW,                    4, 3,
        xi.item.IRON_ARROW,                      8, 2,
        xi.item.SILVER_ARROW,                   18, 1,
        xi.item.FIRE_ARROW,                    145, 2,
        xi.item.CROSSBOW_BOLT,                   6, 2,
        xi.item.BOOMERANG,                    1820, 1,
        xi.item.SCROLL_OF_BATTLEFIELD_ELEGY,  4992, 3,
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
