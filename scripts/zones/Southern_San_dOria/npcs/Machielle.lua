-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Machielle
-- Norvallen Regional Merchant
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.NORVALLEN) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.MACHIELLE_CLOSED_DIALOG)
    else
        local stock =
        {
            688, 18,    -- Arrowwood Log
            621, 25,    -- Crying Mustard
            618, 25,    -- Blue Peas
            698, 88,    -- Ash Log
        }

        player:showText(npc, ID.text.MACHIELLE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
