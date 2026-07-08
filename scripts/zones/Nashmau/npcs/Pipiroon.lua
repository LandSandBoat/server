-----------------------------------
-- Area: Nashmau
--  NPC: Pipiroon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.GRENADE,            1204 },
        { xi.item.RIOT_GRENADE,       6000 },
        { xi.item.PINCH_OF_BOMB_ASH,   515 },
        { xi.item.NASHMAU_WAYSTONE,  10000 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.PIPIROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
