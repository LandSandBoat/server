-----------------------------------
-- Area: Windurst Waters
--  NPC: Churano-Shurano
-- !pos -60.8 -11.2 98.9 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.MAGICKED_ASTROLABE) then
        local cost = 10000
        if player:getLocalVar("Astrolabe") == 0 then
            player:startEvent(1080, cost)
        else
            player:startEvent(1081, cost)
        end
    else
        player:startEvent(280)
    end
end

function onEventUpdate(player, csid, option)
    if csid == 1080 or csid == 1081 then
        if option == 1 and player:getGil() >= 10000 then
            player:updateEvent(tpz.ki.MAGICKED_ASTROLABE)
        else
            player:updateEvent(0)
        end
    end
end

function onEventFinish(player, csid, option)
    if csid == 1080 and option ~= tpz.ki.MAGICKED_ASTROLABE then
        player:setLocalVar("Astrolabe", 1)
    elseif (csid == 1080 or csid == 1081) and option == tpz.ki.MAGICKED_ASTROLABE and player:getGil() >= 10000 then
        npcUtil.giveKeyItem(player, tpz.ki.MAGICKED_ASTROLABE)
        player:delGil(10000)
    end
end
