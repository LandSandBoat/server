-----------------------------------
-- Area: Empyreal_Paradox
--  NPC: Transcendental Radiance
-- !pos 540 0 -594 36
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/missions")
require("scripts/globals/keyitems")
require("scripts/globals/quests")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 3
    then
        player:startEvent(4)
    else
        xi.bcnm.onTrigger(player, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 4 then
        player:setCharVar("ApocalypseNigh", 4)
    else
        xi.bcnm.onEventFinish(player, csid, option)
    end
end

return entity
