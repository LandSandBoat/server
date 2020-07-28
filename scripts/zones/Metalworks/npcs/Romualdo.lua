-----------------------------------
-- Area: Metalworks
--  NPC: Romualdo
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local StampHunt = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.STAMP_HUNT)
    local FadedPromises = player:getQuestStatus(BASTOK, tpz.quest.id.bastok.FADED_PROMISES)

    if (StampHunt == QUEST_ACCEPTED and player:getMaskBit(player:getCharVar("StampHunt_Mask"), 4) == false) then
        player:startEvent(726)
    elseif (FadedPromises == QUEST_AVAILABLE and player:getMainJob() == tpz.job.NIN and player:getMainLvl() >= 20 and player:getFameLevel(NORG) >= 4) then
        player:startEvent(802)
    else
        player:startEvent(705)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 726) then
        player:setMaskBit(player:getCharVar("StampHunt_Mask"), "StampHunt_Mask", 4, true)
    elseif csid == 802 then
        player:addQuest(BASTOK, tpz.quest.id.bastok.FADED_PROMISES)
        player:setCharVar("FadedPromises", 1)
    end

end
