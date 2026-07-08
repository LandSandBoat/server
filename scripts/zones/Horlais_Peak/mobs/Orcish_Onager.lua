-----------------------------------
-- Area: Horlais Peak
--  Mob: Orcish Onager
-----------------------------------
---@type TMobEntity
local entity = {}

-- Function to calculate a valid flee position.
-- Uses the mobs position and the targets position to calculate a random angle away from the target, then returns a valid position 9 yalms away.
local function getFleePosition(mob, target)
    local mobPosition         = mob:getPos()
    local targetPosition      = target:getPos()
    local awayFromTargetAngle = utils.getWorldAngle(targetPosition, mobPosition) -- Angle directly away from the target in radians
    local angleOffset         = math.randomFloat(0, 1) * math.pi - math.pi / 2 -- Random angle between -90 and +90 degrees in radians
    local randomizedAngle     = awayFromTargetAngle + angleOffset -- Final angle to flee in, randomized within a 180 degree cone away from the target
    local fleeAngle           = randomizedAngle - utils.rotationToAngle(targetPosition.rot)

    return GetFurthestValidPosition(target, 9, fleeAngle)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)

    mob:addListener('MAGIC_STATE_EXIT', 'ORCISH_ONAGER_BIND', function(mobArg, spell)
        if spell:getID() == xi.magic.spell.BINDGA then
            local target = mobArg:getTarget()

            if not target then
                return
            end

            local fleePosition = getFleePosition(mobArg, target)

            if not fleePosition then
                return
            end

            mobArg:pathTo(fleePosition.x, fleePosition.y, fleePosition.z, bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(120)
    mob:setBehavior(xi.behavior.STANDBACK)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('nextBindTime', currentTime + math.randomInt(15, 25))
    mob:setLocalVar('nextSkillTime', currentTime + math.randomInt(8, 10))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime  = GetSystemTime()
    local nextBindTime = mob:getLocalVar('nextBindTime')

    if currentTime >= nextBindTime then
        mob:castSpell(xi.magic.spell.BINDGA, target)
        mob:setLocalVar('nextBindTime', currentTime + math.randomInt(15, 25))
        return
    end

    if currentTime >= mob:getLocalVar('nextSkillTime') then
        mob:useMobAbility()
        mob:setLocalVar('nextSkillTime', currentTime + math.randomInt(8, 10))
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.BURST,
        xi.mobSkill.FLAME_ARROW,
        xi.mobSkill.FIREBOMB,
        xi.mobSkill.BLASTBOMB,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
