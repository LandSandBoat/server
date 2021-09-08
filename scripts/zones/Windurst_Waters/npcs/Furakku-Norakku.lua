-----------------------------------
-- Area: Windurst Waters
--  NPC: Furakku-Norakku
-- Involved in Quests: Early Bird Catches the Bookworm, Chasing Tales, Class Reunion
-- !pos -19 -5 101 238
-----------------------------------
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/settings/main")
require("scripts/globals/keyitems")
require("scripts/globals/titles")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local chasingStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
    local ClassReunion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
    local ClassReunionProgress = player:getCharVar("ClassReunionProgress")
    local talk2 = player:getCharVar("ClassReunion_TalkedToFurakku")

    if (chasingStatus == QUEST_ACCEPTED and player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION) == false) then
        player:startEvent(404, 0, 126) -- During Quest "Chasing Tales", tells you the book "A Song of Love" is overdue
    elseif (player:hasKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION) and player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) == false) then
        player:startEvent(405, 0, 126)
    elseif (player:getCharVar("CHASING_TALES_TRACK_BOOK") == 1 and player:hasKeyItem(xi.ki.A_SONG_OF_LOVE) == false) then
        player:startEvent(409)
    elseif (player:hasKeyItem(xi.ki.A_SONG_OF_LOVE)) then
        player:startEvent(410)
    elseif (chasingStatus == QUEST_COMPLETED and player:needToZone() == true) then
        player:startEvent(411)
    -----------------------------------
    -- Class Reunion
    elseif (ClassReunion == 1 and ClassReunionProgress >= 3 and talk2 ~= 1) then
        player:startEvent(816) -- he tells you about Uran-Mafran
    -----------------------------------
    else
        player:startEvent(371)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 404) then
        player:addKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.OVERDUE_BOOK_NOTIFICATION)
    elseif (csid == 410) then
        player:needToZone(true)
        player:addGil(xi.settings.GIL_RATE*2800)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*2800)
        player:addTitle(xi.title.SAVIOR_OF_KNOWLEDGE)
        player:delKeyItem(xi.ki.OVERDUE_BOOK_NOTIFICATION)
        player:delKeyItem(xi.ki.A_SONG_OF_LOVE)
        player:setCharVar("CHASING_TALES_TRACK_BOOK", 0)
        player:addFame(WINDURST, 120)
        player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CHASING_TALES)
    elseif (csid == 816) then
        player:setCharVar("ClassReunion_TalkedToFurakku", 1)
    end
end

return entity
