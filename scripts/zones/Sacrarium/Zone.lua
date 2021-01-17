-----------------------------------
--
-- Zone: Sacrarium (28)
--
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/treasure")
require("scripts/globals/status")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    -- Set random variable for determining Old Prof. Mariselle's spawn location
    SetServerVariable("Old_Prof_Spawn_Location", math.random(2, 7))

    tpz.treasure.initZone(zone)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-219.996, -18.587, 82.795, 64)
    end
    return cs
end

zone_object.afterZoneIn = function(player)
    if (ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 50, 0, 0) -- LV50 cap
    end
end

zone_object.onConquestUpdate = function(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameDay = function()
    -- change 18 labyrinth doors depending on in-game day (0 = open, 1 = closed)
    local labyrinthDoorsByDay =
    {
        [tpz.day.FIRESDAY]     = {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0},
        [tpz.day.EARTHSDAY]    = {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0},
        [tpz.day.WATERSDAY]    = {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
        [tpz.day.WINDSDAY]     = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
        [tpz.day.ICEDAY]       = {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0},
        [tpz.day.LIGHTNINGDAY] = {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0},
        [tpz.day.LIGHTSDAY]    = {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
        [tpz.day.DARKSDAY]     = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
    };
    local doors = labyrinthDoorsByDay[VanadielDayOfTheWeek()]
    for i = 0, 17 do
        GetNPCByID(ID.npc.LABYRINTH_OFFSET + i):setAnimation(tpz.anim.OPEN_DOOR + doors[i+1])
    end
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
end

return zone_object
