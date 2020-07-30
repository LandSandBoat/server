-----------------------------------
-- Area: Western Adoulin
--  NPC: Gontrain
-- Type: Standard NPC and Quest NPC
-- Involved with Quest: 'Raptor Rapture'
-- !pos 13 0 -143 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Raptor_Rapture = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.RAPTOR_RAPTURE)

    if ((Raptor_Rapture == QUEST_ACCEPTED) and (player:getCharVar("Raptor_Rapture_Status") == 4)) then
        -- Progresses Quest: 'Raptor Rapture', speaking to Ilney.
        player:startEvent(5034)
    else
        -- Standard dialogue
        player:startEvent(5042)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 5034) then
        -- Progresses Quest: 'Raptor Rapture', spoke to Ilney.
        player:setCharVar("Raptor_Rapture_Status", 5)
    end
end
