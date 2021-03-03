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
    local starStatus = player:getQuestStatus(tpz.quest.log_id.WINDURST, tpz.quest.id.windurst.MIHGO_S_AMIGO)

    if starStatus == QUEST_ACCEPTED then
        player:startEvent(83)
    else
        player:startEvent(426)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
