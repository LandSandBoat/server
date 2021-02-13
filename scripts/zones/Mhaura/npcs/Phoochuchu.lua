-----------------------------------
-- Area: Mhaura
--  NPC: Phoochuchu
-- Involved in Quest: A Thief in Norg!?
-- !pos -4 -4 69 249
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(tpz.quest.log_id.OUTLANDS, tpz.quest.id.outlands.A_THIEF_IN_NORG) == QUEST_ACCEPTED) then
        local aThiefinNorgCS = player:getCharVar("aThiefinNorgCS")
        if (aThiefinNorgCS == 2) then
            player:startEvent(301)
        elseif (aThiefinNorgCS == 3) then
            player:startEvent(303)
        elseif (aThiefinNorgCS >= 4) then
            player:startEvent(302)
        end
    else
        player:startEvent(300)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 301) then
        player:setCharVar("aThiefinNorgCS", 3)
    end

end

return entity
