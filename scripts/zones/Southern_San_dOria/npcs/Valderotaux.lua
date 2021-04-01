-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Valderotaux
--  General Info NPC
-- !pos 97 0.1 113 230
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local lakesideMin = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.LAKESIDE_MINUET)
    local lakeProg = player:getCharVar("Lakeside_Minuet_Progress")
    if (lakeProg == 1) then
        player:startEvent(888) -- Dance for the drunks!
        player:setCharVar("Lakeside_Minuet_Progress", 2)
    elseif (lakeProg >= 2) then
        player:startEvent(889) -- Immediate regret of failure!
    else
        player:startEvent(58)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
