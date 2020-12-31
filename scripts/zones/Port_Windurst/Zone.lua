-----------------------------------
--
-- Zone: Port_Windurst (240)
--
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

function onZoneIn(player,prevZone)
    local cs = -1

    if ENABLE_ROV == 1 and player:getCurrentMission(ROV) == tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    end

    if player:getCurrentMission(ROV) == tpz.mission.id.rov.FATES_CALL and player:getCurrentMission(player:getNation()) > 15 then
        cs = 30036
    end

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 305
        end
        player:setPos(-120, -5.5, 175, 48)
        player:setHomePoint()
    end
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        if (prevZone == tpz.zone.WINDURST_JEUNO_AIRSHIP) then
            cs = 10004
            player:setPos(228.000, -3.000, 76.000, 160)
        else
            local position = math.random(1, 5) + 195
            player:setPos(position, -15.56, 258, 65)
        end
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onTransportEvent(player, transport)
    player:startEvent(10002)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 305) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif (csid == 10002) then
        player:setPos(0, 0, 0, 0, 225)
    elseif csid == 30035 then
        player:completeMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.FATES_CALL)
        player:addMission(tpz.mission.log_id.ROV, tpz.mission.id.rov.WHAT_LIES_BEYOND)
    end
end
