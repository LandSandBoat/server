-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Corua
-- Ronfaure Regional Merchant
-- !pos -66 2 -11 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
end

function onTrigger(player, npc)
    if GetRegionOwner(tpz.region.RONFAURE) ~= tpz.nation.SANDORIA then
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
        tpz.shop.general(player, stock, SANDORIA)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
