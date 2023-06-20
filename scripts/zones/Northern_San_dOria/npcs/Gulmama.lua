-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Gulmama
-- Starts and Finishes Quest: Trial by Ice
-- Involved in Quest: Class Reunion
-- !pos -186 0 107 231
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local trialByIce = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
    local classReunion = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
    local classReunionProgress = player:getCharVar("ClassReunionProgress")

    -----------------------------------
    -- Class Reunion
    if classReunion == 1 and classReunionProgress == 4 then
        player:startEvent(713, 0, 1171, 0, 0, 0, 0, 0, 0) -- he gives you an ice pendulum and wants you to go to Cloister of Frost
    elseif
        classReunion == 1 and
        classReunionProgress == 5 and
        not player:hasItem(1171)
    then
        player:startEvent(712, 0, 1171, 0, 0, 0, 0, 0, 0) -- lost the ice pendulum need another one
    -----------------------------------
    elseif
        (trialByIce == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SANDORIA) >= 6) or
        (trialByIce == QUEST_COMPLETED and os.time() > player:getCharVar("TrialByIce_date"))
    then
        player:startEvent(706, 0, xi.ki.TUNING_FORK_OF_ICE) -- Start and restart quest "Trial by ice"
    elseif
        trialByIce == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_ICE) and
        not player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        player:startEvent(718, 0, xi.ki.TUNING_FORK_OF_ICE) -- Defeat against Shiva : Need new Fork
    elseif
        trialByIce == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        player:startEvent(707, 0, xi.ki.TUNING_FORK_OF_ICE, 4)
    elseif
        trialByIce == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WHISPER_OF_FROST)
    then
        local numitem = 0

        if player:hasItem(17492) then
            numitem = numitem + 1
        end  -- Shiva's Claws

        if player:hasItem(13242) then
            numitem = numitem + 2
        end  -- Ice Belt

        if player:hasItem(13561) then
            numitem = numitem + 4
        end  -- Ice Ring

        if player:hasItem(1207) then
            numitem = numitem + 8
        end   -- Rust 'B' Gone

        if player:hasSpell(302) then
            numitem = numitem + 32
        end  -- Ability to summon Shiva

        player:startEvent(709, 0, xi.ki.TUNING_FORK_OF_ICE, 4, 0, numitem)
    else
        player:startEvent(710) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 706 and option == 1 then
        if player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE) == QUEST_COMPLETED then
            player:delQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        end

        player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        player:setCharVar("TrialByIce_date", 0)
        player:addKeyItem(xi.ki.TUNING_FORK_OF_ICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_ICE)
    elseif csid == 718 then
        player:addKeyItem(xi.ki.TUNING_FORK_OF_ICE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_ICE)
    elseif csid == 709 then
        local item = 0

        if option == 1 then
            item = 17492 -- Shiva's Claws
        elseif option == 2 then
            item = 13242 -- Ice Belt
        elseif option == 3 then
            item = 13561 -- Ice Ring
        elseif option == 4 then
            item = 1207  -- Rust 'B' Gone
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(302) -- Avatar
                player:messageSpecial(ID.text.SHIVA_UNLOCKED, 0, 0, 4)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_ICE)
            player:delKeyItem(xi.ki.WHISPER_OF_FROST) --Whisper of Frost, as a trade for the above rewards
            player:setCharVar("TrialByIce_date", getMidnight())
            player:addFame(xi.quest.fame_area.SANDORIA, 30)
            player:completeQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.TRIAL_BY_ICE)
        end
    elseif csid == 713 or csid == 712 then
        if player:getFreeSlotsCount() ~= 0 then
            player:addItem(1171)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1171)
            player:setCharVar("ClassReunionProgress", 5)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1171)
        end
    end
end

return entity
