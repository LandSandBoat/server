-----------------------------------
-- Area: Lower Jeuno
--  NPC: Susu
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4867,   8720,    -- Scroll of Sleep II
        4881,  11200,    -- Scroll of Sleepga
        4769,  19932,    -- Scroll of Stone III
        4770, 108000,    -- Scroll of Stone IV
        4798,  12000,    -- Scroll of Stonega II
        4799,  69875,    -- Scroll of Stonega III
        4779,  22682,    -- Scroll of Water III
        4780, 116000,    -- Scroll of Water IV
        4808,  13050,    -- Scroll of Waterga II
        4809,  82250,    -- Scroll of Waterga III
        4764,  27744,    -- Scroll of Aero III
        4765, 131750,    -- Scroll of Aero IV
        4793,  19800,    -- Scroll of Aeroga II
        4794,  95625,    -- Scroll of Aeroga III
        4754,  33306,    -- Scroll of Fire III
        4755, 148500,    -- Scroll of Fire IV
        4783,  21307,    -- Scroll of Firaga II
        4784, 112000,    -- Scroll of Firaga III
        4759,  39368,    -- Scroll of Blizzard III
        4760, 166250,    -- Scroll of Blizzard IV
        4788,  26244,    -- Scroll of Blizzaga II
        4789, 127500,    -- Scroll of Blizzaga III
        4774,  45930,    -- Scroll of Thunder III
        4775, 185000,    -- Scroll of Thunder IV
        4803,  31681,    -- Scroll of Thundaga II
        4804, 144000,    -- Scroll of Thundaga III
        4818,  60000,    -- Scroll of Quake
        4822,  67500,    -- Scroll of Flood
        4816,  56250,    -- Scroll of Tornado
        4812,  71250,    -- Scroll of Flare
        4814,  52500,    -- Scroll of Freeze
        4820,  63750,    -- Scroll of Burst
        4813, 119180,    -- Scroll of Flare II
        4815, 119180,    -- Scroll of Freeze II
        4817, 119180,    -- Scroll of Tornado II
        4819, 119180,    -- Scroll of Quake II
        4821, 119180,    -- Scroll of Burst II
        4823, 119180,    -- Scroll of Flood II
        4840, 139125,    -- Scroll of Bio III
        4884, 139125,    -- Scroll of Blind II
    }

    player:showText(npc, ID.text.SUSU_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
