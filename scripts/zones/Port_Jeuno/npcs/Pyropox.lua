-----------------------------------
-- Area: Port Jeuno
--  NPC: Pyropox
-- Standard Merchant NPC
-- !pos -17.580 4.000 24.600 246
-----------------------------------
local ID = require("scripts/zones/Port_Jeuno/IDs")
require("scripts/globals/shop")
-----------------------------------

local stock =
{
    4251,   25,    -- Festive Fan
    4252,   25,    -- Summer Fan
    4256,   25,    -- Ouka Ranman
    4184,   50,    -- Kongou Inaho
    4185,   50,    -- Meifu Goma
    4253,   50,    -- Spirit Masque
    5881,   50,    -- Shisai Kaboku
    4183,  100,    -- Konron Hassen
    5360,  100,    -- Muteppo
    5361,  100,    -- Datechochin
    6268,  150,    -- Komanezumi
    5884,  250,    -- Rengedama
    5532,  250,    -- Ichinintousen Koma
    5725,  300,    -- Goshikitenge
}

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if  player:getCharVar("spokePyropox") == 1 then
        player:startEvent(349)
    else
        player:showText(npc, ID.text.PYROPOX_SHOP_DIALOG)
        tpz.shop.general(player, stock)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 349 and option == 0 then
        tpz.shop.general(player, stock)
        player:setCharVar("spokePyropox", 0)
    end
end
