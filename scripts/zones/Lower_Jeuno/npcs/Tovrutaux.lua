-----------------------------------
-- Area: Lower Jueno
-- NPC: Tovrutaux
-- !pos -91.383 0 -150.481
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasCompletedUniqueEvent(xi.uniqueEvent.TOVRUTAUX_BITTEN) then
        player:startEvent(58)
    else
        player:startEvent(59)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 58 then
        player:setUniqueEvent(xi.uniqueEvent.TOVRUTAUX_BITTEN)
    end
end

return entity
