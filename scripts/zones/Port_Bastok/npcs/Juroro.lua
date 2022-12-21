-----------------------------------
-- Area: Port Bastok
--  NPC: Juroro
-- Starts and Finishes Quest: Trial by Earth
-- !pos 32 7 -41 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
local ID = require("scripts/zones/Port_Bastok/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local trialByEarth = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
    local hasWhisperOfTremors = player:hasKeyItem(xi.ki.WHISPER_OF_TREMORS)

    if
        (trialByEarth == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.BASTOK) >= 6) or
        (trialByEarth == QUEST_COMPLETED and os.time() > player:getCharVar("TrialByEarth_date"))
    then
        player:startEvent(249, 0, xi.ki.TUNING_FORK_OF_EARTH) -- Start and restart quest "Trial by Earth"
    elseif
        trialByEarth == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_EARTH) and
        not hasWhisperOfTremors
    then
        player:startEvent(284, 0, xi.ki.TUNING_FORK_OF_EARTH) -- Defeat against Titan : Need new Fork
    elseif trialByEarth == QUEST_ACCEPTED and not hasWhisperOfTremors then
        player:startEvent(250, 0, xi.ki.TUNING_FORK_OF_EARTH, 1)
    elseif trialByEarth == QUEST_ACCEPTED and hasWhisperOfTremors then
        local numitem = 0

        if player:hasItem(17438) then
            numitem = numitem + 1
        end  -- Titan's Cudgel

        if player:hasItem(13244) then
            numitem = numitem + 2
        end  -- Earth Belt

        if player:hasItem(13563) then
            numitem = numitem + 4
        end  -- Earth Ring

        if player:hasItem(1205) then
            numitem = numitem + 8
        end   -- Desert Light

        if player:hasSpell(299) then
            numitem = numitem + 32
        end  -- Ability to summon Titan

        player:startEvent(252, 0, xi.ki.TUNING_FORK_OF_EARTH, 1, 0, numitem)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 249 and option == 1 then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH) == QUEST_COMPLETED then
            player:delQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
        end

        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
        player:setCharVar("TrialByEarth_date", 0)
        player:addKeyItem(xi.ki.TUNING_FORK_OF_EARTH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_EARTH)
    elseif csid == 284 then
        player:addKeyItem(xi.ki.TUNING_FORK_OF_EARTH)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_EARTH)
    elseif csid == 252 then
        local item = 0
        if option == 1 then
            item = 17438         -- Titan's Cudgel
        elseif option == 2 then
            item = 13244  -- Earth Belt
        elseif option == 3 then
            item = 13563  -- Earth Ring
        elseif option == 4 then
            item = 1205     -- Desert Light
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(299) -- Avatar Titan Spell
                player:messageSpecial(ID.text.TITAN_UNLOCKED, 0, 0, 1)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_EARTH)
            player:delKeyItem(xi.ki.WHISPER_OF_TREMORS) --Whisper of Tremors, as a trade for the above rewards
            player:setCharVar("TrialByEarth_date", getMidnight())
            player:addFame(xi.quest.fame_area.BASTOK, 30)
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TRIAL_BY_EARTH)
        end
    end
end

return entity
