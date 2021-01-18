-----------------------------------
-- Area: Metalworks
--  NPC: Romualdo
-- Involved in Quest: Stamp Hunt
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local StampHunt = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.STAMP_HUNT)
    local FadedPromises = player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.FADED_PROMISES)

    if (StampHunt == QUEST_ACCEPTED and not utils.mask.getBit(player:getCharVar("StampHunt_Mask"), 4)) then
        player:startEvent(726)
    elseif (FadedPromises == QUEST_AVAILABLE and player:getMainJob() == tpz.job.NIN and player:getMainLvl() >= 20 and player:getFameLevel(NORG) >= 4) then
        player:startEvent(802)
    else
        player:startEvent(705)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 726) then
        player:setCharVar("StampHunt_Mask", utils.mask.setBit(player:getCharVar("StampHunt_Mask"), 4, true))
    elseif csid == 802 then
        player:addQuest(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.FADED_PROMISES)
        player:setCharVar("FadedPromises", 1)
    end

end

return entity
