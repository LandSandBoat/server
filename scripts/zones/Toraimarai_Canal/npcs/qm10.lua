-----------------------------------
-- Area: Toraimarai Canal
--  NPC: ???
-- Involved In Quest: Wild Card
-- !pos -95 16 -31 169
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('rootProblem') == 2 then
        if player:getCharVar('rootProblemQ2') <= 1 then
            if player:hasStatusEffect(xi.effect.MANAFONT) then
                player:startEvent(47)
            else
                player:startEvent(46)
            end
        else
            player:startEvent(42)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 47 then
        player:setCharVar('rootProblemQ2', 2)
    end
end

return entity
