-----------------------------------
--
-- Zone: Bastok_Markets (235)
--
-----------------------------------
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/missions")
require("scripts/settings/main")
require("scripts/globals/zone")
local ID = require("scripts/zones/Bastok_Markets/IDs")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    applyHalloweenNpcCostumes(zone:getID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 0
        end
        player:setPos(-280, -12, -91, 15)
        player:setHomePoint()
    elseif xi.settings.ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    elseif
        player:getCurrentMission(ROV) == xi.mission.id.rov.FATES_CALL and
        (player:getRank(player:getNation()) > 5 or
        (player:getCurrentMission(player:getNation()) == xi.mission.id.nation.SHADOW_LORD and player:getMissionStatus(player:getNation()) >= 4))
    then
        cs = 30036
    -- SOA 1-1 Optional CS
    elseif
        xi.settings.ENABLE_SOA == 1 and
        player:getCurrentMission(SOA) == xi.mission.id.soa.RUMORS_FROM_THE_WEST and
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

zone_object.onConquestUpdate = function(zone,  updatetype)
    xi.conq.onConquestUpdate(zone,  updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameDay = function()
    -- Removes daily the bit mask that tracks the treats traded for Harvest Festival.
    if isHalloweenEnabled() ~= 0 then
        clearVarFromAll("harvestFestTreats")
        clearVarFromAll("harvestFestTreats2")
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)

    if csid == 0 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 22 then
        player:setCharVar("SOA_1_CS2",  1)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
