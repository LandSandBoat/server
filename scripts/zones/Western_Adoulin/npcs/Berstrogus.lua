-----------------------------------
-- Area: Western Adoulin
--  NPC: Berstrogus
-- Type: Standard NPC
-- !pos -44 4 -10 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)

    if (SOA_Mission >= tpz.mission.id.soa.LIFE_ON_THE_FRONTIER) then
        -- Standard dialogue, after joining colonization effort
        player:startEvent(587)
    else
        -- Dialogue prior to joining colonization effort
        player:startEvent(504)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
