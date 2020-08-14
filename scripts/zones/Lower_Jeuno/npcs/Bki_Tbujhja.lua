-----------------------------------
-- Area: Lower Jeuno
--  NPC: Bki Tbujhja
-- Involved in Quest: The Old Monument
-- Starts and Finishes Quests: Path of the Bard (just start), The Requiem (BARD AF2)
-- !pos -22 0 -60 245
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/shop")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local theRequiem = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)

    -- THE REQUIEM (holy water)
    if (theRequiem == QUEST_ACCEPTED and player:getCharVar("TheRequiemCS") == 2 and trade:hasItemQty(4154, 1) and trade:getItemCount() == 1) then
        player:startEvent(151)
    end
end

function onTrigger(player, npc)
    local aMinstrelInDespair = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.A_MINSTREL_IN_DESPAIR)
    local painfulMemory = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.PAINFUL_MEMORY)
    local theRequiem = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)

    -- THE OLD MONUMENT
    if (player:getCharVar("TheOldMonument_Event") == 1) then
        player:startEvent(181) -- mentions song runes in Buburimu

    -- PATH OF THE BARD (Bard Flag)
    elseif (aMinstrelInDespair == QUEST_COMPLETED and player:getCharVar("PathOfTheBard_Event") == 0) then
        player:startEvent(182) -- mentions song runes in Valkurm

    -- THE REQUIEM (Bard AF2)
    elseif (painfulMemory == QUEST_COMPLETED and theRequiem == QUEST_AVAILABLE and player:getMainJob() == tpz.job.BRD and player:getMainLvl() >= AF2_QUEST_LEVEL) then
        if (player:getCharVar("TheRequiemCS") == 0) then
            player:startEvent(145) -- Long dialog & Start Quest "The Requiem"
        else
            player:startEvent(148) -- Shot dialog & Start Quest "The Requiem"
        end
    elseif (theRequiem == QUEST_ACCEPTED and player:getCharVar("TheRequiemCS") == 2) then
        player:startEvent(146) -- During Quest "The Requiem" (before trading Holy Water)
    elseif (theRequiem == QUEST_ACCEPTED and player:getCharVar("TheRequiemCS") == 3 and player:hasKeyItem(tpz.ki.STAR_RING1) == false) then
        if (math.random(1, 2) == 1) then
            player:startEvent(147) -- oh, did you take the holy water and play the requiem? you must do both!
        else
            player:startEvent(149) -- his stone sarcophagus is deep inside the eldieme necropolis.
        end
    elseif (theRequiem == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.STAR_RING1) == true) then
        player:startEvent(150) -- Finish Quest "The Requiem"
    elseif (theRequiem == QUEST_COMPLETED) then
        player:startEvent(134) -- Standard dialog after "The Requiem"

    -- DEFAULT DIALOG
    else
        player:startEvent(180)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- THE OLD MONUMENT
    if (csid == 181) then
        player:setCharVar("TheOldMonument_Event", 2)

    -- PATH OF THE BARD
    elseif (csid == 182) then
        player:setCharVar("PathOfTheBard_Event", 1)

    -- THE REQUIEM
    elseif (csid == 145 and option == 0) then
        player:setCharVar("TheRequiemCS", 1) -- player declines quest
    elseif ((csid == 145 or csid == 148) and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)
        player:setCharVar("TheRequiemCS", 2)
    elseif (csid == 151) then
        player:setCharVar("TheRequiemCS", 3)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4154) -- Holy Water (just message)
        player:setCharVar("TheRequiemRandom", math.random(1, 5)) -- pick a random sarcophagus
    elseif (csid == 150) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14098)
        else
            player:addItem(14098)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14098) -- Choral Slippers
            player:addFame(JEUNO, 30)
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.THE_REQUIEM)
        end
    end
end
