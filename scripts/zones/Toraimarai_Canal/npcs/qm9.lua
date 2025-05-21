-----------------------------------
-- Area: Toraimarai Canal
--  NPC: ???
-- Involved In Quest: The Root of the Problem
-- !pos -137 16 151 169
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('rootProblem') == 2 then
        if player:getCharVar('rootProblemQ1') <= 1 then
            player:startEvent(42)
        else
            player:startEvent(42)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 42 then
        player:setCharVar('rootProblemQ1', 2)
    end
end

return entity
