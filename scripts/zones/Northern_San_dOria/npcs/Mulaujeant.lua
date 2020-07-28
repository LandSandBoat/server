-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Mulaujeant
-- Involved in Quests: Missionary Man
-- !pos -175 0 181 231
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day
    starttime = player:getCharVar("MissionaryMan_date")
    MissionaryManVar = player:getCharVar("MissionaryManVar")

    if (MissionaryManVar == 2) then
        player:startEvent(698, 0, 1146) -- Start statue creation
    elseif (MissionaryManVar == 3 and (starttime == realday or player:needToZone() == true)) then
        player:startEvent(699) -- During statue creation
    elseif (MissionaryManVar == 3 and starttime ~= realday and player:needToZone() == false) then
        player:startEvent(700) -- End of statue creation
    elseif (MissionaryManVar == 4) then
        player:startEvent(701) -- During quest (after creation)
    else
        player:startEvent(697) -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 698) then
        player:setCharVar("MissionaryManVar", 3)
        player:setCharVar("MissionaryMan_date", os.date("%j")) -- %M for next minute, %j for next day
        player:delKeyItem(tpz.ki.RAUTEINOTS_PARCEL)
        player:needToZone(true)

    elseif (csid == 700) then
        player:setCharVar("MissionaryManVar", 4)
        player:setCharVar("MissionaryMan_date", 0)
        player:addKeyItem(tpz.ki.SUBLIME_STATUE_OF_THE_GODDESS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.SUBLIME_STATUE_OF_THE_GODDESS)
    end
end
