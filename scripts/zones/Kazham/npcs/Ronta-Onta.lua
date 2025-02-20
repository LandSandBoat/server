-----------------------------------
-- Area: Kazham
--  NPC: Ronta-Onta
-- Starts and Finishes Quest: Trial by Fire
-- !pos 100 -15 -97 250
-----------------------------------
local ID = zones[xi.zone.KAZHAM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trialByFire = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
    local hasWhisperOfFlames = player:hasKeyItem(xi.ki.WHISPER_OF_FLAMES)

    if
        (trialByFire == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.WINDURST) >= 6) or
        (trialByFire == xi.questStatus.QUEST_COMPLETED and os.time() > player:getCharVar('TrialByFire_date'))
    then
        player:startEvent(270, 0, xi.ki.TUNING_FORK_OF_FIRE) -- Start and restart quest "Trial by Fire"
    elseif
        trialByFire == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_FIRE) and
        not hasWhisperOfFlames
    then
        player:startEvent(285, 0, xi.ki.TUNING_FORK_OF_FIRE) -- Defeat against Ifrit : Need new Fork
    elseif trialByFire == xi.questStatus.QUEST_ACCEPTED and not hasWhisperOfFlames then
        player:startEvent(271, 0, xi.ki.TUNING_FORK_OF_FIRE, 0)
    elseif trialByFire == xi.questStatus.QUEST_ACCEPTED and hasWhisperOfFlames then
        local numitem = 0

        if player:hasItem(xi.item.IFRITS_BLADE) then
            numitem = numitem + 1
        end

        if player:hasItem(xi.item.FIRE_BELT) then
            numitem = numitem + 2
        end

        if player:hasItem(xi.item.FIRE_RING) then
            numitem = numitem + 4
        end

        if player:hasItem(xi.item.EGILS_TORCH) then
            numitem = numitem + 8
        end

        if player:hasSpell(xi.magic.spell.IFRIT) then
            numitem = numitem + 32
        end  -- Ability to summon Ifrit

        player:startEvent(273, 0, xi.ki.TUNING_FORK_OF_FIRE, 0, 0, numitem)
    else
        player:startEvent(274) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 270 and option == 1 then
        if player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE) == xi.questStatus.QUEST_COMPLETED then
            player:delQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
        end

        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
        player:setCharVar('TrialByFire_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_FIRE)
    elseif csid == 285 then
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_FIRE)
    elseif csid == 273 then
        local item = 0
        if option == 1 then
            item = xi.item.IFRITS_BLADE
        elseif option == 2 then
            item = xi.item.FIRE_BELT
        elseif option == 3 then
            item = xi.item.FIRE_RING
        elseif option == 4 then
            item = xi.item.EGILS_TORCH
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(xi.magic.spell.IFRIT) -- Ifrit Spell
                player:messageSpecial(ID.text.IFRIT_UNLOCKED, 0, 0, 0)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_FIRE)
            player:delKeyItem(xi.ki.WHISPER_OF_FLAMES)
            player:setCharVar('TrialByFire_date', getMidnight())
            player:addFame(xi.fameArea.WINDURST, 30)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_FIRE)
        end
    end
end

return entity
