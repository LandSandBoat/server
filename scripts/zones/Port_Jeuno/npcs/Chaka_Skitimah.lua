-----------------------------------
-- Area: Port Jeuno
--  NPC: Chaka Skitimah
-- Standard Info NPC
-----------------------------------


-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local vHour = VanadielHour()
    local vMin  = VanadielMinute()

    while vHour >= 4 do
        vHour = vHour - 6
    end

    if (     vHour == -2) then vHour = 4
    elseif ( vHour == -1) then vHour = 5
    end

    local seconds = math.floor(2.4 * ((vHour * 60) + vMin))

    player:startEvent( 3, seconds, 0, 0, 0, 0, 0, 0, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
