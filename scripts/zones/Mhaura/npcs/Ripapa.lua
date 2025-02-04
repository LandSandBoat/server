-----------------------------------
-- Area: Mhaura
--  NPC: Ripapa
-- Starts and Finishes Quest: Trial by Lightning
-- !pos 29 -15 55 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trialByLightning = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
    local hasWhisperOfStorms = player:hasKeyItem(xi.ki.WHISPER_OF_STORMS)
    local carbuncleDebacle = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)
    local carbuncleDebacleProgress = player:getCharVar('CarbuncleDebacleProgress')

    -----------------------------------
    -- Carbunlce Debacle
    if
        carbuncleDebacle == xi.questStatus.QUEST_ACCEPTED and
        carbuncleDebacleProgress == 2
    then
        player:startEvent(10022) -- get the lighning pendulum lets go to Cloister of Storms
    elseif
        carbuncleDebacle == xi.questStatus.QUEST_ACCEPTED and
        carbuncleDebacleProgress == 3 and
        not player:hasItem(xi.item.LIGHTNING_PENDULUM)
    then
        player:startEvent(10023, 0, xi.item.LIGHTNING_PENDULUM, 0, 0, 0, 0, 0, 0) -- "lost the pendulum?"
    -----------------------------------
    -- Trial by Lightning
    elseif
        (trialByLightning == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.WINDURST) >= 6) or
        (trialByLightning == xi.questStatus.QUEST_COMPLETED and os.time() > player:getCharVar('TrialByLightning_date'))
    then
        player:startEvent(10016, 0, xi.ki.TUNING_FORK_OF_LIGHTNING) -- Start and restart quest "Trial by Lightning"
    elseif
        trialByLightning == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_LIGHTNING) and
        not hasWhisperOfStorms
    then
        player:startEvent(10024, 0, xi.ki.TUNING_FORK_OF_LIGHTNING) -- Defeat against Ramuh : Need new Fork
    elseif
        trialByLightning == xi.questStatus.QUEST_ACCEPTED and
        not hasWhisperOfStorms
    then
        player:startEvent(10017, 0, xi.ki.TUNING_FORK_OF_LIGHTNING, 5)
    elseif
        trialByLightning == xi.questStatus.QUEST_ACCEPTED and
        hasWhisperOfStorms
    then
        local numitem = 0

        if player:hasItem(xi.item.RAMUHS_STAFF) then
            numitem = numitem + 1
        end

        if player:hasItem(xi.item.LIGHTNING_BELT) then
            numitem = numitem + 2
        end

        if player:hasItem(xi.item.LIGHTNING_RING) then
            numitem = numitem + 4
        end

        if player:hasItem(xi.item.ELDER_BRANCH) then
            numitem = numitem + 8
        end

        if player:hasSpell(xi.magic.spell.RAMUH) then
            numitem = numitem + 32
        end  -- Ability to summon Ramuh

        player:startEvent(10019, 0, xi.ki.TUNING_FORK_OF_LIGHTNING, 5, 0, numitem)
    else
        player:startEvent(10020) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10016 and option == 1 then
        if player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING) == xi.questStatus.QUEST_COMPLETED then
            player:delQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
        end

        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
        player:setCharVar('TrialByLightning_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_LIGHTNING)
    elseif csid == 10024 then
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_LIGHTNING)
    elseif csid == 10019 then
        local item = 0
        if option == 1 then
            item = xi.item.RAMUHS_STAFF
        elseif option == 2 then
            item = xi.item.LIGHTNING_BELT
        elseif option == 3 then
            item = xi.item.LIGHTNING_RING
        elseif option == 4 then
            item = xi.item.ELDER_BRANCH
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(xi.magic.spell.RAMUH) -- Ramuh Spell
                player:messageSpecial(ID.text.RAMUH_UNLOCKED, 0, 0, 5)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_LIGHTNING)
            player:delKeyItem(xi.ki.WHISPER_OF_STORMS) --Whisper of Storms, as a trade for the above rewards
            player:setCharVar('TrialByLightning_date', getMidnight())
            player:addFame(xi.fameArea.WINDURST, 30)
            player:completeQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.TRIAL_BY_LIGHTNING)
        end
    elseif csid == 10022 or csid == 10023 then
        if player:getFreeSlotsCount() ~= 0 then
            player:addItem(xi.item.LIGHTNING_PENDULUM)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.LIGHTNING_PENDULUM)
            player:setCharVar('CarbuncleDebacleProgress', 3)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.LIGHTNING_PENDULUM)
        end
    end
end

return entity
