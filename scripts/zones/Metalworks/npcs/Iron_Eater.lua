-----------------------------------
-- Area: Metalworks
--  NPC: Iron Eater
-- Involved in Missions
-- Starts and Finishes; The Weight of Your Limits
-- !pos 92.936 -19.532 1.814 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == xi.questStatus.QUEST_ACCEPTED then
        if player:getCharVar('FiresOfDiscProg') == 1 then
            player:startEvent(956)
        else
            player:startEvent(957)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 956 then
        player:setCharVar('FiresOfDiscProg', 2)
    end
end

return entity
