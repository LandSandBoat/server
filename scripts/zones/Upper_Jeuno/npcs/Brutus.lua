-----------------------------------
-- Area: Upper Jeuno
--  NPC: Brutus
-- Starts Quest: Chocobo's Wounds, Save My Son, Path of the Beastmaster, Wings of gold, Scattered into Shadow, Chocobo on the Loose!
-- !pos -55 8 95 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local chocoboOnTheLoose = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)
    local chocoboOnTheLooseStat = player:getCharVar("ChocoboOnTheLoose")
    local chocobosWounds = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_S_WOUNDS)
    local chocobosWoundsStat = player:getCharVar("ChocobosWounds_Event")
    local saveMySon = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SAVE_MY_SON)
    local pathOfTheBeastmaster = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)
    local wingsOfGold = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
    local scatteredIntoShadow = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
    local scatteredIntoShadowStat = player:getCharVar("scatIntoShadowCS")

    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    -- CHOCOBO ON THE LOOSE
    if chocoboOnTheLoose == QUEST_AVAILABLE then
        player:startEvent(10093)
    elseif chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStat == 0 then
        player:startEvent(10094)
    elseif chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStat == 2 then
        player:startEvent(10095)
    elseif chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStat == 3 then
        player:startEvent(10099)
    elseif chocoboOnTheLoose == QUEST_ACCEPTED and (chocoboOnTheLooseStat == 5 or chocoboOnTheLooseStat == 6) then
        player:startEvent(10100)
    elseif chocoboOnTheLoose == QUEST_ACCEPTED and chocoboOnTheLooseStat == 7 and not player:needToZone() and (player:getCharVar("ChocoboOnTheLooseDay") < VanadielDayOfTheYear() or player:getCharVar("ChocoboOnTheLooseYear") < VanadielYear()) then
        player:startEvent(10109)

    -- CHOCOBO'S WOUNDS
    elseif chocobosWounds == QUEST_AVAILABLE and mLvl >= 20 then
        player:startEvent(71)
    elseif chocobosWoundsStat == 1 then
        player:startEvent(65)
    elseif chocobosWoundsStat == 2 then
        player:startEvent(66)

    -- PATH OF THE BEASTMASTER
    elseif saveMySon == QUEST_COMPLETED and pathOfTheBeastmaster == QUEST_AVAILABLE then
        player:startEvent(70)

    -- WINGS OF GOLD
    elseif pathOfTheBeastmaster == QUEST_COMPLETED and wingsOfGold == QUEST_AVAILABLE and mJob == xi.job.BST and mLvl >= AF1_QUEST_LEVEL then
        if player:getCharVar("wingsOfGold_shortCS") == 1 then
            player:startEvent(137) -- Start Quest "Wings of gold" (Short dialog)
        else
            player:setCharVar("wingsOfGold_shortCS", 1)
            player:startEvent(139) -- Start Quest "Wings of gold" (Long dialog)
        end
    elseif wingsOfGold == QUEST_ACCEPTED then
        if not player:hasKeyItem(xi.ki.GUIDING_BELL) then
            player:startEvent(136)
        else
            player:startEvent(138) -- Finish Quest "Wings of gold"
        end

    -- SCATTERED INTO SHADOW
    elseif wingsOfGold == QUEST_COMPLETED and scatteredIntoShadow == QUEST_AVAILABLE and mJob == xi.job.BST and mLvl >= AF2_QUEST_LEVEL then
        if player:getCharVar("scatIntoShadow_shortCS") == 1 then
            player:startEvent(143)
        else
            player:setCharVar("scatIntoShadow_shortCS", 1)
            player:startEvent(141)
        end
    elseif scatteredIntoShadow == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.AQUAFLORA1) or player:hasKeyItem(xi.ki.AQUAFLORA2) or player:hasKeyItem(xi.ki.AQUAFLORA3) then
            player:startEvent(142)
        elseif scatteredIntoShadowStat == 0 then
            player:startEvent(144)
        elseif scatteredIntoShadowStat == 1 then
            player:startEvent(149)
        elseif scatteredIntoShadowStat == 2 then
            player:startEvent(135)
        end

    -- STANDARD DIALOGS
    elseif scatteredIntoShadow == QUEST_COMPLETED then
        player:startEvent(151)
    elseif wingsOfGold == QUEST_COMPLETED then
        player:startEvent(134)
    elseif pathOfTheBeastmaster == QUEST_COMPLETED then
        player:startEvent(20)
    elseif chocobosWounds == QUEST_COMPLETED and saveMySon == QUEST_AVAILABLE then
        player:startEvent(22)
    elseif chocobosWounds == QUEST_ACCEPTED then
        player:startEvent(102)
    else
        player:startEvent(66, mLvl)
    end
end

entity.onEventFinish = function(player, csid, option)
    -- CHOCOBO ON THE LOOSE
    if csid == 10093 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE)
    elseif csid == 10094 then
        player:setCharVar("ChocoboOnTheLoose", 1)
    elseif csid == 10095 then
        player:setCharVar("ChocoboOnTheLoose", 3)
    elseif csid == 10099 then
        player:setCharVar("ChocoboOnTheLoose", 4)
    elseif csid == 10100 then
        player:setCharVar("ChocoboOnTheLoose", 7)
        player:setCharVar("ChocoboOnTheLooseDay", VanadielDayOfTheYear())
        player:setCharVar("ChocoboOnTheLooseYear", VanadielYear())
        player:needToZone(true)
    elseif csid == 10109 then
        npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.CHOCOBO_ON_THE_LOOSE, {item = 2317, var = {"ChocoboOnTheLoose", "ChocoboOnTheLooseDay", "ChocoboOnTheLooseYear"}})

    -- CHOCOBO'S WOUNDS
    elseif csid == 71 and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBO_S_WOUNDS)
        player:setCharVar("ChocobosWounds_Event", 1)

    -- PATH OF THE BEASTMASTER
    elseif csid == 70 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)
        npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER, {title = xi.title.ANIMAL_TRAINER})
        player:unlockJob(xi.job.BST)
        player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME_A_BEASTMASTER)

    -- WINGS OF GOLD
    elseif (csid == 137 or csid == 139) and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
        player:setCharVar("wingsOfGold_shortCS", 0)
    elseif csid == 138 and npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD, {item = 16680, fame = 20}) then
        player:delKeyItem(xi.ki.GUIDING_BELL)

    -- SCATTERED INTO SHADOW
    elseif (csid == 141 or csid == 143) and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
        player:setCharVar("scatIntoShadow_shortCS", 0)
        npcUtil.giveKeyItem(player, {xi.ki.AQUAFLORA1, xi.ki.AQUAFLORA2, xi.ki.AQUAFLORA3})
    elseif csid == 144 then
        player:setCharVar("scatIntoShadowCS", 1)
    elseif csid == 135 then
        npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW, {item = 14097, fame = 40, var = "scatIntoShadowCS"})

    end
end

return entity
