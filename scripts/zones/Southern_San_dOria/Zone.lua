-----------------------------------
--
-- Zone: Southern_San_dOria (230)
--
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/quests/flyers_for_regine")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    zone:registerRegion(1, -292, -10, 90 , -258, 10, 105)
    quests.ffr.initZone(zone) -- register regions 2 through 6
    applyHalloweenNpcCostumes(zone:getID())
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
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

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    local regionID =region:GetRegionID()
    if regionID==1 and player:getCurrentMission(COP) == tpz.mission.id.cop.DAWN and player:getCharVar("COP_louverance_story")== 2 then
        player:startEvent(758)
    end
    quests.ffr.onRegionEnter(player, region) -- player approaching Flyers for Regine NPCs
end

function onRegionLeave(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 503 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 758 then
        player:setCharVar("COP_louverance_story", 3)
    elseif csid == 30035 then
        player:completeMission(ROV, tpz.mission.id.rov.RHAPSODIES_OF_VANADIEL)
        player:addMission(ROV, tpz.mission.id.rov.RESONACE)
    elseif csid == 30036 then
        player:completeMission(ROV, tpz.mission.id.rov.FATES_CALL)
        player:addMission(ROV, tpz.mission.id.rov.WHAT_LIES_BEYOND)
    end
end
