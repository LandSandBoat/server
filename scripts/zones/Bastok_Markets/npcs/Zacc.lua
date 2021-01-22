-----------------------------------
-- Area: Bastok Markets
--  NPC: Zacc
-- Type: Quest NPC
-- !pos -255.709 -13 -91.379 235
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_COMPLETED) then -- Quest: Wish Upon a Star - Quest has been completed.
        player:startEvent(336)
    elseif (player:getFameLevel(BASTOK) > 4 and player:getQuestStatus(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.WISH_UPON_A_STAR) == QUEST_AVAILABLE) then -- Quest: Wish Upon a Star - Start quest.
        player:startEvent(329)
    else -- Standard dialog
        player:startEvent(328)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 329) then -- Quest: Wish Upon a Star
        player:addQuest(tpz.quest.log_id.BASTOK, tpz.quest.id.bastok.WISH_UPON_A_STAR)
        player:setCharVar("WishUponAStar_Status", 1)
    end
end

return entity
