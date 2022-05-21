-----------------------------------
-- Area: Sacrarium
--  Mob: Old Professor Mariselle
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
local professorTables = require("scripts/zones/Sacrarium/globals")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/utils")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    for i = 0, 5 do
        if GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):getLocalVar("hasProfessorMariselle") == 1 then
            mob:setLocalVar("spawnLocation", i)
        end
    end
end

entity.onMobFight = function(mob, target)
    local OP_Mariselle = mob:getID()

    if mob:getBattleTime() % 30 < 3 and
       mob:getBattleTime() > 3
    then
        local X = mob:getXPos()
        local Y = mob:getYPos()
        local Z = mob:getZPos()

        for i = OP_Mariselle+1, OP_Mariselle+2 do
            local m = GetMobByID(i)
            if not m:isSpawned() then
                m:spawn()
                m:updateEnmity(target)
                m:setPos(X + 1, Y, Z + 1) -- Set pupil x and z position +1 from Mariselle
                return
            end
        end
    end

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            m:updateEnmity(target)
        end
    end

    local teleTime = mob:getLocalVar("teleTime")
    if mob:getBattleTime() - teleTime > 30 and
       mob:getBattleTime() > 59 and
       mob:actionQueueEmpty()
    then
        local profLocation = mob:getLocalVar("spawnLocation")
        local randomPosition = math.random(1, 9)
        utils.mobTeleport(mob, 2000, professorTables.locations[profLocation][randomPosition])
        mob:setLocalVar("teleTime", mob:getBattleTime())
    end

    -- If players wander too far from professor and his teleport room he deaggros --
    -- This is a safety measure due to the navmesh sucking, if players wanted too far and OPM + Babies are teleporting they will just wander through walls --
    -- This happens to all mobs, but due to the teleport mechanics can sometimes cause issues --
    -- TODO Remove de-aggro when OOB Navmesh issues are fixed

    if mob:checkDistance(mob:getTarget()) > 55 then
        for i = OP_Mariselle, OP_Mariselle+1, OP_Mariselle+2 do
            local m = GetMobByID(i)
                m:disengage()
                m:resetEnmity(target)
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setLocalVar("teleTime", 0)
end

entity.onMobDeath = function(mob, player, isKiller)
    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    local OP_Mariselle = mob:getID()

    for i = OP_Mariselle+1, OP_Mariselle+2 do
        local m = GetMobByID(i)
        if m:isSpawned() then
            DespawnMob(i)
        end
    end

    -- Randomize Old Prof. Mariselle's spawn location
    local nextSpawn = math.random(0,5)
    for i = 0, 5 do
        GetNPCByID(ID.npc.QM_MARISELLE_OFFSET + i):setLocalVar("hasProfessorMariselle", (i == nextSpawn) and 1 or 0)
    end
end

entity.onMobRoam = function(mob)
    local profLocation = mob:getLocalVar("spawnLocation")
    local posPath = { mob:getXPos(), mob:getYPos(), mob:getZPos(), professorTables.returnPoint[profLocation][1], professorTables.returnPoint[profLocation][2], professorTables.returnPoint[profLocation][3] }

    xi.path.patrol(mob, posPath)
end

return entity
