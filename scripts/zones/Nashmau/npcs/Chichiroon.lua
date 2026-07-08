-----------------------------------
-- Area: Nashmau
--  NPC: Chichiroon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BOLTERS_DIE,      99224 },
        { xi.item.CASTERS_DIE,      85500 },
        { xi.item.COURSERS_DIE,     97350 },
        { xi.item.BLITZERS_DIE,    100650 },
        { xi.item.TACTICIANS_DIE,  109440 },
        { xi.item.ALLIES_DIE,      116568 },
        { xi.item.MISERS_DIE,       96250 },
        { xi.item.COMPANIONS_DIE,   95800 },
        { xi.item.AVENGERS_DIE,    123744 },
        { xi.item.GEOMANCER_DIE,    69288 },
        { xi.item.RUNE_FENCER_DIE,  73920 },
    }

    player:showText(npc, zones[xi.zone.NASHMAU].text.CHICHIROON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
