-----------------------------------
--
-- Zone: RoMaeve (122)
--
-----------------------------------
local ID = require("scripts/zones/RoMaeve/IDs");
require("scripts/globals/conquest");
require("scripts/globals/missions");
require("scripts/globals/npc_util");
require("scripts/globals/weather");
require("scripts/globals/status");
-----------------------------------

function onInitialize(zone)
    local newPosition = npcUtil.pickNewPosition(ID.npc.BASTOK_7_1_QM, ID.npc.BASTOK_7_1_QM_POS, true);
    GetNPCByID(ID.npc.BASTOK_7_1_QM):setPos(newPosition.x, newPosition.y, newPosition.z);
end;

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end;

function onZoneIn(player,prevZone)
    local cs = -1;
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-0.008,-33.595,123.478,62);
    end
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 3; -- doll telling "you're in the right area"
    end
    return cs;
end;

function onRegionEnter(player,region)
end;

function onGameDay()
    if (IsMoonFull() and GetNPCByID(ID.npc.MOONGATE_OFFSET):getWeather() == tpz.weather.SUNSHINE) then
        for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET+7 do
            GetNPCByID(i):openDoor(432);
        end
    end
end;

function onZoneWeatherChange(weather)
    if (weather ~= tpz.weather.SUNSHINE and GetNPCByID(ID.npc.MOONGATE_OFFSET):getAnimation() ~= tpz.anim.CLOSE_DOOR) then
        for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET+7 do
            GetNPCByID(i):setAnimation(tpz.anim.CLOSE_DOOR);
        end
    elseif (weather == tpz.weather.SUNSHINE and IsMoonFull() == true and VanadielHour() < 3) then -- reactivate things for the remainder of the time until 3AM
        local moonMinRemaining = math.floor(432 * (180 - VanadielHour() * 60 + VanadielMinute())/180) -- 180 minutes (ie 3AM) subtract the time that has passed since midnight
        for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET+7 do
            GetNPCByID(i):openDoor(moonMinRemaining);
        end
    end
end;

function onEventUpdate(player,csid,option)
end;

function onEventFinish(player,csid,option)
end;
