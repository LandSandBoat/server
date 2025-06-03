-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Door Acolyte hostel
-- !pos 146.619, -8.525, 242.874 94
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.SAY_IT_WITH_A_HANDBAG) == xi.questStatus.QUEST_ACCEPTED and
        player:getCharVar('sayItWithAHandbagCS') == 0
    then
        player:startEvent(171)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 171 then
        if option == 1 then
            player:setCharVar('sayItWithAHandbagCS', 1)
        end
    end
end

return entity
