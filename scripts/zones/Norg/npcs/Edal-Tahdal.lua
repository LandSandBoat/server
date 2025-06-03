-----------------------------------
-- Area: Norg
--  NPC: Edal-Tahdal
-- Starts and Finishes Quest: Trial by Water
-- !pos -13 1 -20 252
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trialByWater = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
    local hasWhisperOfTides = player:hasKeyItem(xi.ki.WHISPER_OF_TIDES)

    if
        (trialByWater == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.NORG) >= 4) or
        (trialByWater == xi.questStatus.QUEST_COMPLETED and os.time() > player:getCharVar('TrialByWater_date'))
    then
        player:startEvent(109, 0, xi.ki.TUNING_FORK_OF_WATER) -- Start and restart quest 'Trial by Water'
    elseif
        trialByWater == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_WATER) and
        not hasWhisperOfTides
    then
        player:startEvent(190, 0, xi.ki.TUNING_FORK_OF_WATER) -- Defeat against Avatar : Need new Fork
    elseif trialByWater == xi.questStatus.QUEST_ACCEPTED and not hasWhisperOfTides then
        player:startEvent(110, 0, xi.ki.TUNING_FORK_OF_WATER, 2)
    elseif trialByWater == xi.questStatus.QUEST_ACCEPTED and hasWhisperOfTides then
        local numitem = 0

        if player:hasItem(xi.item.LEVIATHANS_ROD) then
            numitem = numitem + 1
        end

        if player:hasItem(xi.item.WATER_BELT) then
            numitem = numitem + 2
        end

        if player:hasItem(xi.item.WATER_RING) then
            numitem = numitem + 4
        end

        if player:hasItem(xi.item.EYE_OF_NEPT) then
            numitem = numitem + 8
        end

        if player:hasSpell(xi.magic.spell.LEVIATHAN) then
            numitem = numitem + 32
        end  -- Ability to summon Leviathan

        player:startEvent(112, 0, xi.ki.TUNING_FORK_OF_WATER, 2, 0, numitem)
    else
        player:startEvent(113) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 109 and option == 1 then
        if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER) == xi.questStatus.QUEST_COMPLETED then
            player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
        end

        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
        player:setCharVar('TrialByWater_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_WATER)
    elseif csid == 190 then
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_WATER)
    elseif csid == 112 then
        local item = 0
        if option == 1 then
            item = xi.item.LEVIATHANS_ROD
        elseif option == 2 then
            item = xi.item.WATER_BELT
        elseif option == 3 then
            item = xi.item.WATER_RING
        elseif option == 4 then
            item = xi.item.EYE_OF_NEPT
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(xi.magic.spell.LEVIATHAN) -- Avatar
                player:messageSpecial(ID.text.AVATAR_UNLOCKED, 0, 0, 2)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_WATER)
            player:delKeyItem(xi.ki.WHISPER_OF_TIDES) --Whisper of Tides, as a trade for the above rewards
            player:setCharVar('TrialByWater_date', getMidnight())
            player:addFame(xi.fameArea.NORG, 30)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WATER)
        end
    end
end

return entity
