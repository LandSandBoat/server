-----------------------------------
-- Area: Port Jeuno
--  NPC: Avijit
-- Standard Info NPC
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 6 do
        vHour = vHour - 6
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent( 10024, seconds, 0, 0, 0, 0, 0, 0, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
