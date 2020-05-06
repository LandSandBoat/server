-----------------------------------
--
-- Zone: Bastok_Markets (235)
--
-----------------------------------
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/zone")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------

function onInitialize(zone)
    applyHalloweenNpcCostumes(zone:getID())
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 0
        end
        player:setPos(-280, -12, -91, 15)
        player:setHomePoint()
    elseif ENABLE_ROV == 1 and player:getCurrentMission(ROV) == tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    elseif player:getCurrentMission(ROV) == tpz.mission.id.rov.FATES_CALL and player:getCurrentMission(player:getNation()) > 15 then
        cs = 30036
    -- SOA 1-1 Optional CS
    elseif
        ENABLE_SOA == 1 and
        player:getCurrentMission(SOA) == tpz.mission.id.soa.RUMORS_FROM_THE_WEST and
        player:getCharVar("SOA_1_CS2") == 0
    then
        cs = 22
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) - 33
        player:setPos(-177, -8, position, 127)
    end

    return cs
end

function onConquestUpdate(zone,  updatetype)
    tpz.conq.onConquestUpdate(zone,  updatetype)
end

function onRegionEnter(player, region)
end

function onGameDay()
    -- Removes daily the bit mask that tracks the treats traded for Harvest Festival.
    if isHalloweenEnabled() ~= 0 then
        clearVarFromAll("harvestFestTreats")
        clearVarFromAll("harvestFestTreats2")
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 0 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 22 then
        player:setCharVar("SOA_1_CS2",  1)
    elseif csid == 30035 then
        player:completeMission(ROV, tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(ROV, tpz.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(ROV, tpz.mission.id.rov.FATES_CALL)
        player:addMission(ROV, tpz.mission.id.rov.WHAT_LIES_BEYOND)
    end
end
