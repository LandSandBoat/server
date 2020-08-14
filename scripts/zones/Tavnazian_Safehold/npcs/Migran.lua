-----------------------------------
-- Area: Tavnasian Safehold
--  NPC: Migran
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Tavnazian_Safehold/IDs")
require("scripts/globals/missions")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        12577, 2485,      -- Brass Harness
        12985, 1625,      -- Holly Clogs
    }

    if player:getCurrentMission(COP) >= tpz.mission.id.cop.SHELTERING_DOUBT then
        table.insert(stock, 14317)    -- Barone Cosciales
        table.insert(stock, 4042200)
        table.insert(stock, 15305)    -- Barone Gambieras
        table.insert(stock, 25210200)
        table.insert(stock, 14848)    -- Barone Manopolas
        table.insert(stock, 7276200)
        table.insert(stock, 15389)    -- Vir Subligar
        table.insert(stock, 8000000)
        table.insert(stock, 15390)    -- Femina Subligar
        table.insert(stock, 8000000)
    end

    player:showText(npc, ID.text.MIGRAN_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
