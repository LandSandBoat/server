-----------------------------------
-- Area: Port Bastok
--  NPC: Dhen Tevryukoh
-- Elshimo Uplands Regional Merchant
-- !pos 35 -2 2 236
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMO_UPLANDS) ~= xi.nation.BASTOK then
        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.DHENTEVRYUKOH_CLOSED_DIALOG)
    else
        local stock =
        {
            { xi.item.BUNCH_OF_PAMAMAS,         84 },
            { xi.item.STICK_OF_CINNAMON,       273 },
            { xi.item.PIECE_OF_RATTAN_LUMBER,  168 },
            { xi.item.CATTLEYA,               1890 },
        }

        player:showText(npc, zones[xi.zone.PORT_BASTOK].text.DHENTEVRYUKOH_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.BASTOK)
    end
end

return entity
