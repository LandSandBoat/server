-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Pagdako
-- pos -200 -6 -93
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('FiresOfDiscProg') == 0 then
            player:startEvent(122)
        else
            player:startEvent(123)
        end
    else
        player:startEvent(106)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 122 then
        player:setCharVar('FiresOfDiscProg', 1)
    end
end

return entity
