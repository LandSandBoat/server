-----------------------------------
-- Area: Port San d'Oria
--  NPC: Louis
-- Type: Standard NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 3 do
        vHour = vHour - 6
    end

    if (     vHour == -3) then vHour = 3
    elseif ( vHour == -2) then vHour = 4
    elseif ( vHour == -1) then vHour = 5
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent( 763, seconds, 0, 0, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
