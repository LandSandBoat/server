-----------------------------------
-- Area: Rabao
--  NPC: Agado-Pugado
-- Starts and Finishes Quest: Trial by Wind
-- !pos -17 7 -10 247
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/shop")
require("scripts/globals/quests")
local ID = require("scripts/zones/Rabao/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local trialByWind = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
    local carbuncleDebacle = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.CARBUNCLE_DEBACLE)
    local carbuncleDebacleProgress = player:getCharVar("CarbuncleDebacleProgress")

    -----------------------------------
    -- Carbuncle Debacle
    if
        carbuncleDebacle == QUEST_ACCEPTED and
        carbuncleDebacleProgress == 5 and
        player:hasKeyItem(xi.ki.DAZE_BREAKER_CHARM)
    then
        player:startEvent(86) -- get the wind pendulum, lets go to Cloister of Gales
    elseif carbuncleDebacle == QUEST_ACCEPTED and carbuncleDebacleProgress == 6 then
        if not player:hasItem(1174) then
            player:startEvent(87, 0, 1174, 0, 0, 0, 0, 0, 0) -- "lost the pendulum?" This one too~???
        else
            player:startEvent(88) -- reminder to go to Cloister of Gales
        end
    -----------------------------------
    -- Trial by Wind
    elseif
        (trialByWind == QUEST_AVAILABLE and player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 5) or
        (trialByWind == QUEST_COMPLETED and os.time() > player:getCharVar("TrialByWind_date"))
    then
        player:startEvent(66, 0, 331) -- Start and restart quest "Trial by Wind"
    elseif
        trialByWind == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.TUNING_FORK_OF_WIND) and
        not player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        player:startEvent(107, 0, 331) -- Defeat against Avatar : Need new Fork
    elseif
        trialByWind == QUEST_ACCEPTED and
        not player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        player:startEvent(67, 0, 331, 3)
    elseif
        trialByWind == QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.WHISPER_OF_GALES)
    then
        local numitem = 0

        if player:hasItem(17627) then
            numitem = numitem + 1
        end  -- Garuda's Dagger

        if player:hasItem(13243) then
            numitem = numitem + 2
        end  -- Wind Belt

        if player:hasItem(13562) then
            numitem = numitem + 4
        end  -- Wind Ring

        if player:hasItem(1202) then
            numitem = numitem + 8
        end   -- Bubbly Water

        if player:hasSpell(301) then
            numitem = numitem + 32
        end  -- Ability to summon Garuda

        player:startEvent(69, 0, 331, 3, 0, numitem)
    else
        player:startEvent(70) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 66 and option == 1 then
        if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND) == QUEST_COMPLETED then
            player:delQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        end

        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        player:setCharVar("TrialByWind_date", 0)
        player:addKeyItem(xi.ki.TUNING_FORK_OF_WIND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_WIND)
    elseif csid == 107 then
        player:addKeyItem(xi.ki.TUNING_FORK_OF_WIND)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TUNING_FORK_OF_WIND)
    elseif csid == 69 then
        local item = 0
        if option == 1 then item = 17627         -- Garuda's Dagger
        elseif option == 2 then item = 13243  -- Wind Belt
        elseif option == 3 then item = 13562  -- Wind Ring
        elseif option == 4 then item = 1202     -- Bubbly Water
        end

        if player:getFreeSlotsCount() == 0 and (option ~= 5 or option ~= 6) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            if option == 5 then
                npcUtil.giveCurrency(player, 'gil', 10000)
            elseif option == 6 then
                player:addSpell(301) -- Garuda Spell
                player:messageSpecial(ID.text.GARUDA_UNLOCKED, 0, 0, 3)
            else
                player:addItem(item)
                player:messageSpecial(ID.text.ITEM_OBTAINED, item) -- Item
            end

            player:addTitle(xi.title.HEIR_OF_THE_GREAT_WIND)
            player:delKeyItem(xi.ki.WHISPER_OF_GALES) --Whisper of Gales, as a trade for the above rewards
            player:setCharVar("TrialByWind_date", getMidnight())
            player:addFame(xi.quest.fame_area.SELBINA_RABAO, 30)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.TRIAL_BY_WIND)
        end
    elseif csid == 86 or csid == 87 then
        if player:getFreeSlotsCount() ~= 0 then
            player:addItem(1174)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1174)
            player:setCharVar("CarbuncleDebacleProgress", 6)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1174)
        end
    end
end

return entity
