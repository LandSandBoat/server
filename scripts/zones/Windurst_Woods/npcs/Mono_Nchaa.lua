-----------------------------------
-- Area: Windurst Woods
--  NPC: Mono Nchaa
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.SHORTBOW,                    45, 3 },
        { xi.item.SELF_BOW,                   557, 3 },
        { xi.item.WRAPPED_BOW,               8236, 3 },
        { xi.item.LIGHT_CROSSBOW,             187, 3 },
        { xi.item.HAWKEYE,                     62, 3 },
        { xi.item.BOOMERANG,                 1820, 3 },
        { xi.item.WOODEN_ARROW,                 4, 3 },
        { xi.item.BONE_ARROW,                   5, 3 },
        { xi.item.CROSSBOW_BOLT,                6, 3 },
        { xi.item.ICE_ARROW,                  145, 3 },
        { xi.item.LIGHTNING_ARROW,            145, 3 },
        { xi.item.SCROLL_OF_HUNTERS_PRELUDE, 2995, 3 },
		-- Lilac QoL addition. Check other nations for additional flowers.
		{ xi.item.LILAC,	                  699, 3 },
    }

    player:showText(npc, zones[xi.zone.WINDURST_WOODS].text.MONONCHAA_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.WINDURST)
end

return entity
