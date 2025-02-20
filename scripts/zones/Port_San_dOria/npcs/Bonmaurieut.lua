-----------------------------------
-- Area: Port San d'Oria
--  NPC: Bonmaurieut
-- Elshimo Uplands Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMOUPLANDS) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.BONMAURIEUT_CLOSED_DIALOG)
    else
        local stock =
        {
            1413, 1656,    -- Cattleya
            628,   239,    -- Cinnamon
            4468,   73,    -- Pamamas
            721,   147,    -- Rattan Lumber
        }

        player:showText(npc, ID.text.BONMAURIEUT_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
