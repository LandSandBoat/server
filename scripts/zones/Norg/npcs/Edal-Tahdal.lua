-----------------------------------
-- Area: Norg
--  NPC: Edal-Tahdal
-- Starts and Finishes Quest: Trial by Water
-- !pos -13 1 -20 252
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Norg/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local TrialByWater = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER)
    local WhisperOfTides = player:hasKeyItem(tpz.ki.WHISPER_OF_TIDES)
    local realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day

    if ((TrialByWater == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 4) or (TrialByWater == QUEST_COMPLETED and realday ~= player:getCharVar("TrialByWater_date"))) then
        player:startEvent(109, 0, tpz.ki.TUNING_FORK_OF_WATER) -- Start and restart quest "Trial by Water"
    elseif (TrialByWater == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TUNING_FORK_OF_WATER) == false and WhisperOfTides == false) then
        player:startEvent(190, 0, tpz.ki.TUNING_FORK_OF_WATER) -- Defeat against Avatar : Need new Fork
    elseif (TrialByWater == QUEST_ACCEPTED and WhisperOfTides == false) then
        player:startEvent(110, 0, tpz.ki.TUNING_FORK_OF_WATER, 2)
    elseif (TrialByWater == QUEST_ACCEPTED and WhisperOfTides) then
        numitem = 0

        if (player:hasItem(17439)) then numitem = numitem + 1; end  -- Leviathan's Rod
        if (player:hasItem(13246)) then numitem = numitem + 2; end  -- Water Belt
        if (player:hasItem(13565)) then numitem = numitem + 4; end  -- Water Ring
        if (player:hasItem(1204)) then numitem = numitem + 8; end   -- Eye of Nept
        if (player:hasSpell(300)) then numitem = numitem + 32; end  -- Ability to summon Leviathan

        player:startEvent(112, 0, tpz.ki.TUNING_FORK_OF_WATER, 2, 0, numitem)
    else
        player:startEvent(113) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 109 and option == 1) then
        if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER) == QUEST_COMPLETED) then
            player:delQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER)
        end
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER)
        player:setCharVar("TrialByWater_date", 0)
        player:addKeyItem(tpz.ki.TUNING_FORK_OF_WATER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TUNING_FORK_OF_WATER)
    elseif (csid == 190) then
        player:addKeyItem(tpz.ki.TUNING_FORK_OF_WATER)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TUNING_FORK_OF_WATER)
    elseif (csid == 112) then
        local item = 0
        if (option == 1) then item = 17439         -- Leviathan's Rod
        elseif (option == 2) then item = 13246  -- Water Belt
        elseif (option == 3) then item = 13565  -- Water Ring
        elseif (option == 4) then item = 1204     -- Eye of Nept
        end

        if (player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6)) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if (option == 5) then
                player:addGil(GIL_RATE*10000)
                player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000) -- Gil
            elseif (option == 6) then
                player:addSpell(300) -- Avatar
                player:messageSpecial(ID.text.AVATAR_UNLOCKED, 0, 0, 2)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end
            player:addTitle(tpz.title.HEIR_OF_THE_GREAT_WATER)
            player:delKeyItem(tpz.ki.WHISPER_OF_TIDES) --Whisper of Tides, as a trade for the above rewards
            player:setCharVar("TrialByWater_date", os.date("%j")) -- %M for next minute, %j for next day
            player:addFame(NORG, 30)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_WATER)
        end
    end

end
