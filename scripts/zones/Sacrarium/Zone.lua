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

function onInitialize(zone)
    -- Set random variable for determining Old Prof. Mariselle's spawn location
    SetServerVariable("Old_Prof_Spawn_Location", math.random(2, 7))

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-219.996, -18.587, 82.795, 64)
    end
    return cs
end

function afterZoneIn(player)
    if (ENABLE_COP_ZONE_CAP == 1) then -- ZONE WIDE LEVEL RESTRICTION
        player:addStatusEffect(tpz.effect.LEVEL_RESTRICTION, 50, 0, 0) -- LV50 cap
    end
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onGameDay()
    -- change 18 labyrinth doors depending on in-game day (0 = open, 1 = closed)
    local labyrinthDoorsByDay =
    {
        [0] = {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0},
        [1] = {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0},
        [2] = {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
        [3] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
        [4] = {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0},
        [5] = {1, 0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0},
        [6] = {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
        [7] = {1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
    }
    local doors = labyrinthDoorsByDay[VanadielDayElement()]
    for i = 0, 17 do
        GetNPCByID(ID.npc.LABYRINTH_OFFSET + i):setAnimation(tpz.anim.OPEN_DOOR + doors[i+1])
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
