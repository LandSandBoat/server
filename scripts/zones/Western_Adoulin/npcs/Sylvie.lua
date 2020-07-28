-----------------------------------
--  Area: Western Adoulin (256)
--   NPC: Sylvie
--  Type: NPC
--  Starts Dances with Luopans
--  !pos 78.094 32.000 135.725
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
local ID = require("scripts/zones/Western_Adoulin/IDs")

function onTrade(player, npc, trade)
    -- DANCES WITH LUOPANS
    if player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS) == QUEST_ACCEPTED then
        if player:hasKeyItem(tpz.ki.FISTFUL_OF_HOMELAND_SOIL) and npcUtil.tradeHas(trade, 703) then -- Petrified Log
            player:startEvent(34)
        end
    end
end

function onTrigger(player, npc)
    -- Buying a replacement Matre Bell on Geomancer
    if player:getLocalVar("Sylvie_Need_Zone") == 0 and player:getMainJob() == tpz.job.GEO and not player:hasItem(21460) then  -- Matre Bell
        player:setLocalVar("Sylvie_Need_Zone", 1)
        player:startEvent(37)
        return
    end

    -- DANCES WITH LUOPANS
    local dwlQuestStatus = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS)
    if dwlQuestStatus == QUEST_COMPLETED then
        player:startEvent(39)
    elseif player:getCharVar("GEO_DWL_Luopan") == 1 then
        player:startEvent(36)
    elseif dwlQuestStatus == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.LUOPAN) then
        player:startEvent(35)
    elseif dwlQuestStatus == QUEST_ACCEPTED then
        player:startEvent(33)
    elseif player:getCharVar("GEO_DWL_Triggered") == 1 then
        player:startEvent(32)
    elseif dwlQuestStatus == QUEST_AVAILABLE and player:getMainLvl() >= ADVANCED_JOB_LEVEL then
        player:startEvent(31)
    else
        player:startEvent(38)  -- Standard dialog
    end
end

function onEventUpdate(player, csid, option)
    -- Buying a replacement Matre Bell on Geomancer
    if csid == 37 and (option == 1 or option == 2) then
        local eventUpdateParam = 0  -- 0 = can't afford, 1 = success, 2 = full inventory
        if player:getFreeSlotsCount() < 1 then
            eventUpdateParam = 2
        elseif (option == 1 and player:getGil() >= 300000) or (option == 2 and player:getCurrency('bayld') >= 150000) then
            player:setLocalVar("Sylvie_Matre_Bell", option)
            eventUpdateParam = 1
        end
        player:updateEvent(0, 0, 0, 0, 0, 0, 0, eventUpdateParam)
    end
end

function onEventFinish(player, csid, option)
    -- DANCES WITH LUOPANS
    if csid == 31 or csid == 32 then
        if option == 0 then
            player:setCharVar("GEO_DWL_Triggered", 1)
        elseif option == 1 then
            player:setCharVar("GEO_DWL_Triggered", 0)
            player:addQuest(ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS)
        end
    elseif csid == 34 then
        player:confirmTrade()
        player:delKeyItem(tpz.ki.FISTFUL_OF_HOMELAND_SOIL)
        npcUtil.giveKeyItem(player, tpz.ki.LUOPAN)
    elseif csid == 36 then
        if npcUtil.giveItem(player, { 6074, 21460 }) then -- 'plate of Indi-Poison' and 'Matre Bell'
            player:unlockJob(tpz.job.GEO)
            player:messageSpecial(ID.text.YOU_CAN_NOW_BECOME, 0)  -- You can now become a geomancer!
            npcUtil.giveKeyItem(player, tpz.ki.JOB_GESTURE_GEOMANCER)
            player:setCharVar("GEO_DWL_Luopan", 0)
            player:completeQuest(ADOULIN, tpz.quest.id.adoulin.DANCES_WITH_LUOPANS)
        end
    end

    -- Buying replacement Matre Bell on Geomancer
    if csid == 37 and option == 1 then
        local purchaseOption = player:getLocalVar("Sylvie_Matre_Bell")
        if purchaseOption ~= 0 and npcUtil.giveItem(player, { 21460 }) then -- 'Matre Bell'
            player:setLocalVar("Sylvie_Matre_Bell", 0)
            if purchaseOption == 1 then  -- gil
                player:setGil(player:getGil() - 300000)
            elseif purchaseOption == 2 then  -- bayld
                player:setCurrency('bayld', player:getCurrency('bayld') - 150000)
            end
        end
    end
end
