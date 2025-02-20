-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Attarena
-- Only sells when San d'Oria controlls Li'Telor Region
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.LITELOR) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.ATTARENA_CLOSED_DIALOG)
    else
        local stock =
        {
            623,   119,    -- Bay Leaves
            4154, 6440,    -- Holy Water
        }

        player:showText(npc, ID.text.ATTARENA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
