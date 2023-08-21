-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Corua
-- Ronfaure Regional Merchant
-- !pos -66 2 -11 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.RONFAURE) ~= xi.nation.SANDORIA then
        player:showText(npc, ID.text.CORUA_CLOSED_DIALOG)
    else
        local stock =
        {
            4389,  29,    -- San d'Orian Carrot
            4431,  69,    -- San d'Orian Grape
            639,  110,    -- Chestnut
            610,   55,    -- San d'Orian Flour
        }

        player:showText(npc, ID.text.CORUA_OPEN_DIALOG)
        xi.shop.general(player, stock, xi.quest.fame_area.SANDORIA)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
