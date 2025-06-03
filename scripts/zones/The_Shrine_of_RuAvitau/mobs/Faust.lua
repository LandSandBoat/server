-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-- TODO: Faust should WS ~3 times in a row each time.
-----------------------------------
---@type TMobEntity
local entity = {}

local east = 0
local north = 192
local home = { 740, -0.463, -99 }

local setFaustNextTurnTime = function(faust)
    faust:setLocalVar('NextTurnTime', os.time() + math.random(45, 75))
end

local faustNextTurnTime = function(faust)
    return faust:getLocalVar('NextTurnTime')
end

local setFaustFacingDirection = function(faust, direction)
    faust:setLocalVar('FacingDirection', direction)
    faust:setRotation(direction)
end

local faustFacingDirection = function(faust)
    return faust:getLocalVar('FacingDirection')
end

local handleFaustFacingDirectionMechanics = function(faust)
    if os.time() > faustNextTurnTime(faust) then
        if faustFacingDirection(faust) == north then
            setFaustFacingDirection(faust, east)
        else
            setFaustFacingDirection(faust, north)
        end

        setFaustNextTurnTime(faust)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 17986)
    mob:setMobMod(xi.mobMod.GIL_MAX, 27482)
end

entity.onMobSpawn = function(mob)
    setFaustNextTurnTime(mob)
    setFaustFacingDirection(mob, north) -- start him facing north (though the database technically already does this, we need to absorb the local dir)
end

entity.onMobRoam = function(mob)
    if mob:atPoint(home) then
        handleFaustFacingDirectionMechanics(mob)
    else
        mob:pathThrough(home, xi.pathflag.NONE)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs
end

return entity
