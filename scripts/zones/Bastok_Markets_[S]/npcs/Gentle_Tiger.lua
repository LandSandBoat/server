-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: GentleTiger
-- !pos -203  -10  1
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('FiresOfDiscProg') == 5 then
            player:startEvent(160)
        else
            player:startEvent(161)
        end
    else
        player:startEvent(109)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 160 then
        player:setCharVar('FiresOfDiscProg', 6)
    end
end

return entity
