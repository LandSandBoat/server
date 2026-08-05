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
        { xi.item.DAGGER,          2030 },
        { xi.item.KRIS,           12096 },
        { xi.item.KNIFE,           2425 },
        { xi.item.SCIMITAR,        4525 },
        { xi.item.TULWAR,         38800 },
        { xi.item.FALCHION,       68000 },
        { xi.item.ROD,             2652 },
        { xi.item.JAMADHARS,     114070 },
        { xi.item.COMPOSITE_BOW,  26250 },
        { xi.item.TATHLUM,          320 },
        { xi.item.IRON_ARROW,         8 },
        { xi.item.BULLET,           100 },
        { xi.item.RIOT_GRENADE,    6000 },
        { xi.item.CHAKRAM,         9996 },
    }

    player:showText(npc, zones[xi.zone.RABAO].text.SHINY_TEETH_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.SELBINA_RABAO)
end

return entity
