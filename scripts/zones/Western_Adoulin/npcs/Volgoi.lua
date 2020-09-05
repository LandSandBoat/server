-----------------------------------
-- Area: Western Adoulin
--  NPC: Volgoi
-- Type: Standard NPC
-- !pos -154 4 -22 256
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local SOA_Mission = player:getCurrentMission(SOA)
    if ((SOA_Mission >= tpz.mission.id.soa.BEAUTY_AND_THE_BEAST) and (SOA_Mission <= tpz.mission.id.soa.SALVATION)) then
        -- Speech while Arciela is 'kidnapped'
        player:startEvent(151)
    else
        -- Standard dialogue
        player:startEvent(501)
        -- Volgoi also has 579 associated with him, but it's the exact same dialogue
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
