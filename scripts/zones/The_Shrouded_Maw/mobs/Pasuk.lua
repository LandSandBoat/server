-----------------------------------
-- Area: The Shrouded Maw
-- ENM Test Your Mite
-- Mob: Pasuk
-----------------------------------

---@type TMobEntity
local entity = {}

local function vanish(mob, target)
    mob:setLocalVar('warping', 1)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:entityAnimationPacket(xi.animationString.STATUS_DISAPPEAR)
    mob:setBaseSpeed(0)
    mob:timer(1000, function(mobArg)
        local warpPosition = utils.getNearPosition(target:getPos(), math.randomInt(2, 4), math.randomFloat(0, 2 * math.pi))
        mobArg:setPos(warpPosition.x, warpPosition.y, warpPosition.z)
        mobArg:lookAt(target:getPos())
    end)
end

local function appear(mob)
    mob:setLocalVar('warping', 0)
    mob:entityAnimationPacket(xi.animationString.STATUS_VISIBLE)
    mob:setStatus(xi.status.UPDATE)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setBaseSpeed(45)
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setBaseSpeed(45)
    mob:setLocalVar('warping', 0)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if mob:getLocalVar('warping') == 1 then
        return
    end

    -- If Pasuk loses LoS of the target, they will vanish and warp to their targets position.
    if not mob:canSee(target) then
        vanish(mob, target)
        mob:timer(1500, function(mobArg)
            appear(mobArg)
        end)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skills =
    {
        xi.mobSkill.SPINNING_TOP_1,
        xi.mobSkill.DOUBLE_CLAW_1,
        xi.mobSkill.VISCID_SECRETION
    }

    return skills[math.randomInt(1, #skills)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 100, power = math.randomInt(70, 250) }) -- TODO: Might be based off of dINT, needs more captures.
end

return entity
