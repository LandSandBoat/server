-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Millechuca
-- Regional Marchant NPC
-- Only sells when San d'Oria controls Vollbow.
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VOLLBOW) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.MILLECHUCA_CLOSED_DIALOG)
    else
        local stock =
        {
            636,   119,    -- Chamomile
            864,    88,    -- Fish Scales
            936,    14,    -- Rock Salt
            1410, 1656,    -- Sweet William
        }

        player:showText(npc, ID.text.MILLECHUCA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
