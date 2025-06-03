-----------------------------------
-- Area: Port San d'Oria
--  NPC: Patolle
-- Kuzotz Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KUZOTZ) == xi.nation.SANDORIA then
        local stock =
        {
            { xi.item.THUNDERMELON,   341 },
            { xi.item.CACTUAR_NEEDLE, 976 },
            { xi.item.WATERMELON,     210 },
        }

        player:showText(npc, zones[xi.zone.PORT_SAN_DORIA].text.PATOLLE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    else
        player:showText(npc, zones[xi.zone.PORT_SAN_DORIA].text.PATOLLE_CLOSED_DIALOG)
    end
end

return entity
