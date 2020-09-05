-----------------------------------
-- Area: Kazham
--  NPC: Ronta-Onta
-- Starts and Finishes Quest: Trial by Fire
-- !pos 100 -15 -97 250
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Kazham/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    TrialByFire = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE)
    WhisperOfFlames = player:hasKeyItem(tpz.ki.WHISPER_OF_FLAMES)
    realday = tonumber(os.date("%j")) -- %M for next minute, %j for next day

    if ((TrialByFire == QUEST_AVAILABLE and player:getFameLevel(KAZHAM) >= 6) or (TrialByFire == QUEST_COMPLETED and realday ~= player:getCharVar("TrialByFire_date"))) then
        player:startEvent(270, 0, tpz.ki.TUNING_FORK_OF_FIRE) -- Start and restart quest "Trial by Fire"
    elseif (TrialByFire == QUEST_ACCEPTED and player:hasKeyItem(tpz.ki.TUNING_FORK_OF_FIRE) == false and WhisperOfFlames == false) then
        player:startEvent(285, 0, tpz.ki.TUNING_FORK_OF_FIRE) -- Defeat against Ifrit : Need new Fork
    elseif (TrialByFire == QUEST_ACCEPTED and WhisperOfFlames == false) then
        player:startEvent(271, 0, tpz.ki.TUNING_FORK_OF_FIRE, 0)
    elseif (TrialByFire == QUEST_ACCEPTED and WhisperOfFlames) then
        numitem = 0

        if (player:hasItem(17665)) then numitem = numitem + 1; end  -- Ifrits Blade
        if (player:hasItem(13241)) then numitem = numitem + 2; end  -- Fire Belt
        if (player:hasItem(13560)) then numitem = numitem + 4; end  -- Fire Ring
        if (player:hasItem(1203)) then numitem = numitem + 8; end   -- Egil's Torch
        if (player:hasSpell(298)) then numitem = numitem + 32; end  -- Ability to summon Ifrit

        player:startEvent(273, 0, tpz.ki.TUNING_FORK_OF_FIRE, 0, 0, numitem)
    else
        player:startEvent(274) -- Standard dialog
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 270 and option == 1) then
        if (player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE) == QUEST_COMPLETED) then
            player:delQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE)
        end
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE)
        player:setCharVar("TrialByFire_date", 0)
        player:addKeyItem(tpz.ki.TUNING_FORK_OF_FIRE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TUNING_FORK_OF_FIRE)
    elseif (csid == 285) then
        player:addKeyItem(tpz.ki.TUNING_FORK_OF_FIRE)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.TUNING_FORK_OF_FIRE)
    elseif (csid == 273) then
        item = 0
        if (option == 1) then item = 17665         -- Ifrits Blade
        elseif (option == 2) then item = 13241  -- Fire Belt
        elseif (option == 3) then item = 13560  -- Fire Ring
        elseif (option == 4) then item = 1203     -- Egil's Torch
        end

        if (player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6)) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if (option == 5) then
                player:addGil(GIL_RATE*10000)
                player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*10000) -- Gil
            elseif (option == 6) then
                player:addSpell(298) -- Ifrit Spell
                player:messageSpecial(ID.text.IFRIT_UNLOCKED, 0, 0, 0)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end
            player:addTitle(tpz.title.HEIR_OF_THE_GREAT_FIRE)
            player:delKeyItem(tpz.ki.WHISPER_OF_FLAMES)
            player:setCharVar("TrialByFire_date", os.date("%j")) -- %M for next minute, %j for next day
            player:addFame(KAZHAM, 30)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.TRIAL_BY_FIRE)
        end
    end

end
