-----------------------------------
-- Area: Port Bastok
--  NPC: Sawyer
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LOAF_OF_IRON_BREAD,         105, 3 },
        { xi.item.BRETZEL,                     25, 3 },
        { xi.item.LOAF_OF_PUMPERNICKEL,       166, 3 },
        { xi.item.BAKED_POPOTO,               336, 3 },
        { xi.item.SAUSAGE,                    163, 3 },
        { xi.item.BOWL_OF_PEBBLE_SOUP,        210, 3 },
        { xi.item.BOWL_OF_EGG_SOUP,          3432, 3 },
        { xi.item.FLASK_OF_DISTILLED_WATER,    12, 3 },
        { xi.item.BOTTLE_OF_MELON_JUICE,     1155, 3 },
        { xi.item.BOTTLE_OF_PINEAPPLE_JUICE,  416, 3 },
        { xi.item.SLICE_OF_ROAST_MUTTON,      756, 3 },
		-- Amaryllis QoL addition. Check other nations for additional flowers.
		{ xi.item.AMARYLLIS,                  699, 3 },
    }

    player:showText(npc, zones[xi.zone.PORT_BASTOK].text.SAWYER_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
