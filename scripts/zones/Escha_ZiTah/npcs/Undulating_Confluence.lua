-----------------------------------
-- Area: Escha - Zi'Tah Island (288)
--  NPC: Undulating Confluence
-- !pos --344.275 1.659 -182.613 288
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(4)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 4 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.QUFIM_CONFLUENCE)
    end
end

return entity
