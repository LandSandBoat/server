-----------------------------------
-- Area: Jugner Forest
--  NPC: qm2 (???)
-- Involved in Quest: Sin Hunting - RNG AF1
-- !pos -10.946 -1.000 313.810 104
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local phase = VanadielMoonPhase()
    local direction = VanadielMoonDirection()
    if player:getCharVar("sinHunting") == 4 and
    ((phase <= 90 and direction == 2) or (phase <= 95 and direction == 1)) then
        player:startEvent(13, 0, 1107)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 13 then
        player:setCharVar("sinHunting", 5)
    end
end

return entity
