-----------------------------------
-- Area: Misareaux Coast (25)
--  NPC: Undulating Confluence
-- !pos --48.908 -23.302 572.269 25
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 and option == 1 then
        xi.teleport.to(player, xi.teleport.id.ESCHA_RUAUN)
    end
end

return entity
