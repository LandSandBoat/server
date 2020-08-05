-----------------------------------
-- Area: Qufim Island (126)
--  NPC: Undulating Confluence
-- !pos -204.531 -20.027 75.318 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.AT_THE_HEAVENS_DOOR then
        player:startEvent(63)
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.THE_LIONS_ROAR then
        npcUtil.popFromQM(player, npc, ID.mob.OPHIOTAURUS, { look=true, hide=0 })
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.EDDIES_OF_DESPAIR_I then
        player:startEvent(64)
    elseif player:getCurrentMission(ROV) >= tpz.mission.id.rov.SET_FREE then
        player:startEvent(65)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 63 then
        player:completeMission(ROV, tpz.mission.id.rov.AT_THE_HEAVENS_DOOR)
        player:addMission(ROV, tpz.mission.id.rov.THE_LIONS_ROAR)
    elseif csid == 64 then
        player:setPos(-338, 6, -225, 172, 288)
    elseif csid == 65 and option == 1 then
        player:setPos(-338, 6, -225, 172, 288)
    end
end
