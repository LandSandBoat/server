-----------------------------------
-- Area: Port Bastok
--  NPC: Bagnobrok
-- Movalpolos Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.MOVALPOLOS) == xi.nation.BASTOK then
        local stock =
        {
            { xi.item.BOTTLE_OF_MOVALPOLOS_WATER,  840 },
            { xi.item.CHUNK_OF_COPPER_ORE,          12 },
            { xi.item.DANCESHROOM,                4704 },
            { xi.item.CORAL_FUNGUS,                792 },
            { xi.item.CHUNK_OF_KOPPARNICKEL_ORE,   840 },
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.BAGNOBROK_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    else
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.BAGNOBROK_CLOSED_DIALOG)
    end
end

return entity
