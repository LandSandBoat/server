-----------------------------------
-- Area: Port Bastok
--  NPC: Vattian
-- Kuzotz Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KUZOTZ) == xi.nation.BASTOK then
        local stock =
        {
            { xi.item.THUNDERMELON,   341 },
            { xi.item.CACTUAR_NEEDLE, 976 },
            { xi.item.WATERMELON,     210 },
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.VATTIAN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    else
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.VATTIAN_CLOSED_DIALOG)
    end
end

return entity
