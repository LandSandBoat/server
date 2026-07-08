-----------------------------------
-- Area: Kazham
--  NPC: Ghemi Senterilo
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BUNCH_OF_PAMAMAS,           84 },
        { xi.item.KAZHAM_PINEAPPLE,           63 },
        { xi.item.MITHRAN_TOMATO,             42 },
        { xi.item.BUNCH_OF_KAZHAM_PEPPERS,    63 },
        { xi.item.STICK_OF_CINNAMON,         273 },
        { xi.item.KUKURU_BEAN,               126 },
        { xi.item.ELSHIMO_COCONUT,           180 },
        { xi.item.ELSHIMO_PACHIRA_FRUIT,     176 },
        { xi.item.KAZHAM_WAYSTONE,         10500 },
        { xi.item.AQUILARIA_LOG,            3284 },
    }

    player:showText(npc, zones[xi.zone.KAZHAM].text.GHEMISENTERILO_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
