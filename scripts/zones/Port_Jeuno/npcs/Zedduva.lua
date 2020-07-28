-----------------------------------
-- Area: Port Jeuno
--  NPC: Zedduva
-- !pos -61 7 -54 246
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:hasKeyItem(tpz.ki.AIRSHIP_PASS) == true and player:getGil() >= 200) then
        player:startEvent(36)
    else
        player:startEvent(44)
    end

    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 36) then
        Z = player:getZPos()

        if (Z >= -61 and Z <= -58) then
            player:delGil(200)
        end
    end

end
