-----------------------------------
--
-- Zone: Davoi (149)
--
-----------------------------------
local ID = require("scripts/zones/Davoi/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/treasure")
require("scripts/globals/quests")
-----------------------------------

function onInitialize(zone)
    tpz.treasure.initZone(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(282.292, 2.498, -17.908, 247)
    end
    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.INFILTRATE_DAVOI and player:getCharVar("MissionStatus") == 2 then
        cs = 116
    end
    if player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.THE_CRIMSON_TRIAL) == QUEST_ACCEPTED and not GetMobByID(ID.mob.PURPLEFLASH_BRUKDOK):isSpawned() then
        SpawnMob(ID.mob.PURPLEFLASH_BRUKDOK) -- Spawned by Quest: The Crimson Trial upon entering the zone
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onGameDay()
    -- move storage hole
    local positions =
    {
        {-177.925,  4.000, -255.699},
        {-127.703,  4.250,   23.732},
        {-127.822,  4.250,  -16.964},
        {-123.369,  4.000, -231.972},
        { -51.570,  4.127, -216.462},
        { -55.960,  2.958, -300.014},
        { 152.311,  4.000,  -74.176},
        { 153.514,  4.250, -112.616},
        { 188.988,  4.000,  -80.058},
        { 318.694,  0.001,  -58.646},
        { 299.717,  0.001, -160.910},
        { 274.849,  4.162, -213.599},
        { 250.809,  4.000, -240.509},
        { 219.474,  3.750, -128.170},
        {  86.749, -5.166, -166.414},
    }
    local newPosition = npcUtil.pickNewPosition(ID.npc.STORAGE_HOLE, positions)
    GetNPCByID(ID.npc.STORAGE_HOLE):setPos(newPosition.x, newPosition.y, newPosition.z)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 116 then
        player:setCharVar("MissionStatus", 3)
    end
end
