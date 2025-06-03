-----------------------------------
-- Area: Rabao
--  NPC: Agado-Pugado
-- Starts and Finishes Quest: Trial by Wind
-- !pos -17 7 -10 247
-----------------------------------
local ID = zones[xi.zone.RABAO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trialByWind = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
    local carbuncleDebacle = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)
    local carbuncleDebacleProgress = player:getCharVar('CarbuncleDebacleProgress')

    -----------------------------------
    -- Carbuncle Debacle
    if
        carbuncleDebacle == xi.questStatus.QUEST_ACCEPTED and
        carbuncleDebacleProgress == 5 and
        player:hasKeyItem(xi.ki.DAZE_BREAKER_CHARM)
    then
        player:startEvent(86) -- get the wind pendulum, lets go to Cloister of Gales
    elseif
        carbuncleDebacle == xi.questStatus.QUEST_ACCEPTED and
        carbuncleDebacleProgress == 6
    then
        if not player:hasItem(xi.item.WIND_PENDULUM) then
            player:startEvent(87, 0, xi.item.WIND_PENDULUM, 0, 0, 0, 0, 0, 0) -- "lost the pendulum?" This one too~???
        else
            player:startEvent(88) -- reminder to go to Cloister of Gales
        end
    -----------------------------------
    -- Trial by Wind
    elseif
        (trialByWind == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.SELBINA_RABAO) >= 5) or
        (trialByWind == xi.questStatus.QUEST_COMPLETED and os.time() > player:getCharVar('TrialByWind_date'))
    then
        player:startEvent(66, 0, 331) -- Start and restart quest 'Trial by Wind'
    elseif
        trialByWind == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_WIND) and
        not player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        player:startEvent(107, 0, 331) -- Defeat against Avatar : Need new Fork
    elseif
        trialByWind == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        player:startEvent(67, 0, 331, 3)
    elseif
        trialByWind == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        local numitem = 0

        if player:hasItem(xi.item.GARUDAS_DAGGER) then
            numitem = numitem + 1
        end  -- Garuda's Dagger

        if player:hasItem(xi.item.WIND_BELT) then
            numitem = numitem + 2
        end  -- Wind Belt

        if player:hasItem(xi.item.WIND_RING) then
            numitem = numitem + 4
        end  -- Wind Ring

        if player:hasItem(xi.item.BOTTLE_OF_BUBBLY_WATER) then
            numitem = numitem + 8
        end   -- Bubbly Water

        if player:hasSpell(xi.magic.spell.GARUDA) then
            numitem = numitem + 32
        end  -- Ability to summon Garuda

        player:startEvent(69, 0, 331, 3, 0, numitem)
    else
        player:startEvent(70) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 66 and option == 1 then
        if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND) == xi.questStatus.QUEST_COMPLETED then
            player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        end

        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        player:setCharVar('TrialByWind_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_WIND)
    elseif csid == 107 then
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_WIND)
    elseif csid == 69 then
        local item = 0
        if option == 1 then
            item = xi.item.GARUDAS_DAGGER
        elseif option == 2 then
            item = xi.item.WIND_BELT
        elseif option == 3 then
            item = xi.item.WIND_RING
        elseif option == 4 then
            item = xi.item.BOTTLE_OF_BUBBLY_WATER
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(xi.magic.spell.GARUDA) -- Garuda Spell
                player:messageSpecial(ID.text.GARUDA_UNLOCKED, 0, 0, 3)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_WIND)
            player:delKeyItem(xi.ki.WHISPER_OF_GALES) --Whisper of Gales, as a trade for the above rewards
            player:setCharVar('TrialByWind_date', getMidnight())
            player:addFame(xi.fameArea.SELBINA_RABAO, 30)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        end
    elseif csid == 86 or csid == 87 then
        if player:getFreeSlotsCount() ~= 0 then
            player:addItem(xi.item.WIND_PENDULUM)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.WIND_PENDULUM)
            player:setCharVar('CarbuncleDebacleProgress', 6)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.WIND_PENDULUM)
        end
    end
end

return entity
