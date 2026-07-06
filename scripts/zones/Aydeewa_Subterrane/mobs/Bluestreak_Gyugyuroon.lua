-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Bluestreak Gyugyuroon
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

local function getFleePosition(mob, target)
    local mobPosition         = mob:getPos()
    local targetPosition      = target:getPos()
    local awayFromTargetAngle = utils.getWorldAngle(targetPosition, mobPosition) -- Angle directly away from the target

    -- Pass 1: preferred direction (away from target), wide cone, full distance
    for _ = 1, 4 do
        local angle = awayFromTargetAngle + (math.randomFloat(0, 1) * (math.pi / 2) - (math.pi / 4))
        local pos   = GetFurthestValidPosition(mob, math.randomInt(11, 50), angle)
        if pos then
            return pos
        end
    end

    -- Pass 2: any random direction, medium distance
    for _ = 1, 8 do
        local pos = GetFurthestValidPosition(mob, math.randomInt(8, 25), math.randomFloat(0, 1) * 2 * math.pi)
        if pos then
            return pos
        end
    end

    -- Pass 3: cornered escape - any direction, tiny step just to unstick
    for _ = 1, 12 do
        local pos = GetFurthestValidPosition(mob, math.randomInt(2, 8), math.randomFloat(0, 1) * 2 * math.pi)
        if pos then
            return pos
        end
    end

    return nil
end

entity.spawnPoints =
{
    { x = -219.199, y =  13.483, z = -340.343 }
}

entity.phList =
{
    [ID.mob.BLUESTREAK_GYUGYUROON - 215] = ID.mob.BLUESTREAK_GYUGYUROON, -- -221.7 13.762 -346.83
    [ID.mob.BLUESTREAK_GYUGYUROON - 214] = ID.mob.BLUESTREAK_GYUGYUROON, -- -219 14.003 -364.83
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, -1) -- To simulate retail ranged attack timing
end

entity.onMobSpawn = function(mob)
    mob:setBehavior(xi.behavior.STANDBACK)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 11) -- 11 Yalms
    mob:setAutoAttackEnabled(false)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    local mobPos      = mob:getPos()
    mob:setLocalVar('nextRunTime', currentTime + math.randomInt(5, 8))
    mob:setLocalVar('lastMoveTime', currentTime)
    mob:setLocalVar('lastPosX', math.floor(mobPos.x * 10))
    mob:setLocalVar('lastPosZ', math.floor(mobPos.z * 10))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) or not target then
        return
    end

    local currentTime  = GetSystemTime()
    local mobPos       = mob:getPos()
    local lastPosX     = mob:getLocalVar('lastPosX')
    local lastPosZ     = mob:getLocalVar('lastPosZ')
    local lastMoveTime = mob:getLocalVar('lastMoveTime')
    local curPosX      = math.floor(mobPos.x * 10)
    local curPosZ      = math.floor(mobPos.z * 10)

    -- Stuck detection: refresh move timestamp whenever the mob's tenth-yalm position changes
    if curPosX ~= lastPosX or curPosZ ~= lastPosZ then
        mob:setLocalVar('lastPosX', curPosX)
        mob:setLocalVar('lastPosZ', curPosZ)
        mob:setLocalVar('lastMoveTime', currentTime)
    end

    local isStuck = (currentTime - lastMoveTime) >= 3

    -- Let the current path play out unless we've been frozen too long
    if mob:isFollowingPath() and not isStuck then
        return
    end

    if isStuck then
        mob:clearPath()
    end

    if not mob:isRangedAttackEnabled() then
        mob:setRangedAttackEnabled(true)
    end

    local nextRunTime = mob:getLocalVar('nextRunTime')
    local tooClose    = mob:checkDistance(target) <= 11

    if currentTime >= nextRunTime or tooClose or isStuck then
        local fleePosition = getFleePosition(mob, target)

        if fleePosition then
            mob:pathTo(fleePosition.x, fleePosition.y, fleePosition.z, bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
            mob:setRangedAttackEnabled(false)
            mob:setLocalVar('nextRunTime', currentTime + math.randomInt(10, 20))
            mob:setLocalVar('lastMoveTime', currentTime)
        end
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    if skillId == xi.mobSkill.RANGED_ATTACK_1 then
        return 0
    end

    local skillList =
    {
        xi.mobSkill.KIBOSH,
        xi.mobSkill.CUTPURSE,
        xi.mobSkill.SANDSPRAY,
        xi.mobSkill.FAZE
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 464)
end

return entity
