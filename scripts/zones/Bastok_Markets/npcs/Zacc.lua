-----------------------------------
-- Area: Bastok Markets
--  NPC: Zacc
-- !pos -255.709 -13 -91.379 235
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_COMPLETED then
        -- Quest: Wish Upon a Star - Quest has been completed.
        player:startEvent(336)
    elseif
        player:getFameLevel(xi.quest.fame_area.BASTOK) > 4 and
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_AVAILABLE
    then
        -- Quest: Wish Upon a Star - Start quest.
        player:startEvent(329)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 329 then -- Quest: Wish Upon a Star
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.WISH_UPON_A_STAR)
        player:setCharVar("WishUponAStar_Status", 1)
    end
end

return entity
