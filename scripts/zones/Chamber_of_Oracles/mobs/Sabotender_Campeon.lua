-----------------------------------
-- Area : Chamber of Oracles
-- Mob  : Sabotender Campeon
-- KSNM : Cactuar Suave
-----------------------------------
---@type TMobEntity
local entity = {}

-- Centers for the three arenas in this battlefield
local arenaCenters =
{
    [1] = { x = 0, y =  100, z = -240 },
    [2] = { x = 0, y =    0, z =    2 },
    [3] = { x = 0, y = -100, z =  240 },
}

local function generatePath(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Get center coordinates.
    local center = arenaCenters[battlefield:getArea()]

    -- Randomly choose a side to path towards, either right or left.
    local positionX = center.x + 8.50 * (1 - 2 * math.random(0, 1))
    local positionY = center.y
    local positionZ = center.z + 6.25

    local pathPoints = {}
    local pointCount = math.random(10, 15)

    -- Populate 1st point with the chosen corner
    pathPoints[1] = { x = positionX, y = positionY, z = positionZ }

    -- Generate 10 to 15 random points with slight variation around the corner
    for i = 2, pointCount do
        local variationX = math.random(-300, 300) / 100
        local variationZ = math.random(-300, 300) / 100
        pathPoints[i]    = { x = positionX + variationX, y = positionY, z = positionZ + variationZ }
    end

    -- Begin running along the path
    local pathFlags = bit.bor(xi.path.flag.COORDS, xi.path.flag.RUN, xi.path.flag.SCRIPT)
    mob:pathThrough(pathPoints, pathFlags)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setMagicCastingEnabled(false) -- Only casts upon returning from a run!
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 120)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobEngage = function(mob)
    mob:setLocalVar('phase', 0)
    mob:setLocalVar('nextPathTime', GetSystemTime() + math.random(5, 10))
end

entity.onMobFight = function(mob, target)
    switch (mob:getLocalVar('phase')): caseof
    {
        [0] = function()
            if GetSystemTime() >= mob:getLocalVar('nextPathTime') then
                generatePath(mob)
                mob:setLocalVar('phase', 1)
            end
        end,

        [1] = function()
            if not mob:isFollowingPath() then
                mob:setLocalVar('phase', 2)
                mob:setLocalVar('nextPathTime', GetSystemTime() + math.random(20, 45))
            end
        end,

        [2] = function()
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            if mob:checkDistance(currentTarget) > 7 then
                return
            end

            local baseId = mob:getID()
            for i = 0, 2 do
                local ally = GetMobByID(baseId + i)

                if
                    ally and
                    ally:isAlive() and
                    ally:getHPP() <= 50
                then
                    mob:castSpell(xi.magic.spell.CURE_V, ally)
                    mob:setLocalVar('phase', 0)
                    return
                end
            end

            mob:useMobAbility(xi.mobSkill.THOUSAND_NEEDLES_1)
            mob:setLocalVar('phase', 0)
        end,
    }
end

return entity
