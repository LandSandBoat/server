-----------------------------------
-- Area: Windurst Woods
--  NPC: Pattsu-Yabittsu
-- Warps players to Windurst Waters
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(411)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(-2.203, -1.5, 103.226, 196, 238) -- Retail packet capped
    end
end

return entity
