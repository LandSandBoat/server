-----------------------------------
--
-- Zone: Jugner_Forest (104)
--
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    zone:registerRegion(1, -484, 10, 292, 0, 0, 0) -- Sets Mark for "Under Oath" Quest cutscene.

    UpdateNMSpawnPoint(ID.mob.FRAELISSA)
    GetMobByID(ID.mob.FRAELISSA):setRespawnTime(math.random(900, 10800))

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)

    local respawnTime = 900 + math.random(0, 6) * 1800 -- 0:15 to 3:15 spawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(ID.mob.KING_ARTHRO - offset):setRespawnTime(respawnTime)
    end
end

function onZoneIn( player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 342, -5, 15.117, 169)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 15
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter( player, region)
    if region:GetRegionID() == 1 and player:getCharVar("UnderOathCS") == 7 then -- Quest: Under Oath - PLD AF3
        player:startEvent(14)
    end
end

function onEventUpdate( player, csid, option)
    if csid == 15 then
        quests.rainbow.onEventUpdate(player)
    end
end

function onEventFinish( player, csid, option)
    if csid == 14 then
        player:setCharVar("UnderOathCS", 8) -- Quest: Under Oath - PLD AF3
    end
end
