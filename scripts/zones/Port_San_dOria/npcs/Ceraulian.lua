-----------------------------------
-- Area: Port San d'Oria
--  NPC: Ceraulian
-- Involved in Quest: The Holy Crest
-- !pos 0 -8 -122 232
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS) == QUEST_ACCEPTED and player:getCharVar("ChasingQuotas_Progress") == 0 and
        trade:getItemCount() == 1 and trade:hasItemQty(12494, 1) and trade:getGil() == 0) then -- Trading gold hairpin only
            player:tradeComplete()
            player:startEvent(17)
    end
end

function onTrigger(player, npc)
    local Quotas_Status = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS)
    local Quotas_Progress = player:getCharVar("ChasingQuotas_Progress")
    local Quotas_No = player:getCharVar("ChasingQuotas_No")
    local Stalker_Status = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.KNIGHT_STALKER)
    local Stalker_Progress = player:getCharVar("KnightStalker_Progress")

    if (player:getMainLvl() >= ADVANCED_JOB_LEVEL and player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_HOLY_CREST) == QUEST_AVAILABLE) then
        player:startEvent(24)

    -- Chasing Quotas (DRG AF2)
    elseif (Quotas_Status == QUEST_AVAILABLE and player:getMainJob() == tpz.job.DRG and player:getMainLvl() >= AF1_QUEST_LEVEL and Quotas_No == 0) then
        player:startEvent(18) -- Long version of quest start
    elseif (Quotas_No == 1) then
        player:startEvent(14) -- Short version for those that said no.
    elseif (Quotas_Status == QUEST_ACCEPTED and Quotas_Progress == 0) then
        players:startEvent(13) -- Reminder to bring Gold Hairpin
    elseif (Quotas_Progress == 1) then
        if (player:getCharVar("ChasingQuotas_date") > os.time()) then
            player:startEvent(3) -- Fluff cutscene because you haven't waited a day
        else
            player:startEvent(7) -- Boss got mugged
        end
    elseif (Quotas_Progress == 2) then
        player:startEvent(8) -- Go investigate
    elseif (Quotas_Progress == 3) then
        player:startEvent(6) -- Earring is a clue, non-required CS
    elseif (Quotas_Progress == 4 or Quotas_Progress == 5) then
        player:startEvent(9) -- Fluff text until Ceraulian is necessary again
    elseif (Quotas_Progress == 6) then
        player:startEvent(15) -- End of AF2

    elseif (Quotas_Status == QUEST_COMPLETED and Stalker_Status == QUEST_AVAILABLE) then
        player:startEvent(16) -- Fluff text until DRG AF3

    -- Knight Stalker (DRG AF3)
    elseif (Stalker_Status == QUEST_ACCEPTED and Stalker_Progress == 0) then
        player:startEvent(19) -- Fetch the last Dragoon's helmet
    elseif (Stalker_Progress == 1) then
        if (player:hasKeyItem(tpz.ki.CHALLENGE_TO_THE_ROYAL_KNIGHTS) == false) then
            player:startEvent(23) -- Reminder to get helmet
        else
            player:startEvent(20) -- Response if you try to turn in the challenge to Ceraulian
        end
    elseif (player:getCharVar("KnightStalker_Option1") == 1) then
        player:startEvent(22)
    elseif (Stalker_Status == QUEST_COMPLETED) then
        player:startEvent(21)

    else
        player:startEvent(587)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 24) then
        player:setCharVar("TheHolyCrest_Event", 1)

    -- Chasing Quotas (DRG AF2)
    elseif (csid == 18) then
        if option == 0 then
            player:setCharVar("ChasingQuotas_No", 1)
        else
            player:addQuest(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS)
        end
    elseif (csid == 14 and option == 1) then
        player:setCharVar("ChasingQuotas_No", 0)
        player:addQuest(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS)
    elseif (csid == 17) then
        player:setCharVar("ChasingQuotas_Progress", 1)
        player:setCharVar("ChasingQuotas_date", os.time() + 60)
    elseif (csid == 7) then
        player:setCharVar("ChasingQuotas_Progress", 2)
        player:setCharVar("ChasingQuotas_date", 0)
    elseif (csid == 15) then
        if (player:getFreeSlotsCount() < 1) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 14227)
        else
            player:delKeyItem(tpz.ki.RANCHURIOMES_LEGACY)
            player:addItem(14227)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 14227) -- Drachen Brais
            player:addFame(SANDORIA, 40)
            player:completeQuest(SANDORIA, tpz.quest.id.sandoria.CHASING_QUOTAS)
            player:setCharVar("ChasingQuotas_Progress", 0)
        end

        -- Knight Stalker (DRG AF3)
    elseif (csid == 19) then
        player:setCharVar("KnightStalker_Progress", 1)
    elseif (csid == 22) then
        player:setCharVar("KnightStalker_Option1", 0)
    end
end
