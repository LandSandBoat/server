-----------------------------------
-- Area: Bastok Mines
--  NPC: Door
-- Involved in Quest: A Thief in Norg!?
-- !pos 70 7 2 234
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED and player:getCharVar("aThiefinNorgCS") == 3) then
        player:startEvent(186)
        return -1
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 186) then
        player:setCharVar("aThiefinNorgCS", 4)
    end
end

return entity
