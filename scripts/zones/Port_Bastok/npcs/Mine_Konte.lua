-----------------------------------
-- Area: Port Bastok
--  NPC: Mine Konte
-- Involved in Quest: Out of One's Shell
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    OutOfOneShell = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.OUT_OF_ONE_S_SHELL)

    if (OutOfOneShell == QUEST_ACCEPTED and player:getCharVar("OutOfTheShellZone") == 0) then
        player:startEvent(83)
    else
        player:startEvent(42)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
