-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Palguevion
-- Only sells when San d'Oria controlls Valdeaunia Region
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VALDEAUNIA) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.PALGUEVION_CLOSED_DIALOG)
    else
        local stock =
        {
            xi.item.SPRIG_OF_SAGE, 192,
            xi.item.FROST_TURNIP,   33,
        }

        player:showText(npc, ID.text.PALGUEVION_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
