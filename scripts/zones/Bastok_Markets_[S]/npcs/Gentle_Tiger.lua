-----------------------------------
-- Area: Bastok Markets [S]
--  NPC: GentleTiger
-- Type: Quest
-- !pos -203  -10  1
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.FIRES_OF_DISCONTENT) == QUEST_ACCEPTED then
        if player:getCharVar('FiresOfDiscProg') == 5 then
            player:startEvent(160)
        else
            player:startEvent(161)
        end
    else
        player:startEvent(109)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 160 then
        player:setCharVar('FiresOfDiscProg', 6)
    end
end

return entity
