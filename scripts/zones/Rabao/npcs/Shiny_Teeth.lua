-----------------------------------
-- Area: Rabao
--  NPC: Shiny Teeth
-- !pos -30 8 99 247
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.DAGGER,          2111 },
        { xi.item.KRIS,           12579 },
        { xi.item.KNIFE,           2522 },
        { xi.item.SCIMITAR,        4706 },
        { xi.item.TULWAR,         40352 },
        { xi.item.FALCHION,       70720 },
        { xi.item.ROD,             2758 },
        { xi.item.JAMADHARS,     118632 },
        { xi.item.COMPOSITE_BOW,  27300 },
        { xi.item.TATHLUM,          332 },
        { xi.item.IRON_ARROW,         8 },
        { xi.item.BULLET,           104 },
        { xi.item.RIOT_GRENADE,    6240 },
        { xi.item.CHAKRAM,        10395 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.SHINY_TEETH_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
