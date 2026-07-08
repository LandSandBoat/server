-----------------------------------
-- Area: Windurst Waters
--  NPC: Furakku-Norakku
-- Involved in Quests: Early Bird Catches the Bookworm, Chasing Tales, Class Reunion
-- !pos -19 -5 101 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local classReunion = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.CLASS_REUNION)
    local classReunionProgress = player:getCharVar('ClassReunionProgress')
    local talk2 = player:getCharVar('ClassReunion_TalkedToFurakku')

    -- Class Reunion
    if classReunion == 1 and classReunionProgress >= 3 and talk2 ~= 1 then
        player:startEvent(816) -- he tells you about Uran-Mafran
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 816 then
        player:setCharVar('ClassReunion_TalkedToFurakku', 1)
    end
end

return entity
