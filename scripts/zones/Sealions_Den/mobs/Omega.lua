-----------------------------------
-- Area: Sealions Den
--  Mob: Omega
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)
end

entity.onMobSpawn = function(mob)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:setMod(xi.mod.REGAIN, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setMod(xi.mod.DEF, 270)
    mob:setMod(xi.mod.MDEF, 10)
    mob:setDelay(220)
    mob:setLocalVar('phase', 1) -- Set to 1 for readability
end

entity.onMobEngage = function(mob, target)
    mob:useMobAbility(xi.mobSkill.ION_EFFLUX)
end

entity.onMobFight = function(mob, target)
    local hpPercent = mob:getHPP()
    local phase     = 1

    if hpPercent < 25 then
        phase = 3
    elseif hpPercent < 60 then
        phase = 2
    end

    if mob:getLocalVar('phase') == phase then
        return
    end

    mob:setLocalVar('phase', phase)

    -- Delay increases as HP gets lower.
    if phase == 3 then
        mob:setDelay(110)
    elseif phase == 2 then
        mob:setDelay(160)
    else
        mob:setDelay(220)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local hpPercent = mob:getHPP()
    local skills    = {}

    if hpPercent >= 60 then
        skills =
        {
            xi.mobSkill.ION_EFFLUX,
            xi.mobSkill.HYPER_PULSE,
            xi.mobSkill.TARGET_ANALYSIS,
        }
    elseif hpPercent >= 25 then
        skills =
        {
            xi.mobSkill.HYPER_PULSE,
            xi.mobSkill.GUIDED_MISSILE,
            xi.mobSkill.TARGET_ANALYSIS,
        }
    elseif hpPercent >= 10 then
        skills =
        {
            xi.mobSkill.PILE_PITCH,
            xi.mobSkill.HYPER_PULSE,
        }
    else
        skills =
        {
            xi.mobSkill.PILE_PITCH,
            xi.mobSkill.DISCHARGER,
        }
    end

    -- Rear Lasers available when target is behind Omega
    if hpPercent >= 25 and target:isBehind(mob) then
        table.insert(skills, xi.mobSkill.REAR_LASERS)
    end

    return skills[math.randomInt(1, #skills)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

return entity
