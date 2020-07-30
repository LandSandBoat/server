-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Rahal
-- Involved in Quests: The Holy Crest, Lure of the Wildcat (San d'Oria)
-- !pos -28 0.1 -6 233
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local CrestProgress = player:getCharVar("TheHolyCrest_Event")
    local RemedyKI = player:hasKeyItem(tpz.ki.DRAGON_CURSE_REMEDY)
    local Stalker_Quest = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER)
    local StalkerProgress = player:getCharVar("KnightStalker_Progress")
    local WildcatSandy = player:getCharVar("WildcatSandy")

    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and player:getMaskBit(WildcatSandy, 17) == false) then
        player:startEvent(559)
    -- Need to speak with Rahal to get Dragon Curse Remedy
    elseif (CrestProgress == 5 and RemedyKI == false) then
        player:startEvent(60) -- Gives key item
    elseif (CrestProgress == 5 and RemedyKI == true) then
        player:startEvent(122) -- Reminder to go to Gelsba
     -- Completed AF2, AF3 available, and currently on DRG.  No level check, since they cleared AF2.
    elseif (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS) == QUEST_COMPLETED and Stalker_Quest == QUEST_AVAILABLE and player:getMainJob() == tpz.job.DRG) then
        if (player:getCharVar("KnightStalker_Declined") == 0) then
            player:startEvent(121) -- Start AF3
        else
            player:startEvent(120) -- Short version if they previously declined
        end
    elseif Stalker_Quest == QUEST_ACCEPTED then
        if (StalkerProgress == 0) then
            player:startEvent(119) -- Reminder to go to Brugaire/Ceraulian
        elseif (player:hasKeyItem(tpz.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) == true) then
            if (StalkerProgress == 1) then
                player:startEvent(78) -- Reaction to challenge, go talk to Balasiel
            elseif (StalkerProgress == 2) then
                player:startEvent(69) -- Reminder to talk to Balasiel
            elseif (StalkerProgress == 3) then
                player:startEvent(110) -- To the south with you
            end
        end
    elseif (player:getCharVar("KnightStalker_Option2") == 1) then
        player:startEvent(118) -- Optional CS after Knight Stalker
        -- Mission 8-2 San dOria --
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.LIGHTBRINGER and player:getCharVar("MissionStatus") == 1) then
        player:startEvent(106)
    elseif (player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.LIGHTBRINGER and player:getCharVar("MissionStatus") == 2) then
        player:startEvent(107)
    else
        player:startEvent(529) -- standard dialogue
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 60) then
        player:addKeyItem(tpz.ki.DRAGON_CURSE_REMEDY)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.DRAGON_CURSE_REMEDY)
    elseif (csid == 559) then
        player:setMaskBit(player:getCharVar("WildcatSandy"), "WildcatSandy", 17, true)
    elseif (csid == 121) then
        if (option == 1) then
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER)
        else
            player:setCharVar("KnightStalker_Declined", 1)
        end
    elseif (csid == 120 and option == 1) then
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER)
        player:setCharVar("KnightStalker_Declined", 0)
    elseif (csid == 78) then
        player:setCharVar("KnightStalker_Progress", 2)
    elseif (csid == 110) then
        player:setCharVar("KnightStalker_Progress", 4)
    elseif (csid == 118) then
        player:setCharVar("KnightStalker_Option2", 0)
    elseif (csid == 106) then
        if (player:hasKeyItem(tpz.ki.CRYSTAL_DOWSER)) then
            player:delKeyItem(tpz.ki.CRYSTAL_DOWSER) -- To prevent them getting a message about already having the keyitem
        else
            player:setCharVar("MissionStatus", 2)
            player:addKeyItem(tpz.ki.CRYSTAL_DOWSER)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.CRYSTAL_DOWSER)
        end
    end
end

-- Already in-use cutscenes are not listed
-- 563 - ToAU, brought a letter from "Sage Raillefal."
-- 564 - Show Raillefal's letter to Halver?  Goes to 563.
-- 9 - Destin gives an address, Mission CS, Rahal appears
-- 10 - Destin gives another speech, Mission CS, Claide reports on Rochefogne
-- 100 - Destin speech, mission, Lightbringer
-- 106 - Take this tpz.ki.CRYSTAL_DOWSER and go to Temple of Uggalepih
-- 107 - Short version/reminder for 106
-- 105 - Unable to locate Lightbringer, but Curilla found it
-- 42 - Had my doubts about treasure, but Curilla found it.  Why was it on that island?
-- 37 - Rochefogne slain?
-- 38 - Rites of Succession
-- 39 - Dedicates upcoming battle in Fei'Yin to fallen knights.
-- 40 - Thanks for help.  Wrap up for what 39 is suggesting?
-- 41 - Lightbringer sealed away.  Thanks for help.
-- 529 - I am Rahal S Lebrart of the Royal Knights.  Possible fall back dialog if nothing active?
-- 544 - "I understand his lordship's fervor, but the risk is too great for us.  I believe this requires utmost caution."
-- 77 - "Commendable work.  With our mortal enemy vanquished, we must now restore glory to San d'Oria.  Your cooperation is expected!"
-- 534 - Halver CS, re: Rank 5 fight in Fei'Yin
-- 559 - Lure of the Wildcat
