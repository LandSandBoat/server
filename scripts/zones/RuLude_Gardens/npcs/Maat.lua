-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Maat
-- Starts and Finishes Quest: Limit Break Quest 1-5
-- Involved in Quests: Beat Around the Bushin
-- !pos 8 3 118 243
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)
    local tradeCount = trade:getItemCount()
    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE) == QUEST_ACCEPTED) then
        -- Trade Bomb Coal / Exoray Mold / Ancient Papyrus
        if (trade:hasItemQty(1090, 1) and trade:hasItemQty(1089, 1) and trade:hasItemQty(1088, 1) and tradeCount == 3) then
            player:startEvent(81) -- Finish Quest "In Defiant Challenge"
        end
    end

    if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS) ~= QUEST_AVAILABLE and player:getMainLvl() >= 66 and player:getCharVar("maatsCap") < 1) then
        local mJob = player:getMainJob()
        if (trade:hasItemQty(1425 + mJob, 1) and tradeCount == 1 and mJob <= 15) then
            player:startEvent(64, mJob) -- Teleport to battlefield for "Shattering Stars"
        end
    end

end

function onTrigger(player, npc)

    local LvL = player:getMainLvl()
    local mJob = player:getMainJob()
    local inDefiantChallenge = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE)
    local atopTheHighestMountains = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS)
    local whenceBlowsTheWind = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)
    local ridingOnTheClouds = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
    local shatteringStars = player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS)

    if (player:getCharVar("BeatAroundTheBushin") == 5) then
        player:startEvent(117)
    elseif (inDefiantChallenge == QUEST_AVAILABLE and LvL >= 50 and player:levelCap() == 50 and MAX_LEVEL >= 55) then
        player:startEvent(79) -- Start Quest "In Defiant Challenge"
    elseif (inDefiantChallenge == QUEST_ACCEPTED) then
        player:startEvent(80) -- During Quest "In Defiant Challenge"
    elseif (atopTheHighestMountains == QUEST_AVAILABLE and LvL >= 51 and player:levelCap() == 55 and MAX_LEVEL >= 60) then
        player:startEvent(82) -- Start Quest "Atop the Highest Mountains"
    elseif (atopTheHighestMountains == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.ROUND_FRIGICITE) and player:hasKeyItem(tpz.ki.SQUARE_FRIGICITE) and player:hasKeyItem(tpz.ki.TRIANGULAR_FRIGICITE)) then
            player:startEvent(84) -- Finish Quest "Atop the Highest Mountains"
        else
            player:startEvent(83) -- During Quest "Atop the Highest Mountains"
        end
    elseif (whenceBlowsTheWind == QUEST_AVAILABLE and LvL >= 56 and player:levelCap() == 60 and MAX_LEVEL >= 65) then
        player:startEvent(85) -- Start Quest "Whence Blows the Wind"
    elseif (whenceBlowsTheWind == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.ORCISH_CREST) and player:hasKeyItem(tpz.ki.QUADAV_CREST) and player:hasKeyItem(tpz.ki.YAGUDO_CREST)) then
            player:startEvent(87) -- Finish Quest "Whence Blows the Wind"
        else
            player:startEvent(86) -- During Quest "Whence Blows the Wind"
        end
    elseif (ridingOnTheClouds == QUEST_AVAILABLE and LvL >= 61 and player:levelCap() == 65 and MAX_LEVEL >= 70) then
        rand1 = math.random(0, 7); rand2 = math.random(0, 7)
        rand3 = math.random(0, 7); rand4 = math.random(0, 7)
        player:setCharVar("ridingOnTheClouds_1", rand1 + 1); player:setCharVar("ridingOnTheClouds_2", rand2 + 1)
        player:setCharVar("ridingOnTheClouds_3", rand3 + 1); player:setCharVar("ridingOnTheClouds_4", rand4 + 1)

        player:startEvent(88, rand1, rand2, rand4, rand3, 180) -- Start Quest "Riding on the Clouds"
    elseif (ridingOnTheClouds == QUEST_ACCEPTED) then
        if (player:hasKeyItem(tpz.ki.SMILING_STONE) and player:hasKeyItem(tpz.ki.SCOWLING_STONE) and player:hasKeyItem(tpz.ki.SOMBER_STONE) and player:hasKeyItem(tpz.ki.SPIRITED_STONE)) then
            player:startEvent(90) -- Finish Quest "Riding on the Clouds"
        else
            rand1 = player:getCharVar("ridingOnTheClouds_1") ; rand2 = player:getCharVar("ridingOnTheClouds_2")
            rand3 = player:getCharVar("ridingOnTheClouds_3"); rand4 = player:getCharVar("ridingOnTheClouds_4")
            if (rand1 == 0) then rand1 = 8; else rand1 = rand1 - 1; end if (rand2 == 0) then rand2 = 8; else rand2 = rand2 - 1; end
            if (rand3 == 0) then rand3 = 8; else rand3 = rand3 - 1; end if (rand4 == 0) then rand4 = 8; else rand4 = rand4 - 1; end

            player:startEvent(89, rand1, rand2, rand4, rand3, 180) -- During Quest "Riding on the Clouds"
        end
    elseif (shatteringStars == QUEST_AVAILABLE and LvL >= 66 and mJob <= 15 and player:levelCap() == 70 and MAX_LEVEL >= 75) then
        player:startEvent(92, player:getMainJob()) -- Start Quest "Shattering Stars"
    elseif (shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") == 0) then
        player:startEvent(91, player:getMainJob()) -- During Quest "Shattering Stars"
    elseif (shatteringStars == QUEST_ACCEPTED and LvL >= 66 and mJob <= 15 and player:getCharVar("maatDefeated") >= 1) then
        player:startEvent(93) -- Finish Quest "Shattering Stars"
    elseif (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_SUN) == QUEST_AVAILABLE and mJob <= 15 and player:getCharVar("maatsCap") == 32767) then
        player:startEvent(74) -- Finish Quest "Beyond The Sun"
    else
        player:showText(npc, ID.text.MAAT_DIALOG)
    end

end

-- Maat cap: 74
function onEventUpdate(player, csid, option)
    -- printf("upCSID: %u", csid)
    -- printf("upRESULT: %u", option)
end

function onEventFinish(player, csid, option)

    if (csid == 117) then
        player:setCharVar("BeatAroundTheBushin", 6)
    -- Genkai 1
    elseif (csid == 79 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE)
    elseif (csid == 81) then
        player:tradeComplete()
        player:addTitle(tpz.title.HORIZON_BREAKER)
        player:levelCap(55)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.IN_DEFIANT_CHALLENGE)
        player:addFame(JEUNO, 30)
    -- Genkai 2
    elseif (csid == 82 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS)
    elseif (csid == 84) then
        player:addTitle(tpz.title.SUMMIT_BREAKER)
        player:delKeyItem(tpz.ki.ROUND_FRIGICITE)
        player:delKeyItem(tpz.ki.SQUARE_FRIGICITE)
        player:delKeyItem(tpz.ki.TRIANGULAR_FRIGICITE)
        player:levelCap(60)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_60)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.ATOP_THE_HIGHEST_MOUNTAINS)
        player:addFame(JEUNO, 40)
    -- Genkai 3
    elseif (csid == 85 and option == 1) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)
    elseif (csid == 87) then
        player:addTitle(tpz.title.SKY_BREAKER)
        player:delKeyItem(tpz.ki.ORCISH_CREST)
        player:delKeyItem(tpz.ki.QUADAV_CREST)
        player:delKeyItem(tpz.ki.YAGUDO_CREST)
        player:levelCap(65)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_65)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.WHENCE_BLOWS_THE_WIND)
        player:addFame(JEUNO, 50)
    elseif (csid == 88) then
        if (option == 1) then
            player:addQuest(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
        else
            player:setCharVar("ridingOnTheClouds_1", 0)
            player:setCharVar("ridingOnTheClouds_2", 0)
            player:setCharVar("ridingOnTheClouds_3", 0)
            player:setCharVar("ridingOnTheClouds_4", 0)
        end
    elseif (csid == 90) then
        player:addTitle(tpz.title.CLOUD_BREAKER)
        player:delKeyItem(tpz.ki.SMILING_STONE)
        player:delKeyItem(tpz.ki.SCOWLING_STONE)
        player:delKeyItem(tpz.ki.SOMBER_STONE)
        player:delKeyItem(tpz.ki.SPIRITED_STONE)
        player:levelCap(70)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_70)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.RIDING_ON_THE_CLOUDS)
        player:addFame(JEUNO, 60)
    elseif (csid == 92) then
        player:addQuest(JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS)
    elseif (csid == 64 and option == 1) then
        local mJob = player:getMainJob()
            if (mJob == tpz.job.MNK or mJob == tpz.job.WHM or mJob == tpz.job.SMN) then player:setPos(299.316, -123.591, 353.760, 66, 146)
        elseif (mJob == tpz.job.WAR or mJob == tpz.job.BLM or mJob == tpz.job.RNG) then player:setPos(-511.459, 159.004, -210.543, 10, 139)
        elseif (mJob == tpz.job.PLD or mJob == tpz.job.DRK or mJob == tpz.job.BRD) then player:setPos(-225.146, -24.250, 20.057, 255, 206)
        elseif (mJob == tpz.job.RDM or mJob == tpz.job.THF or mJob == tpz.job.BST) then player:setPos(-349.899, 104.213, -260.150, 0, 144)
        elseif (mJob == tpz.job.SAM or mJob == tpz.job.NIN or mJob == tpz.job.DRG) then player:setPos(-220.084, -0.645, 4.442, 191, 168); end
    elseif (csid == 93) then
        player:addTitle(tpz.title.STAR_BREAKER)
        player:levelCap(75)
        player:setCharVar("maatDefeated", 0)
        player:messageSpecial(ID.text.YOUR_LEVEL_LIMIT_IS_NOW_75)
        player:completeQuest(JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS)
        player:addFame(JEUNO, 80)
    elseif (csid==74) then
        if (player:getFreeSlotsCount() > 0) then
            player:completeQuest(JEUNO, tpz.quest.id.jeuno.BEYOND_THE_SUN)
            player:addTitle(tpz.title.ULTIMATE_CHAMPION_OF_THE_WORLD)
            player:setCharVar("maatsCap", 0)
            player:addItem(15194)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 15194)
        end
    end


end
