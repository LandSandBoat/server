-----------------------------------
-- Area: Port Bastok
--  NPC: Door: Departures Exit
-- !pos -62 1 -8 236
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS) == true and player:getGil() >= 200) then
        player:startEvent(141)
    else
        player:startEvent(142)
    end
    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 141) then
        local X = player:getXPos()

        if (X >= -58 and X <= -55) then
            player:delGil(200)
        end
    end

end
