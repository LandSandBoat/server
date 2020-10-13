-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Exoroche
-- Involved in Quests: Father and Son, A Boy's Dream
-- !pos 72 -1 60 230

-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

--    player:startEvent(79)  -- how the paper works -- under oath
--    player:startEvent(51)  -- it says what i dont beleive you -- under oath
--    player:startEvent(19)  -- thanks for your help i have to tell trion -- under oath
--     player:startEvent(77)    -- a boys dream
-- "Father and Son" Event Dialogs
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FATHER_AND_SON) == QUEST_ACCEPTED) then
        player:startEvent(542)
    elseif (player:getCharVar("aBoysDreamCS") == 2) then
        player:startEvent(50)
    elseif (player:getCharVar("aBoysDreamCS") >= 7) then
        player:startEvent(32)
    elseif (player:getCharVar("UnderOathCS") == 4 and player:hasKeyItem(tpz.ki.STRANGE_SHEET_OF_PAPER)) then
        player:startEvent(77)
    elseif (player:getCharVar("UnderOathCS") == 5) then
        player:startEvent(79)
    elseif (player:hasKeyItem(tpz.ki.KNIGHTS_CONFESSION) and player:getCharVar("UnderOathCS") == 6) then
        player:startEvent(51)
    elseif (player:getCharVar("UnderOathCS") == 8) then
        player:startEvent(19)
    else
        player:startEvent(76)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 542) then
        player:setCharVar("QuestfatherAndSonVar", 1)
    elseif (csid == 50) then
        player:setCharVar("aBoysDreamCS", 3)
    elseif (csid == 32 and player:getCharVar("aBoysDreamCS") == 7) then
        player:setCharVar("aBoysDreamCS", 8)
    elseif (csid == 77) then
        player:setCharVar("UnderOathCS", 5)
    end
end
------- used in expansions
--    player:startEvent(946)  -- you want to hear of my father go talk to albieche
--    player:startEvent(947) -- trainees spectacles
