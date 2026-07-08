-----------------------------------
-- Area: Windurst Walls
--  NPC: Komulili
-- Warps players to Port Windurst
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(338)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(-111.919, -8.75, 92.093, 62, 240) -- (R)
    end
end

return entity
