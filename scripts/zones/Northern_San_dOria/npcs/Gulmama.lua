-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Gulmama
-- Starts and Finishes Quest: Trial by Ice
-- Involved in Quest: Class Reunion
-- !pos -186 0 107 231
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local trialByIce = player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
    local classReunion = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
    local classReunionProgress = player:getCharVar('ClassReunionProgress')

    -----------------------------------
    -- Class Reunion
    if classReunion == 1 and classReunionProgress == 4 then
        player:startEvent(713, 0, xi.item.ICE_PENDULUM, 0, 0, 0, 0, 0, 0) -- he gives you an ice pendulum and wants you to go to Cloister of Frost
    elseif
        classReunion == 1 and
        classReunionProgress == 5 and
        not player:hasItem(xi.item.ICE_PENDULUM)
    then
        player:startEvent(712, 0, xi.item.ICE_PENDULUM, 0, 0, 0, 0, 0, 0) -- lost the ice pendulum need another one
    -----------------------------------
    elseif
        (trialByIce == xi.questStatus.QUEST_AVAILABLE and player:getFameLevel(xi.fameArea.SANDORIA) >= 6) or
        (trialByIce == xi.questStatus.QUEST_COMPLETED and os.time() > player:getCharVar('TrialByIce_date'))
    then
        player:startEvent(706, 0, xi.ki.TUNING_FORK_OF_ICE) -- Start and restart quest 'Trial by ice'
    elseif
        trialByIce == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_ICE) and
        not player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        player:startEvent(718, 0, xi.ki.TUNING_FORK_OF_ICE) -- Defeat against Shiva : Need new Fork
    elseif
        trialByIce == xi.questStatus.QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        player:startEvent(707, 0, xi.ki.TUNING_FORK_OF_ICE, 4)
    elseif
        trialByIce == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        local numitem = 0

        if player:hasItem(xi.item.SHIVAS_CLAWS) then
            numitem = numitem + 1
        end  -- Shiva's Claws

        if player:hasItem(xi.item.ICE_BELT) then
            numitem = numitem + 2
        end  -- Ice Belt

        if player:hasItem(xi.item.ICE_RING) then
            numitem = numitem + 4
        end  -- Ice Ring

        if player:hasItem(xi.item.BOTTLE_OF_RUST_B_GONE) then
            numitem = numitem + 8
        end   -- Rust 'B' Gone

        if player:hasSpell(xi.magic.spell.SHIVA) then
            numitem = numitem + 32
        end  -- Ability to summon Shiva

        player:startEvent(709, 0, xi.ki.TUNING_FORK_OF_ICE, 4, 0, numitem)
    else
        player:startEvent(710) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 706 and option == 1 then
        if player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE) == xi.questStatus.QUEST_COMPLETED then
            player:delQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        end

        player:addQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        player:setCharVar('TrialByIce_date', 0)
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_ICE)
    elseif csid == 718 then
        npcUtil.giveKeyItem(player, xi.ki.TUNING_FORK_OF_ICE)
    elseif csid == 709 then
        local item = 0

        if option == 1 then
            item = xi.item.SHIVAS_CLAWS -- Shiva's Claws
        elseif option == 2 then
            item = xi.item.ICE_BELT -- Ice Belt
        elseif option == 3 then
            item = xi.item.ICE_RING -- Ice Ring
        elseif option == 4 then
            item = xi.item.BOTTLE_OF_RUST_B_GONE  -- Rust 'B' Gone
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(xi.magic.spell.SHIVA) -- Avatar
                player:messageSpecial(ID.text.SHIVA_UNLOCKED, 0, 0, 4)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_ICE)
            player:delKeyItem(xi.ki.WHISPER_OF_FROST) --Whisper of Frost, as a trade for the above rewards
            player:setCharVar('TrialByIce_date', getMidnight())
            player:addFame(xi.fameArea.SANDORIA, 30)
            player:completeQuest(xi.questLog.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        end
    elseif csid == 713 or csid == 712 then
        if player:getFreeSlotsCount() ~= 0 then
            player:addItem(xi.item.ICE_PENDULUM)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.ICE_PENDULUM)
            player:setCharVar('ClassReunionProgress', 5)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.ICE_PENDULUM)
        end
    end
end

return entity
