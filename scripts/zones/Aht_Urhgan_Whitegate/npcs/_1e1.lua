-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Salaheem's Sentinels (Door)
-- !pos 23 -6 -63 50
-----------------------------------
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and player:getCharVar("AhtUrganStatus") > 0 then
        return
    end
    npc:openDoor()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
