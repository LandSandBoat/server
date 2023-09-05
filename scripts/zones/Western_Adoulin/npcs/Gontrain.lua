-----------------------------------
-- Area: Western Adoulin
--  NPC: Gontrain
-- Involved with Quest: 'Raptor Rapture'
-- !pos 13 0 -143 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local raptorRapture = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.RAPTOR_RAPTURE)

    if
        raptorRapture == QUEST_ACCEPTED and
        player:getCharVar("Raptor_Rapture_Status") == 4
    then
        -- Progresses Quest: 'Raptor Rapture', speaking to Ilney.
        player:startEvent(5034)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 5034 then
        -- Progresses Quest: 'Raptor Rapture', spoke to Ilney.
        player:setCharVar("Raptor_Rapture_Status", 5)
    end
end

return entity
