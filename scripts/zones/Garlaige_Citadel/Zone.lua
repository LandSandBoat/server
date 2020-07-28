-----------------------------------
--
-- Zone: Garlaige_Citadel (200)
--
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/conquest")
require("scripts/globals/treasure")
require("scripts/globals/status")
-----------------------------------

function onInitialize(zone)
    -- Banishing Gate #1...
    zone:registerRegion(1, -208, -1, 224, -206, 1, 227)
    zone:registerRegion(2, -208, -1, 212, -206, 1, 215)
    zone:registerRegion(3, -213, -1, 224, -211, 1, 227)
    zone:registerRegion(4, -213, -1, 212, -211, 1, 215)
    -- Banishing Gate #2
    zone:registerRegion(10, -51, -1, 82, -49, 1, 84)
    zone:registerRegion(11, -151, -1, 82, -149, 1, 84)
    zone:registerRegion(12, -51, -1, 115, -49, 1, 117)
    zone:registerRegion(13, -151, -1, 115, -149, 1, 117)
    -- Banishing Gate #3
    zone:registerRegion(19, -190, -1, 355, -188, 1, 357)
    zone:registerRegion(20, -130, -1, 355, -128, 1, 357)
    zone:registerRegion(21, -190, -1, 322, -188, 1, 324)
    zone:registerRegion(22, -130, -1, 322, -128, 1, 324)

    UpdateNMSpawnPoint(ID.mob.OLD_TWO_WINGS)
    GetMobByID(ID.mob.OLD_TWO_WINGS):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.SKEWER_SAM)
    GetMobByID(ID.mob.SKEWER_SAM):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.SERKET)
    GetMobByID(ID.mob.SERKET):setRespawnTime(math.random(900, 10800))

    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-380.035, -13.548, 398.032, 64)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    local regionId = region:GetRegionID()
    local leverSet = math.floor(regionId / 9)              -- the set of levers player is standing on (0, 1, 2)
    local gateId = ID.npc.BANISHING_GATE_OFFSET + (9 * leverSet)  -- the ID of the related gate

    -- if all levers are down, open gate for 30 seconds
    GetNPCByID(ID.npc.BANISHING_GATE_OFFSET + regionId):setAnimation(tpz.anim.OPEN_DOOR)
    if (
        GetNPCByID(gateId + 1):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(gateId + 2):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(gateId + 3):getAnimation() == tpz.anim.OPEN_DOOR and
        GetNPCByID(gateId + 4):getAnimation() == tpz.anim.OPEN_DOOR
    ) then
        player:messageSpecial(ID.text.BANISHING_GATES + leverSet)
        GetNPCByID(gateId):openDoor(30)
    end

end

function onRegionLeave(player, region)
    GetNPCByID(ID.npc.BANISHING_GATE_OFFSET + region:GetRegionID()):setAnimation(tpz.anim.CLOSE_DOOR)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
