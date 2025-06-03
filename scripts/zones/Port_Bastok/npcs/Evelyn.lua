-----------------------------------
-- Area: Port Bastok
--  NPC: Evelyn
-- Gustaberg Regional Merchant
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.GUSTABERG) == xi.nation.BASTOK then
        local stock =
        {
            { xi.item.PINCH_OF_SULFUR,  803 },
            { xi.item.POPOTO,            50 },
            { xi.item.BAG_OF_RYE_FLOUR,  42 },
            { xi.item.EGGPLANT,          46 },
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.EVELYN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    else
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.EVELYN_CLOSED_DIALOG)
    end
end

return entity
