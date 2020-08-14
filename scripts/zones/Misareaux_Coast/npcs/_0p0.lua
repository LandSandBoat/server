-----------------------------------
-- Area: Misareaux Coast
--  NPC: Dilapidated Gate
-- !pos 260 9 -435 25
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/missions")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local cop = player:getCurrentMission(COP)
    local copStat = player:getCharVar("PromathiaStatus")

    -- AN ETERNAL MEMORY (PM2-4)
    if (cop == tpz.mission.id.cop.AN_ETERNAL_MELODY and copStat == 1) then
        player:startEvent(5)

    -- SHELTERING DOUBT (PM4-1)
    elseif (cop == tpz.mission.id.cop.SHELTERING_DOUBT and copStat == 3) then
        player:startEvent(7)

    -- A PLACE TO RETURN (PM6-2)
    elseif (
        cop == tpz.mission.id.cop.A_PLACE_TO_RETURN and copStat == 1 and
        player:getCharVar("Warder_Aglaia_KILL") == 1 and
        player:getCharVar("Warder_Euphrosyne_KILL") == 1 and
        player:getCharVar("Warder_Thalia_KILL") == 1
    ) then
        player:startEvent(10)
    elseif (
        cop == tpz.mission.id.cop.A_PLACE_TO_RETURN and copStat == 1 and
        not GetMobByID(ID.mob.PM6_2_MOB_OFFSET + 0):isSpawned() and
        not GetMobByID(ID.mob.PM6_2_MOB_OFFSET + 1):isSpawned() and
        not GetMobByID(ID.mob.PM6_2_MOB_OFFSET + 2):isSpawned()
    ) then
        SpawnMob(ID.mob.PM6_2_MOB_OFFSET + 0):updateClaim(player)
        SpawnMob(ID.mob.PM6_2_MOB_OFFSET + 1):updateClaim(player)
        SpawnMob(ID.mob.PM6_2_MOB_OFFSET + 2):updateClaim(player)

    -- DEFAULT DIALOG
    else
        player:messageSpecial(ID.text.DOOR_CLOSED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    -- AN ETERNAL MEMORY (PM2-4)
    if (csid == 5) then
        player:setCharVar("PromathiaStatus", 2)

    -- SHELTERING DOUBT (PM4-1)
    elseif (csid == 7) then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(COP, tpz.mission.id.cop.SHELTERING_DOUBT)
        player:addMission(COP, tpz.mission.id.cop.THE_SAVAGE)

    -- A PLACE TO RETURN (PM6-2)
    elseif (csid == 10) then
        player:setCharVar("PromathiaStatus", 0)
        player:setCharVar("Warder_Aglaia_KILL", 0)
        player:setCharVar("Warder_Euphrosyne_KILL", 0)
        player:setCharVar("Warder_Thalia_KILL", 0)
        player:completeMission(COP, tpz.mission.id.cop.A_PLACE_TO_RETURN)
        player:addMission(COP, tpz.mission.id.cop.MORE_QUESTIONS_THAN_ANSWERS)
    end
end
