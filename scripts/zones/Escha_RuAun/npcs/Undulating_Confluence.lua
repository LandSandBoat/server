-----------------------------------
-- Area: Escha - Ru'Aun (289)
--  NPC: Undulating Confluence
-- !pos -0.163 -34.106 -471.971 289
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.MISAREAUX_CONFLUENCE)
    end
end

return entity
