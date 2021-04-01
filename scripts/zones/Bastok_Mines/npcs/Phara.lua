-----------------------------------
-- Area: Bastok Mines
--  NPC: Phara
-- Starts and Finishes Quest: The doorman (start)
-- Involved in Quest: The Talekeeper's Truth
-- !zone 234
-- !pos 75 0 -80
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local theDoorman = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)
    local theTalekeeperTruth = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_TALEKEEPER_S_TRUTH)

    if (theDoorman == QUEST_AVAILABLE and player:getMainJob() == xi.job.WAR and player:getMainLvl() >= 40) then
        player:startEvent(151) -- Start Quests "The doorman"
    elseif (player:hasKeyItem(xi.ki.SWORD_GRIP_MATERIAL)) then
        player:startEvent(152) -- Need to wait 1 vanadiel day
    elseif (player:getCharVar("theDoormanCS") == 2 and VanadielDayOfTheYear() ~= player:getCharVar("theDoorman_time")) then
        player:startEvent(153) -- The doorman notification, go to naji
    elseif (theDoorman == QUEST_COMPLETED and theTalekeeperTruth == QUEST_AVAILABLE) then
        player:startEvent(154) -- New standard dialog
    else
        player:startEvent(150) -- Standard dialog
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 151) then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_DOORMAN)
        player:setCharVar("theDoormanCS", 1)
    elseif (csid == 152) then
        player:setCharVar("theDoorman_time", VanadielDayOfTheYear())
        player:setCharVar("theDoormanCS", 2)
        player:delKeyItem(xi.ki.SWORD_GRIP_MATERIAL)
    elseif (csid == 153) then
        player:addKeyItem(xi.ki.YASINS_SWORD)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.YASINS_SWORD)
        player:setCharVar("theDoormanCS", 3)
        player:setCharVar("theDoorman_time", 0)
    elseif (csid == 154) then
        player:setCharVar("theTalekeeperTruthCS", 1)
    end

end

return entity
