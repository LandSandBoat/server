-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Maat
-- Starts and Finishes Quest: Limit Break Quest 1-5
-- Involved in Quests: Beat Around the Bushin
-- !pos 8 3 118 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/settings/main")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tradeCount = trade:getItemCount()

    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS) ~= QUEST_AVAILABLE and player:getMainLvl() >= 66 and player:getCharVar("maatsCap") < 1 then
        local mJob = player:getMainJob()
        if trade:hasItemQty(1425 + mJob, 1) and tradeCount == 1 and mJob <= 15 then
            player:startEvent(64, mJob) -- Teleport to battlefield for "Shattering Stars"
        end
    end

end

entity.onTrigger = function(player, npc)
    local LvL = player:getMainLvl()
    local mJob = player:getMainJob()
    local whenceBlowsTheWind = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)
    local ridingOnTheClouds = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
    local shatteringStars = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

    if player:getCharVar("BeatAroundTheBushin") == 5 then
        player:startEvent(117)

    elseif whenceBlowsTheWind == QUEST_AVAILABLE and LvL >= 56 and player:getLevelCap() == 60 and xi.settings.MAX_LEVEL >= 65 then
        player:startEvent(85) -- Start Quest "Whence Blows the Wind"

    elseif whenceBlowsTheWind == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.ORCISH_CREST) and player:hasKeyItem(xi.ki.QUADAV_CREST) and player:hasKeyItem(xi.ki.YAGUDO_CREST) then
            player:startEvent(87) -- Finish Quest "Whence Blows the Wind"
        else
            player:startEvent(86) -- During Quest "Whence Blows the Wind"
        end

    elseif ridingOnTheClouds == QUEST_AVAILABLE and LvL >= 61 and player:getLevelCap() == 65 and xi.settings.MAX_LEVEL >= 70 then
        local rand1 = math.random(0, 7)
        local rand2 = math.random(0, 7)
        local rand3 = math.random(0, 7)
        local rand4 = math.random(0, 7)
        player:setCharVar("ridingOnTheClouds_1", rand1 + 1); player:setCharVar("ridingOnTheClouds_2", rand2 + 1)
        player:setCharVar("ridingOnTheClouds_3", rand3 + 1); player:setCharVar("ridingOnTheClouds_4", rand4 + 1)

        player:startEvent(88, rand1, rand2, rand4, rand3, 180) -- Start Quest "Riding on the Clouds"

    elseif ridingOnTheClouds == QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SMILING_STONE) and player:hasKeyItem(xi.ki.SCOWLING_STONE) and player:hasKeyItem(xi.ki.SOMBER_STONE) and player:hasKeyItem(xi.ki.SPIRITED_STONE) then
            player:startEvent(90) -- Finish Quest "Riding on the Clouds"
        else
            local rand1 = player:getCharVar("ridingOnTheClouds_1")
            local rand2 = player:getCharVar("ridingOnTheClouds_2")
            local rand3 = player:getCharVar("ridingOnTheClouds_3")
            local rand4 = player:getCharVar("ridingOnTheClouds_4")
            if rand1 == 0 then
                rand1 = 8
            else
                rand1 = rand1 - 1
            end

            if rand2 == 0 then
                rand2 = 8
            else
                rand2 = rand2 - 1
            end

            if rand3 == 0 then
                rand3 = 8
            else
                rand3 = rand3 - 1
            end

            if rand4 == 0 then
                rand4 = 8
            else
                rand4 = rand4 - 1
            end

            player:startEvent(89, rand1, rand2, rand4, rand3, 180) -- During Quest "Riding on the Clouds"
        end

    elseif shatteringStars == QUEST_AVAILABLE and LvL >= 66 and mJob <= 15 and player:getLevelCap() == 70 and xi.settings.MAX_LEVEL >= 75 then
        player:startEvent(92, player:getMainJob()) -- Start Quest "Shattering Stars"

    elseif shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") == 0 then
        player:startEvent(91, player:getMainJob()) -- During Quest "Shattering Stars"

    elseif shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") >= 1 then
        player:startEvent(93) -- Finish Quest "Shattering Stars"

    elseif
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_SUN) == QUEST_AVAILABLE and
        mJob <= 15 and
        utils.mask.isFull(player:getCharVar("maatsCap"), 15) -- defeated maat on 15 jobs
    then
        player:startEvent(74) -- Finish Quest "Beyond The Sun"

    else
        player:showText(npc, ID.text.MAAT_DIALOG)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 117 then
        player:setCharVar("BeatAroundTheBushin", 6)

    -- Genkai 3
    elseif csid == 85 and option == 1 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)

    elseif csid == 87 then
        player:addTitle(xi.title.SKY_BREAKER)
        player:delKeyItem(xi.ki.ORCISH_CREST)
        player:delKeyItem(xi.ki.QUADAV_CREST)
        player:delKeyItem(xi.ki.YAGUDO_CREST)
        player:setLevelCap(65)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_65)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)
        player:addFame(JEUNO, 50)

    elseif csid == 88 then
        if option == 1 then
            player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
        else
            player:setCharVar("ridingOnTheClouds_1", 0)
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:setCharVar("ridingOnTheClouds_4", 0)
        end

    elseif csid == 90 then
        player:addTitle(xi.title.CLOUD_BREAKER)
        player:delKeyItem(xi.ki.SMILING_STONE)
        player:delKeyItem(xi.ki.SCOWLING_STONE)
        player:delKeyItem(xi.ki.SOMBER_STONE)
        player:delKeyItem(xi.ki.SPIRITED_STONE)
        player:setLevelCap(70)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_70)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
        player:addFame(JEUNO, 60)

    elseif csid == 92 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)

    elseif csid == 64 and option == 1 then
        local mJob = player:getMainJob()
        if mJob == xi.job.MNK or mJob == xi.job.WHM or mJob == xi.job.SMN then
            player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif mJob == xi.job.WAR or mJob == xi.job.BLM or mJob == xi.job.RNG then
            player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif mJob == xi.job.PLD or mJob == xi.job.DRK or mJob == xi.job.BRD then
            player:setPos(-225.146, -24.250, 20.057, 255, 206)
        elseif mJob == xi.job.RDM or mJob == xi.job.THF or mJob == xi.job.BST then
            player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif mJob == xi.job.SAM or mJob == xi.job.NIN or mJob == xi.job.DRG then
            player:setPos(-220.084, -0.645, 4.442, 191, 168)
        end

    elseif csid == 93 then
        player:addTitle(xi.title.STAR_BREAKER)
        player:setLevelCap(75)
        player:setCharVar("maatDefeated", 0)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHATTERING_STARS)
        player:addFame(JEUNO, 80)

    elseif csid == 74 then
        if player:getFreeSlotsCount() > 0 then
            player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.BEYOND_THE_SUN)
            player:addTitle(xi.title.ULTIMATE_CHAMPION_OF_THE_WORLD)
            player:setCharVar("maatsCap", 0)
            player:addItem(15194)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15194)
        end
    end
end

return entity
