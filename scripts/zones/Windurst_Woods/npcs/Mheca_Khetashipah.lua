-----------------------------------
-- Area: Windurst Woods
--  NPC: Mheca Khetashipah
-- Type: Standard NPC
-- !pos 66.881 -6.249 185.752 241
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local starStatus = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.MIHGO_S_AMIGO)

    if starStatus == QUEST_ACCEPTED then
        player:startEvent(83)
    else
        -- Possibly not their default dialogue. Event #79 witnessed in capture. Leaving for now until
        -- verified.
        player:startEvent(426)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
