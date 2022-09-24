-----------------------------------
-- Area: Bastok Markets
--  NPC: Nbu Latteh
-- Starts Quest: The Signpost Marks the Spot
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local pFame = player:getFameLevel(xi.quest.fame_area.BASTOK)

    if pFame >= 2 and player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT) == QUEST_AVAILABLE then
        player:startEvent(235)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 235 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_SIGNPOST_MARKS_THE_SPOT)
        player:setCharVar("MomTheAdventurer_Event", 0)
    end
end

return entity
