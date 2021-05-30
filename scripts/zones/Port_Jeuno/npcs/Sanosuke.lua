-----------------------------------
-- Area: Port Jeuno
--  NPC: Sanosuke
-- Involved in Quest: A Thief in Norg!?
-- !pos -63 7 0 246
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED then
        local aThiefinNorgCS = player:getCharVar("aThiefinNorgCS")

        if aThiefinNorgCS == 1 then
            player:startEvent(304)
        elseif aThiefinNorgCS == 2 then
            player:startEvent(305)
        elseif aThiefinNorgCS >= 3 then
            player:startEvent(306)
        end
    else
        player:startEvent(303)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 304 then
        player:setCharVar("aThiefinNorgCS", 2)
    end
end

return entity
