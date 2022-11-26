-----------------------------------
-- Area: North Gustaberg (S) (F-8)
--  NPC: ???
-- Involved in Quests
-- !pos -232 41 425
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == QUEST_ACCEPTED and
        player:getCharVar("BetterPartOfValProg") == 1
    then
        player:startEvent(3)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 3 then
        player:setCharVar("BetterPartOfValProg", 2)
    end
end

return entity
