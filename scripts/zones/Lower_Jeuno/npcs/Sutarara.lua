-----------------------------------
-- Area: Lower Jeuno
--  NPC: Sutarara
-- Involved in Quests: Tenshodo Menbership (before accepting)
-- !pos 30 0.1 -2 245
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local TenshodoMembership = player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.TENSHODO_MEMBERSHIP)
    local WildcatJeuno = player:getCharVar("WildcatJeuno")

    if (player:getQuestStatus(tpz.quest.log_id.JEUNO, tpz.quest.id.jeuno.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and not utils.mask.getBit(WildcatJeuno, 10)) then
        player:startEvent(10055)
    elseif (TenshodoMembership ~= QUEST_COMPLETED) then
        player:startEvent(208)
    elseif (TenshodoMembership == QUEST_COMPLETED) then
        player:startEvent(211)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 10055) then
        player:setCharVar("WildcatJeuno", utils.mask.setBit(player:getCharVar("WildcatJeuno"), 10, true))
    end
end

return entity
