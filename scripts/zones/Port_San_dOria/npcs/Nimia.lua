-----------------------------------
-- Area: Port San d'Oria
--  NPC: Nimia
-- Elshimo Lowlands Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMOLOWLANDS) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.NIMIA_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.BUNCH_OF_KAZHAM_PEPPERS,   62,
            xi.item.KAZHAM_PINEAPPLE,          62,
            xi.item.MITHRAN_TOMATO,            41,
            xi.item.PINCH_OF_BLACK_PEPPER,    265,
            xi.item.OGRE_PUMPKIN,              99,
            xi.item.KUKURU_BEAN,              124,
            xi.item.PHALAENOPSIS,            1872,
        }

        player:showText(npc, ID.text.NIMIA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
