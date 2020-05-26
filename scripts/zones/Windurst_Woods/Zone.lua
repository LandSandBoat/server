-----------------------------------
--
-- Zone: Windurst_Woods (241)
--
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/events/harvest_festivals")
require("scripts/globals/conquest")
require("scripts/globals/settings")
require("scripts/globals/chocobo")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    applyHalloweenNpcCostumes(zone:getID())
    tpz.chocobo.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    -- FIRST LOGIN (START CS)
    if player:getPlaytime(false) == 0 then
        if NEW_CHARACTER_CUTSCENE == 1 then
            cs = 367
        end
        player:setPos(0, 0, -50, 0)
        player:setHomePoint()
    -- SOA 1-1 Optional CS
    elseif
        ENABLE_SOA == 1 and
        player:getCurrentMission(SOA) == tpz.mission.id.soa.RUMORS_FROM_THE_WEST and
        player:getCharVar("SOA_1_CS3") == 0
    then
        cs = 839
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 37
        player:setPos(-138, -10, position, 0)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 367 then
        player:messageSpecial(ID.text.ITEM_OBTAINED, 536)
    elseif csid == 839 then
        player:setCharVar("SOA_1_CS3", 1)
    end
end
