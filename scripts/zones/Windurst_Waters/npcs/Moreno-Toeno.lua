-----------------------------------
-- Area: Windurst Waters
--  NPC: Moreno-Toeno
-- !pos 169 -1.25 159 238
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local rand = math.random(1, 2)

    if rand == 1 then
        player:startEvent(441) -- Standard Conversation 1
    else
        player:startEvent(469) -- Standard Conversation 2
    end
end

return entity
