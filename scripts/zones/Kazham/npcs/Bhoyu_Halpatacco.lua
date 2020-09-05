-----------------------------------
-- Area: Kazham
--  NPC: Bhoyu Halpatacco
-- !pos -18 -4 -15 250
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    Z = player:getZPos()

    if (Z >= -11 and Z <= -6) then
        player:startEvent(67)
    elseif (player:getGil() >= 200) then
        player:startEvent(116, 0, 200)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 116) then
        Z = player:getZPos()

        if (Z >= -10 and Z <= -6) then
            player:delGil(200)
        end
    end

end
