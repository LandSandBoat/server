-----------------------------------
-- Area: Selbina
--  NPC: Ramona
-- !pos 15.1869 -7.2878 -1.1016 171
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.RAMONA_INTRODUCTION) then
        player:startEvent(172)
    else
        if not player:hasCompletedUniqueEvent(xi.uniqueEvent.MET_MATHILDES_SON) then
            player:startEvent(170)
        else
            player:startEvent(175)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 172 then
        player:setUniqueEvent(xi.uniqueEvent.RAMONA_INTRODUCTION)
    end
end

return entity
