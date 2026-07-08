-----------------------------------
-- Area: Selbina
--  NPC: Mathilde
-- Involved in Quest: Riding on the Clouds
-- !pos 12.578 -8.287 -7.576 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getRank(player:getNation()) >= 6 then
        if not player:hasCompletedUniqueEvent(xi.uniqueEvent.MET_MATHILDES_SON) then
            player:startEvent(173)
        else
            player:startEvent(174)
        end
    else
        player:startEvent(171)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 171 and
        not player:hasCompletedUniqueEvent(xi.uniqueEvent.RAMONA_INTRODUCTION)
    then
        player:setCharVar('metMathilde', 1)
    elseif csid == 173 then
        player:setUniqueEvent(xi.uniqueEvent.MET_MATHILDES_SON)
    end
end

return entity
