-----------------------------------
-- Area: Upper Jeuno
--  NPC: Brutus
-- Starts Quest: Chocobo's Wounds, Save My Son, Path of the Beastmaster, Wings of gold, Scattered into Shadow, Chocobo on the Loose!
-- !pos -55 8 95 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pathOfTheBeastmaster = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.PATH_OF_THE_BEASTMASTER)
    local wingsOfGold = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
    local scatteredIntoShadow = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
    local scatteredIntoShadowStat = player:getCharVar("scatIntoShadowCS")

    local mLvl = player:getMainLvl()
    local mJob = player:getMainJob()

    -- WINGS OF GOLD
    if
        pathOfTheBeastmaster == QUEST_COMPLETED and
        wingsOfGold == QUEST_AVAILABLE and
        mJob == xi.job.BST and
        mLvl >= xi.settings.main.AF1_QUEST_LEVEL
    then
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
    elseif
        wingsOfGold == QUEST_COMPLETED and
        scatteredIntoShadow == QUEST_AVAILABLE and
        mJob == xi.job.BST and
        mLvl >= xi.settings.main.AF2_QUEST_LEVEL
    then
        if player:getCharVar("scatIntoShadow_shortCS") == 1 then
            player:startEvent(143)
        else
            player:setCharVar("scatIntoShadow_shortCS", 1)
            player:startEvent(141)
        end
    elseif scatteredIntoShadow == QUEST_ACCEPTED then
        if
            player:hasKeyItem(xi.ki.AQUAFLORA1) or
            player:hasKeyItem(xi.ki.AQUAFLORA2) or
            player:hasKeyItem(xi.ki.AQUAFLORA3)
        then
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
    elseif not player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.CHOCOBOS_WOUNDS) then
        player:startEvent(66, mLvl)
    end
end

entity.onEventFinish = function(player, csid, option)
    -- WINGS OF GOLD
    if (csid == 137 or csid == 139) and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD)
        player:setCharVar("wingsOfGold_shortCS", 0)
    elseif
        csid == 138 and
        npcUtil.completeQuest(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WINGS_OF_GOLD, { item = 16680, fame = 20 })
    then
        player:delKeyItem(xi.ki.GUIDING_BELL)

    -- SCATTERED INTO SHADOW
    elseif (csid == 141 or csid == 143) and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW)
        player:setCharVar("scatIntoShadow_shortCS", 0)
        npcUtil.giveKeyItem(player, { xi.ki.AQUAFLORA1, xi.ki.AQUAFLORA2, xi.ki.AQUAFLORA3 })
    elseif csid == 144 then
        player:setCharVar("scatIntoShadowCS", 1)
    elseif csid == 135 then
        npcUtil.completeQuest(player, xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SCATTERED_INTO_SHADOW, { item = 14097, fame = 40, var = "scatIntoShadowCS" })
    end
end

return entity
