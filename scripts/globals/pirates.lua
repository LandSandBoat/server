-----------------------------------
-- Pirates helpers
-----------------------------------
require("scripts/globals/pathfind")

xi = xi or {}
xi.pirates = xi.pirates or {}
xi.pirates.status =
{
    IDLE       = 0,
    PREPARING  = 1,
    ARRIVING   = 2,
    SPAWNING   = 3,
    ATTACKING  = 4,
    DESPAWNING = 5,
    DEPARTING  = 6,
    FINISHED   = 7
}

local function SetZoneMusic(zone, block, track)
    for _, player in pairs(zone:getPlayers()) do
        player:ChangeMusic(block, track)
    end
end

xi.pirates.init = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
    ship:setStatus(xi.status.DISAPPEAR)

    for k, pirate in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        npc:setPos(pirate.start_pos)
        npc:initNpcAi()
    end
end

xi.pirates.start = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setLocalVar("pirateStatus", xi.pirates.status.IDLE)
    xi.pirates.despawnMobs(ID)
    xi.pirates.reset(ID)
end

xi.pirates.reset = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setAnimation(0)
    ship:setStatus(xi.status.DISAPPEAR)
    xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
    GetMobByID(ID.mob.CROSSBONES + 5):setLocalVar("killed", 0)
end

xi.pirates.spawnMob = function(mobId)
    local x = math.random(-4,4)
    local y = -7.263
    local z = math.random(10,22)
    local rot = math.random(0,255)
    local mob = GetMobByID(mobId)
    mob:setSpawn(x,y,z,rot)
    mob:spawn()
end

xi.pirates.spawnMobs = function(ID)
    for i = 0, 3 do
        local xbone = GetMobByID(ID.mob.CROSSBONES + i)
        if
            not xbone:isSpawned() and
            os.time() > xbone:getLocalVar("respawnTime")
        then
            xi.pirates.spawnMob(ID.mob.CROSSBONES + i)
        end
    end

    local wight = GetMobByID(ID.mob.CROSSBONES + 4)
    local nm = GetMobByID(ID.mob.CROSSBONES + 5)

    if
        not wight:isSpawned() and
        not nm:isSpawned()
    then
        if os.time() > wight:getLocalVar("respawnTime") then
            if
                nm:getLocalVar("killed") == 1 or
                math.random(0,100) < 95
            then
                xi.pirates.spawnMob(ID.mob.CROSSBONES + 4)
            else
                xi.pirates.spawnMob(ID.mob.CROSSBONES + 5)
            end
        end
    end
end

xi.pirates.despawnMobs = function(ID)
    for i = 0, 3 do
        if GetMobByID(ID.mob.CROSSBONES + i):isSpawned() then
            if not GetMobByID(ID.mob.CROSSBONES + i):isEngaged() then
                DespawnMob(ID.mob.CROSSBONES + i)
            end
        end
    end
    if GetMobByID(ID.mob.CROSSBONES + 4):isSpawned() then
        if not GetMobByID(ID.mob.CROSSBONES + 4):isEngaged() then
            DespawnMob(ID.mob.CROSSBONES + 4)
        end
    end
    if GetMobByID(ID.mob.CROSSBONES + 5):isSpawned() then
        if not GetMobByID(ID.mob.CROSSBONES + 5):isEngaged() then
            DespawnMob(ID.mob.CROSSBONES + 5)
        end
    end
end

xi.pirates.despawnNPCs = function(ID)
    for k in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        npc:setLocalVar("summoning", 0)
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

xi.pirates.setShipPosition = function(ship, pos)
    ship:setPos(pos.x, pos.y, pos.z, pos.rot)
end

xi.pirates.summonAnimations = function(ID, firstcast)
    for k in pairs(ID.npc.PIRATES) do
        local npc = GetNPCByID(k)
        if
            npc:getLocalVar("castmode") == 1 and
            npc:getLocalVar("summoning") == 0
        then
            npc:setLocalVar("summoning", 1)
            local startTime = 0
            if not firstcast then
                startTime = 2000 + math.random(2000,3000)
            end
            npc:timer(startTime, function(npcArg)
                if npcArg:getLocalVar("castmode") == 1 then
                    npcArg:entityAnimationPacket("casm")
                    local randomSummonTime = 2000 + math.random(0,2000)
                    npcArg:timer(randomSummonTime, function(npcArg2)
                        npcArg2:entityAnimationPacket("shsm")
                        npcArg2:setLocalVar("summoning", 0)
                    end)
                end
            end)
        end
    end
end

xi.pirates.update = function(ID, zone, tripTime)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    local pirateStatus = ship:getLocalVar("pirateStatus")

    switch (pirateStatus): caseof
    {
        [0] = function (x)
            if tripTime >= 200 then
                SetZoneMusic(zone, 0, 0)
                SetZoneMusic(zone, 1, 0)
                ship:setLocalVar("pirateStatus", xi.pirates.status.PREPARING)
            end
        end,
        [1] = function (x)
            if tripTime >= 240 then
                ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
                ship:setAnimation(18)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                ship:setStatus(xi.status.NORMAL)
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange(2000)
                ship:setLocalVar("pirateStatus", xi.pirates.status.ARRIVING)
            end
        end,
        [2] = function (x)
            if tripTime >= 290 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setPos(xi.path.first(pirate.enter_path))
                    npc:pathTo(xi.path.last(pirate.enter_path)[1], xi.path.last(pirate.enter_path)[2], xi.path.last(pirate.enter_path)[3])
                    npc:setStatus(xi.status.NORMAL)
                    npc:sendUpdateToZoneCharsInRange(2000)
                end
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:sendUpdateToZoneCharsInRange(2000)
                ship:setLocalVar("pirateStatus", xi.pirates.status.SPAWNING)
            end
        end,
        [3] = function (x)
            if tripTime >= 297 then
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:setAnimation(0)
                ship:sendUpdateToZoneCharsInRange(2000)
                ship:setLocalVar("pirateStatus", xi.pirates.status.ATTACKING)
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",1)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange(2000)
                end
                xi.pirates.summonAnimations(ID, true)
            else
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange(2000)
                end
            end
        end,
        [4] = function (x)
            if tripTime >= 695 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",0)
                    npc:pathTo(xi.path.last(pirate.exit_path)[1], xi.path.last(pirate.exit_path)[2], xi.path.last(pirate.exit_path)[3])
                end
                xi.pirates.despawnMobs(ID)
                ship:setLocalVar("pirateStatus", xi.pirates.status.DESPAWNING)
            elseif tripTime <= 685 and tripTime >= 304 then
                xi.pirates.summonAnimations(ID, false)
                xi.pirates.spawnMobs(ID)
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
            end
        end,
        [5] = function (x)
            if tripTime >= 706 then
                xi.pirates.despawnNPCs(ID)
                ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
                ship:setAnimation(19)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange(2000)
                ship:setLocalVar("pirateStatus", xi.pirates.status.DEPARTING)
            end
        end,
        [6] = function (x)
            if tripTime >= 760 then
                SetZoneMusic(zone, 0, 106)
                SetZoneMusic(zone, 1, 106)
                ship:setAnimation(0)
                ship:setStatus(xi.status.DISAPPEAR)
                ship:sendUpdateToZoneCharsInRange(2000)
                ship:setLocalVar("pirateStatus", xi.pirates.status.FINISHED)
            end
        end,
        [7] = function (x)
            xi.pirates.despawnMobs(ID)
        end
    }
end
