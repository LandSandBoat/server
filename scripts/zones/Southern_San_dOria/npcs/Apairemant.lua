-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Apairemant
-- Gustaberg Regional Merchant
-- !pos 72 2 0 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.GUSTABERG) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.APAIREMANT_CLOSED_DIALOG)
    else
        local stock =
        {
            1108, 703,    -- Sulfur
            619,   43,    -- Popoto
            611,   36,    -- Rye Flour
            4388,  40,    -- Eggplant
        }

        player:showText(npc, ID.text.APAIREMANT_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.fameArea.SANDORIA)
    end
end

return entity
