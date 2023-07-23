-----------------------------------
-- Area: Port Jeuno
--  NPC: Chudigrimane
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 6
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent(6, seconds, 0, 0, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
