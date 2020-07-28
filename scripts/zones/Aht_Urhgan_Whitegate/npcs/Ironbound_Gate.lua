-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Ironbound Gate
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local X = player:getXPos()
    local Z = player:getZPos()

    if (X > -43 and X < -37) and (Z < -53 and Z > -59) then
        player:startEvent(131) -- To Waj. Woodlands
    else
        player:startEvent(130) -- To B. Thickets
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 131 and option == 1 then
        player:setPos(690, -18.5, 220, 128, 51)        --> Wajaom Woodlands, at northeastern tower
    elseif csid == 130 and option == 1 then
        player:setPos(570.5, -10.5, 140, 128, 52)    --> Bhaflau Thickets, at southeastern tower
    end
end
