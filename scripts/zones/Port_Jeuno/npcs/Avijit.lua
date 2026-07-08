-----------------------------------
-- Area: Port Jeuno
--  NPC: Avijit
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 6
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent(10024, seconds, 0, 0, 0, 0, 0, 0, 0)
end

return entity
