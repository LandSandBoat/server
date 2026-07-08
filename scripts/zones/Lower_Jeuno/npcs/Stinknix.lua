-----------------------------------
-- Area: Lower Jeuno
--  NPC: Stinknix
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.PINCH_OF_POISON_DUST,      320 },
        { xi.item.PINCH_OF_VENOM_DUST,      1035 },
        { xi.item.PINCH_OF_PARALYSIS_DUST,  2000 },
        { xi.item.IRON_ARROW,                  8 },
        { xi.item.CROSSBOW_BOLT,               6 },
        { xi.item.GRENADE,                  1204 },
        { xi.item.DUCHY_WAYSTONE,          10000 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.JUNK_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
