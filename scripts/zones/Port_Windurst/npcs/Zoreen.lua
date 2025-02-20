-----------------------------------
-- Area: Port Windurst
--  NPC: Zoreen
-- Valdeaunia Regional Merchant
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.VALDEAUNIA) ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.ZOREEN_CLOSED_DIALOG)
    else
        local stock =
        {
            4382, 29,    -- Frost Turnip
            638, 170,    -- Sage
        }

        player:showText(npc, ID.text.ZOREEN_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.WINDURST)
    end
end

return entity
