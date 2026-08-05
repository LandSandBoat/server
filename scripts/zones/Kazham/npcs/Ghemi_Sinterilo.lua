-----------------------------------
-- Area: Kazham
--  NPC: Ghemi Senterilo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_PAMAMAS,           80 },
        { xi.item.KAZHAM_PINEAPPLE,           60 },
        { xi.item.MITHRAN_TOMATO,             40 },
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,    60 },
        { xi.item.STICK_OF_CINNAMON,         260 },
        { xi.item.KUKURU_BEAN,               120 },
        { xi.item.ELSHIMO_COCONUT,           172 },
        { xi.item.ELSHIMO_PACHIRA_FRUIT,     168 },
        { xi.item.KAZHAM_WAYSTONE,         10000 },
        { xi.item.AQUILARIA_LOG,            3128 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.GHEMISENTERILO_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
