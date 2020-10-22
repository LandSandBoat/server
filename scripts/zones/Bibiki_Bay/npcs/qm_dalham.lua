-----------------------------------
-- Area: Bibiki Bay
-- NPC:  ??? COP mission spawn Dalham
-- !pos
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/missions")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cop = player:getCurrentMission(COP)

    if (cop == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and not GetMobByID(ID.mob.DALHAM):isSpawned() and player:getCharVar("COP_Dalham_KILL") == 0) then
        SpawnMob(ID.mob.DALHAM):updateClaim(player)
    elseif (cop == tpz.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Dalham_KILL") == 1) then
        player:startEvent(41)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 41) then
        player:setCharVar("COP_Dalham_KILL", 2)
    end
end
