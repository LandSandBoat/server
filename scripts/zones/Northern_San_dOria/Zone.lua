-----------------------------------
--
-- Zone: Northern_San_dOria (231)
--
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)

    zone:registerRegion(1, -7, -3, 110, 7, -1, 155)
    quests.ffr.initZone(zone) -- register regions 2 through 6

    applyHalloweenNpcCostumes(zone:getID())
end

zone_object.onZoneIn = function(player, prevZone)

    local currentMission = player:getCurrentMission(SANDORIA)
    local missionStatus = player:getMissionStatus(player:getNation())
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 535
        end
        player:setPos(0, 0, -11, 191)
        player:setHomePoint()
    elseif ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    elseif
        player:getCurrentMission(ROV) == xi.mission.id.rov.FATES_CALL and
        (player:getRank(player:getNation()) > 5 or
        (player:getCurrentMission(player:getNation()) == xi.mission.id.nation.SHADOW_LORD and missionStatus >= 4))
    then
        cs = 30036
    -- SOA 1-1 Optional CS
    elseif
        ENABLE_SOA == 1 and
        player:getCurrentMission(SOA) == xi.mission.id.soa.RUMORS_FROM_THE_WEST and
        player:getCharVar("SOA_1_CS1") == 0
    then
        cs = 878
    -- RDM AF3 CS
    elseif player:getCharVar("peaceForTheSpiritCS") == 5 and player:getFreeSlotsCount() >= 1 then
        cs = 49
    elseif player:getCurrentMission(COP) == xi.mission.id.cop.THE_ROAD_FORKS and player:getCharVar("EMERALD_WATERS_Status") == 1 then --EMERALD_WATERS-- COP 3-3A: San d'Oria Route
        player:setCharVar("EMERALD_WATERS_Status", 2)
        cs = 14
    elseif currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus == 0 then
        cs = 1
    elseif currentMission == xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT and missionStatus == 4 then
        cs = 0
    elseif player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.COMING_OF_AGE) then
        local waitDate = player:getCharVar("Wait1DayM8-1_date")
        if waitDate ~= 0 and os.time() > waitDate then
            cs = 16
        end
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(130, -0.2, -3, 160)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    switch (region:GetRegionID()): caseof
    {
        [1] = function (x)  -- Chateau d'Oraguille access
        pNation = player:getNation()
        currentMission = player:getCurrentMission(pNation)
            if (pNation == 0 and player:getRank() >= 2) or (pNation > 0 and player:hasCompletedMission(pNation, 5) == 1) or (currentMission >= 5 and currentMission <= 9) or (player:getRank() >= 3) then
                player:startEvent(569)
            else
                player:startEvent(568)
            end
        end,
    }
    quests.ffr.onRegionEnter(player, region) -- player approaching Flyers for Regine NPCs
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 535 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536) -- adventurer coupon
    elseif csid == 1 then
        player:setMissionStatus(player:getNation(), 1)
    elseif csid == 0 then
        player:setMissionStatus(player:getNation(), 5)
    elseif csid == 569 then
        player:setPos(0, 0, -13, 192, 233)
    elseif csid == 49 and npcUtil.completeQuest(player, SANDORIA, xi.quest.id.sandoria.PEACE_FOR_THE_SPIRIT, {item = 12513, fame = 60, title = xi.title.PARAGON_OF_RED_MAGE_EXCELLENCE}) then
        player:setCharVar("peaceForTheSpiritCS", 0)
    elseif csid == 16 then
        player:setCharVar("Wait1DayM8-1_date", 0)
        player:setCharVar("Mission8-1Completed", 1)
    elseif csid == 878 then
        player:setCharVar("SOA_1_CS1", 1)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
