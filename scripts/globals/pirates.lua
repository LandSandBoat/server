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
    xi.pirates.setStatus(ship, xi.pirates.status.IDLE)
    xi.pirates.despawnMobs(ID)
    xi.pirates.despawnNPCs(ID)
    xi.pirates.reset(ID)
end

xi.pirates.getStatus = function(ship)
    return ship:getLocalVar("pirateStatus")
end

xi.pirates.setStatus = function(ship, status)
    ship:setLocalVar("pirateStatus", status)
end

xi.pirates.reset = function(ID)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    ship:setAnimation(0)
    ship:setStatus(xi.status.DISAPPEAR)
    xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
    ship:sendUpdateToZoneCharsInRange()
    GetMobByID(ID.mob.NM):setLocalVar("killed", 0)
end

xi.pirates.spawnMob = function(mobId)
    local x = math.random(-4.5,4.5)
    local y = -7.263
    local z = math.random(10,22)
    local rot = math.random(0,255)
    local mob = GetMobByID(mobId)
    mob:setSpawn(x,y,z,rot)
    mob:spawn()
end

xi.pirates.spawnMobs = function(ID)
    for i = 1, #ID.mob.CROSSBONES do
        local xbone = GetMobByID(ID.mob.CROSSBONES[i])
        if not xbone:isSpawned() and os.time() > xbone:getLocalVar("respawnTime") then
            xi.pirates.spawnMob(ID.mob.CROSSBONES[i])
        end
    end
    local wight = GetMobByID(ID.mob.SHIP_WIGHT)
    local nm = GetMobByID(ID.mob.NM)
    if not wight:isSpawned() and not nm:isSpawned() then
        if os.time() > wight:getLocalVar("respawnTime") then
            if nm:getLocalVar("killed") == 1 or math.random(0,100) < 95 then
                xi.pirates.spawnMob(ID.mob.SHIP_WIGHT)
            else
                xi.pirates.spawnMob(ID.mob.NM)
            end
        end
    end
end

xi.pirates.despawnMobs = function(ID)
    for i = 1, #ID.mob.CROSSBONES do
        if GetMobByID(ID.mob.CROSSBONES[i]):isSpawned() and GetMobByID(ID.mob.CROSSBONES[i]):getCurrentAction() == xi.act.ROAMING then
            DespawnMob(ID.mob.CROSSBONES[i])
        end
    end
    if GetMobByID(ID.mob.SHIP_WIGHT):isSpawned() and GetMobByID(ID.mob.SHIP_WIGHT):getCurrentAction() == xi.act.ROAMING then
        DespawnMob(ID.mob.SHIP_WIGHT)
    end
    if GetMobByID(ID.mob.NM):isSpawned() and GetMobByID(ID.mob.NM):getCurrentAction() == xi.act.ROAMING then
        DespawnMob(ID.mob.NM)
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
        if npc:getLocalVar("castmode") == 1 and npc:getLocalVar("summoning") == 0 then
            npc:setLocalVar("summoning", 1)
            local startTime = 0
            if not firstcast then
                startTime = 2000 + math.random(0,2000)
            end
            npc:timer(startTime, function(npc)
                if npc:getLocalVar("castmode") == 1 then
                    npc:entityAnimationPacket("casm")
                    local randomSummonTime = 2000 + math.random(0,2000)
                    npc:timer(randomSummonTime, function(npc)
                        npc:entityAnimationPacket("shsm")
                        npc:setLocalVar("summoning", 0)
                    end)
                end
            end)
        end
    end
end

xi.pirates.update = function(ID, zone, tripTime)
    local ship = GetNPCByID(ID.npc.PIRATE_SHIP.id)
    local pirateStatus = xi.pirates.getStatus(ship)

    switch (pirateStatus): caseof
    {
        [xi.pirates.status.IDLE] = function (x)
            if tripTime >= 200 then
                SetZoneMusic(zone, 0, 0)
                SetZoneMusic(zone, 1, 0)
                xi.pirates.setStatus(ship, xi.pirates.status.PREPARING)
            end
        end,
        [xi.pirates.status.PREPARING] = function (x)
            if tripTime >= 240 then
                ship:setAnimation(18)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                ship:setStatus(xi.status.NORMAL)
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange()
                xi.pirates.setStatus(ship, xi.pirates.status.ARRIVING)
            end
        end,
        [xi.pirates.status.ARRIVING] = function (x)
            if tripTime >= 290 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setPos(xi.path.first(pirate.enter_path))
                    xi.path.patrol(npc, pirate.enter_path)
                    npc:lookAt(pirate.look_at)
                    npc:setStatus(xi.status.NORMAL)
                    npc:sendUpdateToZoneCharsInRange()
                end
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:sendUpdateToZoneCharsInRange()
                xi.pirates.setStatus(ship, xi.pirates.status.SPAWNING)
            end
        end,
        [xi.pirates.status.SPAWNING] = function (x)
            if tripTime >= 296 then
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.event_pos)
                ship:setAnimation(0)
                ship:sendUpdateToZoneCharsInRange()
                xi.pirates.setStatus(ship, xi.pirates.status.ATTACKING)
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",1)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange()
                end
                xi.pirates.summonAnimations(ID, true)
                xi.pirates.spawnMobs(ID)
            else
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    xi.path.patrol(npc, pirate.enter_path)
                    npc:lookAt(pirate.look_at)
                    npc:sendUpdateToZoneCharsInRange()
                end
            end
        end,
        [xi.pirates.status.ATTACKING] = function (x)
            if tripTime >= 695 then
                for k, pirate in pairs(ID.npc.PIRATES) do
                    local npc = GetNPCByID(k)
                    npc:setLocalVar("castmode",0)
                    npc:setPos(xi.path.first(pirate.exit_path))
                    xi.path.patrol(npc, pirate.exit_path)
                end
                xi.pirates.despawnMobs(ID)
                xi.pirates.setStatus(ship, xi.pirates.status.DESPAWNING)
            elseif tripTime <= 685 then
                xi.pirates.summonAnimations(ID, false)
                xi.pirates.spawnMobs(ID)
                SetZoneMusic(zone, 0, 170)
                SetZoneMusic(zone, 1, 170)
            end
        end,
        [xi.pirates.status.DESPAWNING] = function (x)
            xi.pirates.despawnMobs(ID)
            if tripTime >= 706 then
                xi.pirates.despawnNPCs(ID)
                ship:setAnimPath(ID.npc.PIRATE_SHIP.anim_path)
                ship:setAnimation(19)
                ship:setAnimStart(true)
                ship:setAnimBegin(VanadielTime())
                xi.pirates.setShipPosition(ship, ID.npc.PIRATE_SHIP.start_pos)
                ship:sendUpdateToZoneCharsInRange()
                xi.pirates.setStatus(ship, xi.pirates.status.DEPARTING)
            else
                for k, pirate in pairs(ID.npc.PIRATES) do
                    xi.path.patrol(GetNPCByID(k), pirate.exit_path)
                end
            end
        end,
        [xi.pirates.status.DEPARTING] = function (x)
            xi.pirates.despawnMobs(ID)
            if tripTime >= 760 then
                SetZoneMusic(zone, 0, 106)
                SetZoneMusic(zone, 1, 106)
                ship:setAnimation(0)
                ship:setStatus(xi.status.DISAPPEAR)
                ship:sendUpdateToZoneCharsInRange()
                xi.pirates.setStatus(ship, xi.pirates.status.FINISHED)
            end
        end,
        [xi.pirates.status.FINISHED] = function (x)
            xi.pirates.despawnMobs(ID)
        end
    }
end
