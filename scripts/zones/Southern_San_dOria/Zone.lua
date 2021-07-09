-----------------------------------
-- Zone: Southern_San_dOria (230)
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -292, -10, 90 , -258, 10, 105)
    quests.ffr.initZone(zone) -- register regions 2 through 6
    applyHalloweenNpcCostumes(zone:getID())
    xi.chocobo.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if xi.settings.ENABLE_ROV == 1 and player:getCurrentMission(ROV) == xi.mission.id.rov.RHAPSODIES_OF_VANADIEL and player:getMainLvl()>=3 then
        cs = 30035
    end

    if
        player:getCurrentMission(ROV) == xi.mission.id.rov.FATES_CALL and
        (player:getRank(player:getNation()) > 5 or
        (player:getCurrentMission(player:getNation()) == xi.mission.id.nation.SHADOW_LORD and player:getMissionStatus(player:getNation()) >= 4))
    then
        cs = 30036
    end

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if xi.settings.NEW_CHARACTER_CUTSCENE == 1 then
            cs = 503
        end
        player:setPos(-96, 1, -40, 224)
        player:setHomePoint()
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(161, -2, 161, 94)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
    local regionID =region:GetRegionID()
    if regionID==1 and player:getCurrentMission(COP) == xi.mission.id.cop.DAWN and player:getCharVar("COP_louverance_story")== 2 then
        player:startEvent(758)
    end
    quests.ffr.onRegionEnter(player, region) -- player approaching Flyers for Regine NPCs
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 503 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 758 then
        player:setCharVar("COP_louverance_story", 3)
    elseif csid == 30035 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.FATES_CALL)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.WHAT_LIES_BEYOND)
    end
end

return zone_object
