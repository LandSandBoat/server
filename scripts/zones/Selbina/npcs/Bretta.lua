-----------------------------------
-- Area: Selbina
--  NPC: Bretta
-- !pos 23.156 -2.558 -29.996 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getZPos() > -28.750 then
        player:startEvent(1133, 1152 - ((GetSystemTime() - 1009810584) % 1152))
    else
        player:startEvent(222)
    end
end

return entity
