-----------------------------------
-- Area: North Gustaberg (S) (I-6)
--  NPC: Gebhardt
-- Involved in Quests: The Fighting Fourth
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.THE_FIGHTING_FOURTH) == xi.questStatus.QUEST_ACCEPTED and
        player:hasKeyItem(xi.ki.BATTLE_RATIONS)
    then
        player:startEvent(102)
    else
        player:startEvent(110)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 102 then
        player:delKeyItem(xi.ki.BATTLE_RATIONS)
        player:setCharVar('THE_FIGHTING_FOURTH', 1)
    end
end

return entity
