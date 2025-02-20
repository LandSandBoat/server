-----------------------------------
-- Area: Port San d'Oria
--  NPC: Patolle
-- Kuzotz Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.KUZOTZ) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.PATOLLE_CLOSED_DIALOG)
    else
        local stock =
        {
            916,  855,    -- Cactuar Needle
            4412, 299,    -- Thundermelon
            4491, 184,    -- Watermelon
        }

        player:showText(npc, ID.text.PATOLLE_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
