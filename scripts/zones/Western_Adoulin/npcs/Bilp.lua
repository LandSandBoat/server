-----------------------------------
-- Area: Western Adoulin
--  NPC: Bilp
-- Type: Standard NPC and Quest NPC
-- Starts and Involved with Quest: 'Scaredy-Cats'
-- !pos -91 3 0 256
-----------------------------------
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local Scaredycats = player:getQuestStatus(ADOULIN, tpz.quest.id.adoulin.SCAREDYCATS)
    local Scaredycats_Status = player:getCharVar("Scaredycats_Status")
    if ((Scaredycats_Status < 1) and (Scaredycats == QUEST_AVAILABLE)) then
        -- Dialogue before seeing the initial walk-in CS with Bilp, Eamonn, and Lhe.
        player:startEvent(5031)
    elseif (Scaredycats_Status == 1) then
        if (Scaredycats == QUEST_ACCEPTED) then
            -- Reminder for Quest: 'Scaredy-Cats', go to Ceizak Battlegrounds
            player:startEvent(5025)
        else
            -- Starts Quest: 'Scaredy-Cats', after first refusal.
            player:startEvent(5024)
        end
    elseif (Scaredycats_Status == 2) then
        -- Reminder for Quest: 'Scaredy-Cats', go to Sih Gates.
        player:startEvent(5026)
    else
        -- Dialogue after completeing Quest: 'Scaredy-Cats'
        player:startEvent(5029)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if ((csid == 5024) and (option == 1)) then
        -- Starts Quest: 'Scaredy-Cats', after first refusal.
        player:setCharVar("Scaredycats_Status", 2)
        player:addQuest(ADOULIN, tpz.quest.id.adoulin.SCAREDYCATS)
    end
end
