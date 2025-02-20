-----------------------------------
-- Area: Port Bastok
--  NPC: Bagnobrok
-- Movalpolos Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.MOVALPOLOS) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.BAGNOBROK_CLOSED_DIALOG)
    else
        local stock =
        {
            640,    11,    -- Copper Ore
            4450,  694,    -- Coral Fungus
            4375, 4032,    -- Danceshroom
            1650, 6500,    -- Kopparnickel Ore
            5165,  736,    -- Movalpolos Water
        }

        player:showText(npc, ID.text.BAGNOBROK_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
