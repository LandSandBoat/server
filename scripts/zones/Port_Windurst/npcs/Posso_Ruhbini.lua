-----------------------------------
-- Area: Port Windurst
--  NPC: Posso Ruhbini
-- Norvallen Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.NORVALLEN) ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.POSSORUHBINI_CLOSED_DIALOG)
    else
        local stock =
        {
            688, 18,    -- Arrowwood Log
            698, 87,    -- Ash Log
            618, 25,    -- Blue Peas
            621, 25,    -- Crying Mustard
        }

        player:showText(npc, ID.text.POSSORUHBINI_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
