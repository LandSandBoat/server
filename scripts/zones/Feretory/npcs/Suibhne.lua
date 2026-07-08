-----------------------------------
-- Area: Feretory
-- NPC: Suibhne
-- !pos -366 -3.612 -466 285
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.settings.main.ENABLE_MONSTROSITY ~= 1 then
        return
    end

    player:startEvent(11)
end

return entity
