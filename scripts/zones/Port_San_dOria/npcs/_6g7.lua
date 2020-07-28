-----------------------------------
-- Area: Port San d'Oria
--  NPC: Door: Arrivals Entrance
-- !pos -24 -8 15 232
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    if (player:getZPos() >= 12) then
        player:startEvent(518)
    end

    return 1

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
