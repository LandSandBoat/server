-----------------------------------
--
-- Zone: Buburimu_Peninsula (118)
--
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/globals/icanheararainbow");
require("scripts/globals/chocobo_digging");
require("scripts/globals/conquest");
require("scripts/globals/helm")
require("scripts/globals/zone");
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end;

function onInitialize(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end;

function onZoneIn( player, prevZone)
    local cs = -1;

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( -276.529, 16.403, -324.519, 14);
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 3;
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 5; -- zone 4 buburimu no update (north)
    end

    return cs;
end;

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end;

function onRegionEnter(player,region)
end;

function onEventUpdate( player, csid, option)
    if (csid == 3) then
        lightCutsceneUpdate(player); -- Quest: I Can Hear A Rainbow
    elseif (csid == 5) then
        if (player:getPreviousZone() == tpz.zone.LABYRINTH_OF_ONZOZO or player:getPreviousZone() == tpz.zone.MHAURA) then
            player:updateEvent(0,0,0,0,0,7);
        elseif (player:getPreviousZone() == tpz.zone.MAZE_OF_SHAKHRAMI) then
            player:updateEvent(0,0,0,0,0,6);
        end
    end
end;

function onEventFinish( player, csid, option)
    if (csid == 3) then
        lightCutsceneFinish(player); -- Quest: I Can Hear A Rainbow
    end
end;
