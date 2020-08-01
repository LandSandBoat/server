-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Waoud
-- Standard Info NPC
-- Involved in quests: An Empty Vessel (BLU Unlock), Beginnings (BLU AF Quest 1), Omens (BLU AF Quest 2)
-- !pos 65 -6 -78 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/npc_util")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local anEmptyVessel = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
    local anEmptyVesselProgress = player:getCharVar("AnEmptyVesselProgress")
    local StoneID = player:getCharVar("EmptyVesselStone")

    -- AN EMPTY VESSEL (dangruf stone, valkurm sunsand, or siren's tear)
    if anEmptyVessel == QUEST_ACCEPTED and anEmptyVesselProgress == 3 and trade:hasItemQty(StoneID, 1) and trade:getItemCount() == 1 then
        player:startEvent(67, StoneID) -- get the stone to Aydeewa
    end
end

function onTrigger(player, npc)
    local anEmptyVessel = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
    local anEmptyVesselProgress = player:getCharVar("AnEmptyVesselProgress")
    local divinationReady = vanaDay() > player:getCharVar("LastDivinationDay")
    local beginnings = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS)
    local omens = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)
    local transformations = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.TRANSFORMATIONS)
    local transformationsProgress = player:getCharVar("TransformationsProgress")
    local currentJob = player:getMainJob()
    local waoudNeedToZone = player:getLocalVar("WaoudNeedToZone")

    -- AN EMPTY VESSEL
    if anEmptyVessel == QUEST_AVAILABLE and anEmptyVesselProgress <= 1 and player:getMainLvl() >= ADVANCED_JOB_LEVEL then
        if divinationReady then
            player:startEvent(60, player:getGil()) -- you must answer these 10 questions
        else
            player:startEvent(63) -- you failed, and must wait a gameday to try again
        end
    elseif anEmptyVesselProgress == 2 then
        if divinationReady and waoudNeedToZone == 0 then
            player:startEvent(65) -- gives you a clue about the stone he wants (specific conditions)
        else -- Have not zoned, or have not waited, or both.
            player:startEvent(64) -- you have succeeded, but you need to wait a gameday and zone
        end
    elseif anEmptyVesselProgress == 3 then
        player:startEvent(66) -- reminds you about the item he wants
    elseif anEmptyVesselProgress == 4 then
        player:startEvent(68) -- reminds you to bring the item to Aydeewa
    elseif anEmptyVessel == QUEST_COMPLETED and beginnings == QUEST_AVAILABLE and player:getCharVar("BluAFBeginnings_Waoud") == 0 then
        player:startEvent(69) -- closing cutscene

    -- BEGINNINGS
    elseif anEmptyVessel == QUEST_COMPLETED and beginnings == QUEST_AVAILABLE and player:getCurrentMission(TOAU) > tpz.mission.id.toau.IMMORTAL_SENTRIES
            and currentJob == tpz.job.BLU and player:getMainLvl() >= AF1_QUEST_LEVEL then
        if divinationReady then
            if waoudNeedToZone == 1 then
                player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
            else
                player:startEvent(705) -- start Beginnings
            end
        else
           player:startEvent(63) 
        end
    elseif beginnings == QUEST_ACCEPTED then
        local brand1 = player:hasKeyItem(tpz.ki.BRAND_OF_THE_SPRINGSERPENT)
        local brand2 = player:hasKeyItem(tpz.ki.BRAND_OF_THE_GALESERPENT)
        local brand3 = player:hasKeyItem(tpz.ki.BRAND_OF_THE_FLAMESERPENT)
        local brand4 = player:hasKeyItem(tpz.ki.BRAND_OF_THE_SKYSERPENT)
        local brand5 = player:hasKeyItem(tpz.ki.BRAND_OF_THE_STONESERPENT)
        if brand1 and brand2 and brand3 and brand4 and brand5 then
            player:startEvent(707) -- reward immortal's scimitar
        else
            player:startEvent(706, player:getGil()) -- clue about the five staging points, costs you 1000 gil
        end

    -- OMENS
    elseif beginnings == QUEST_COMPLETED and omens == QUEST_AVAILABLE and currentJob == tpz.job.BLU and player:getMainLvl() >= AF2_QUEST_LEVEL then
        if divinationReady then
            if waoudNeedToZone == 1 then
                player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
            else
                player:startEvent(710) -- start Omens
            end
        else
           player:startEvent(63) 
        end
    elseif omens == QUEST_ACCEPTED then
        if player:getCharVar("OmensProgress") == 1 then
            player:startEvent(711, player:getGil()) -- clue about bcnm location, costs you 1000 gil
        elseif player:getCharVar("OmensProgress") == 2 then
            player:startEvent(712) -- gives keyitem to claim armour piece
        elseif player:getCharVar("OmensProgress") >= 3 then
            player:startEvent(713, player:getGil()) -- clue about location of armour piece, costs you 1000 gil
        end

    -- TRANSFORMATIONS
    elseif omens == QUEST_COMPLETED and transformations == QUEST_AVAILABLE and currentJob == tpz.job.BLU then
        if divinationReady then
            if waoudNeedToZone == 1 then
                player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
            elseif transformationsProgress == 1 then
                player:startEvent(721, player:getGil())
            else
                player:startEvent(720, player:getGil()) -- starts Transformations
            end
        else
           player:startEvent(63) 
        end
    elseif transformations == QUEST_ACCEPTED then
        player:startEvent(723, player:getGil()) -- clue about possible route to take, costs you 1000 gil
    -- DEFAULT DIALOG
    elseif anEmptyVessel == QUEST_COMPLETED then
        if divinationReady then
            player:startEvent(78, player:getGil()) -- dummy questions, costs you 1000 gil
        else
            player:startEvent(63) 
        end
    else
        player:startEvent(61)
    end
end

function onEventUpdate(player, csid, option)
    -- AN EMPTY VESSEL
    if csid == 60 then
        local success = player:getLocalVar("SuccessfullyAnswered")

        -- record correct answers
        if option < 40 then
            local correctAnswers = {2, 6, 9, 12, 13, 18, 21, 24, 26, 30}
            for k, v in pairs(correctAnswers) do
                if (v == option) then
                    player:setLocalVar("SuccessfullyAnswered", success + 1)
                    break
                end
            end

        -- determine results
        elseif option == 40 then
            if     success <  2 then player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, 10) -- Springserpent
            elseif success <  4 then player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, 20) -- Stoneserpent
            elseif success <  6 then player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, 30) -- Galeserpent
            elseif success <  8 then player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, 40) -- Flameserpent
            elseif success < 10 then player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, 60) -- Skyserpent
            else
                local rand = math.random(1, 3)
                switch (rand): caseof {
                    [1] = function (x) player:setCharVar("EmptyVesselStone", 576) end, -- (576) Siren's Tear (576)
                    [2] = function (x) player:setCharVar("EmptyVesselStone", 503) end, -- (502) Valkurm Sunsand (502)
                    [3] = function (x) player:setCharVar("EmptyVesselStone", 553) end  -- (553) Dangruf Stone (553)
                }
                player:setLocalVar("SuccessfullyAnswered", 0)
                player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, rand, 70) -- all 5 serpents / success!
            end
        end
    elseif csid == 65 and option == 2 then
        player:setCharVar("AnEmptyVesselProgress", 3)

    -- BEGINNINGS
    elseif csid == 78 and option == 40 then
        local serpent = math.random(1, 5) * 10
        player:updateEvent(player:getGil(), 0, 0, 0, 0, 0, 0, serpent)

    end
end

function onEventFinish(player, csid, option)
    local beginnings = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS)
    local omens = player:getQuestStatus(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)
    local omensProgress = player:getCharVar("OmensProgress")
    local transformationsProgress = player:getCharVar("TransformationsProgress")

    -- AN EMPTY VESSEL
    if csid == 60 then
        player:setLocalVar("SuccessfullyAnswered", 0)
        if option == 0 then
            player:setCharVar("AnEmptyVesselProgress", 1)
        elseif option == 50 then
            player:setLocalVar("waoudNeedToZone", 1)
            player:setCharVar("LastDivinationDay", vanaDay())
            player:setCharVar("AnEmptyVesselProgress", 2)
            player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.AN_EMPTY_VESSEL)
        elseif player:getGil() >= 1000 then
            player:setCharVar("LastDivinationDay", vanaDay())
            player:setCharVar("AnEmptyVesselProgress", 1)
            player:delGil(1000)
            player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
        end
    elseif csid == 67 then -- Turn in stone, go to Aydeewa
        player:setCharVar("AnEmptyVesselProgress", 4)
    elseif csid == 69 and option == 1 then
        player:setLocalVar("waoudNeedToZone", 1)
        player:setCharVar("LastDivinationDay", vanaDay())
        player:setCharVar("BluAFBeginnings_Waoud", 1)

    -- BEGINNINGS
    elseif csid == 78 and option == 1 and player:getGil() >= 1000 then
        player:setCharVar("LastDivinationDay", vanaDay())
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 705 and option == 1 then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS)
    elseif csid == 706 and option == 1 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 707 then
        npcUtil.completeQuest(player, AHT_URHGAN, tpz.quest.id.ahtUrhgan.BEGINNINGS, {item=17717})

    -- OMENS
    elseif csid == 710 and beginnings == QUEST_COMPLETED then
        player:addQuest(AHT_URHGAN, tpz.quest.id.ahtUrhgan.OMENS)
        player:setCharVar("OmensProgress", 1)
    elseif csid == 711 and option == 1 and omensProgress == 1 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 712 and omensProgress == 2 then
        npcUtil.giveKeyItem(player, tpz.ki.SEALED_IMMORTAL_ENVELOPE)
        player:setCharVar("OmensProgress", 3)
    elseif csid == 713 and option == 1 and omensProgress == 3 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.

    -- TRANSFORMATIONS
    elseif (csid == 720 or csid == 721) and option == 1 and player:getGil() >= 1000 then
        if csid == 720 then
            player:setCharVar("TransformationsProgress", 1)
        end
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    elseif csid == 723 and option == 1 and TransformationsProgress == 2 and player:getGil() >= 1000 then
        player:delGil(1000)
        player:messageSpecial(ID.text.PAY_DIVINATION) -- You pay 1000 gil for the divination.
    end
end
