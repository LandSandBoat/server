-----------------------------------
-- Area: Western Adoulin
--  NPC: Eamonn
-- !pos -91 3 2 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local scaredyCats = player:getQuestStatus(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.SCAREDYCATS)
    local scaredyCatsStatus = player:getCharVar('Scaredycats_Status')

    if scaredyCatsStatus < 1 and scaredyCats == QUEST_AVAILABLE then
        -- Dialogue before seeing the initial walk-in CS with Bilp, Eamonn, and Lhe.
        player:startEvent(5031)
    elseif scaredyCatsStatus == 1 then
        if scaredyCats == QUEST_ACCEPTED then
            -- Reminder for Quest: 'Scaredy-Cats', go to Ceizak Battlegrounds
            player:startEvent(5025)
        else
            -- Starts Quest: 'Scaredy-Cats', after first refusal.
            player:startEvent(5024)
        end
    elseif scaredyCatsStatus == 2 then
        -- Reminder for Quest: 'Scaredy-Cats', go to Sih Gates.
        player:startEvent(5027)
    else
        -- Dialogue after completeing Quest: 'Scaredy-Cats'
        player:startEvent(5030)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5024 and option == 1 then
        -- Starts Quest: 'Scaredy-Cats', after first refusal.
        player:setCharVar('Scaredycats_Status', 2)
        player:addQuest(xi.quest.log_id.ADOULIN, xi.quest.id.adoulin.SCAREDYCATS)
    end
end

return entity
