-----------------------------------
-- Area: Lower Jeuno
--  NPC: Domenic
-- BCNM/KSNM Teleporter
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/teleports")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:hasCompletedQuest(JEUNO, tpz.quest.id.jeuno.BEYOND_INFINITY) == true) then
        player:startEvent(10115, player:getGil())
    else
        player:startEvent(10116)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10115) then
        if (option == 1 and player:getGil() >= 750) then
            player:delGil(750)
            tpz.teleport.to(player, tpz.teleport.id.GHELSBA_HUT)
        elseif (option == 2 and player:getGil() >= 750) then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 139)
        elseif (option == 3 and player:getGil() >= 750) then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 144)
        elseif (option == 4 and player:getGil() >= 750) then
            player:delGil(750)
            player:setPos(0, 0, 0, 0, 146)
        elseif (option == 5 and player:getGil() >= 1000) then
            player:delGil(1000)
            player:setPos(0, 0, 0, 0, 206)
        end
    end
end
