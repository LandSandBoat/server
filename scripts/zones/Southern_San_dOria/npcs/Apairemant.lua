-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Apairemant
-- Gustaberg Regional Merchant
-- !pos 72 2 0 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
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
        xi.shop.general(player, stock, xi.quest.fame_area.SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
