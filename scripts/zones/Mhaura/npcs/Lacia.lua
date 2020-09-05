-----------------------------------
-- Area: Mhaura
--  NPC: Lacia
-- Starts Quest: Trial Size Trial By Lightning
--  The "TrialSizeLightning_date" still needs to be set at the BCNM/Mob level to reflect defeat by the Avatar
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/teleports")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:hasItemQty(1548, 1) == true and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING) == QUEST_ACCEPTED and player:getMainJob() == tpz.job.SMN) then
        player:startEvent(10026, 0, 1548, 5, 20)
    end
end

function onTrigger(player, npc)

    local TrialSizeLightning = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)

    if (player:getMainLvl() >= 20 and player:getMainJob() == tpz.job.SMN and TrialSizeLightning == QUEST_AVAILABLE and player:getFameLevel(WINDURST) >= 2) then --Requires player to be Summoner at least lvl 20
        player:startEvent(10025, 0, 1548, 5, 20)     --mini tuning fork of lightning, zone, level
    elseif (TrialSizeLightning == QUEST_ACCEPTED) then
        local LightningFork = player:hasItem(1548)

        if (LightningFork == true) then
            player:startEvent(10018) --Dialogue given to remind player to be prepared
        elseif (LightningFork == false and tonumber(os.date("%j")) ~= player:getCharVar("TrialSizeLightning_date")) then
            player:startEvent(10029, 0, 1548, 5, 20) --Need another mini tuning fork
        end
    elseif (TrialSizeLightning == QUEST_COMPLETED) then
        player:startEvent(10028) --Defeated Ramuh
    else
        player:startEvent(10021) --Standard dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 10025 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1548) --Mini tuning fork
        else
            player:setCharVar("TrialSizeLightning_date", 0)
            player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.TRIAL_SIZE_TRIAL_BY_LIGHTNING)
            player:addItem(1548)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1548)
        end
    elseif (csid == 10029 and option == 1) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 1548) --Mini tuning fork
        else
            player:addItem(1548)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 1548)
        end
    elseif (csid == 10026 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.CLOISTER_OF_STORMS)
    end
end
