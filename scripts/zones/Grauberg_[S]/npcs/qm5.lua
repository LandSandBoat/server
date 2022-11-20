-----------------------------------
-- Area: Grauberg [S]
--  NPC: ???
--  Quest - Fires of Discontent
-- pos 258 33 516
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and
        player:getCharVar("FiresOfDiscProg") == 3
    then
        player:startEvent(11)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 11 then
        player:setCharVar("FiresOfDiscProg", 4)
    end
end

return entity
