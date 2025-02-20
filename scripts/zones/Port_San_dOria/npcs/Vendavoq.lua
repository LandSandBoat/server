-----------------------------------
-- Area: Port San d'Oria
--  NPC: Vendavoq
--  Movalpolos Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.MOVALPOLOS) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.VENDAVOQ_CLOSED_DIALOG)
    else
        local stock =
        {
            640,    11,    -- Copper Ore
            4450,  694,    -- Coral Fungus
            4375, 4032,    -- Danceshroom
            1650, 6500,    -- Kopparnickel Ore
            5165,  736,    -- Movalpolos Water
        }

        player:showText(npc, ID.text.VENDAVOQ_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
