-----------------------------------
-- Area: RaKaznar_Inner_Court
--  Mob: Draftdance Fluturini
-- ERA Custom NM
-----------------------------------
local entity = {}

local function getPoxhound()
    return GetMobByID(zones[xi.zone.RAKAZNAR_INNER_COURT].mob.POXHOUND)
end

-- HP% thresholds at which phase abilities are used
local phaseAbilities =
{
    { hpp = 75, varState = 1 },
    { hpp = 50, varState = 2 },
    { hpp = 25, varState = 3 },
    { hpp = 5,  varState = 4 },
}

-- Random additional effects applied on hit
local additionalEffectPool =
{
    { effect = xi.effect.PLAGUE,  element = xi.element.WATER,     power = 1, tick = 0, duration = 5 },
    { effect = xi.effect.SLEEP_I, element = xi.element.DARK,      power = 1, tick = 0, duration = 5 },
    { effect = xi.effect.SILENCE, element = xi.element.WIND,      power = 1, tick = 0, duration = 5 },
    { effect = xi.effect.POISON,  element = xi.element.WATER,     power = 4, tick = 3, duration = 5 },
    { effect = xi.effect.STUN,    element = xi.element.THUNDER,   power = 1, tick = 0, duration = 5 },
}

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.GRAVITYRES, 100)
end

entity.onMobFight = function(mob, target)
    local hpp      = mob:getHPP()
    local poxhound = getPoxhound()

    -- Regen behavior depends on whether Poxhound is alive
    if not poxhound:isSpawned() then
        mob:setMod(xi.mod.REGEN, math.floor(mob:getMaxHP() / 200))  -- Poxhound dead: regen 0.5%/tick
        mob:setUnkillable(false)
    else
        if hpp < 47 then
            mob:setMod(xi.mod.REGEN, math.floor(mob:getMaxHP() / 50))   -- Below 47%: regen 2%/tick
        else
            mob:setMod(xi.mod.REGEN, math.floor(mob:getMaxHP() / -100)) -- Above 47%: drain 1%/tick
        end
    end

    -- Heal if below 26% and Poxhound is still alive
    if hpp < 26 and poxhound:isSpawned() then
        mob:addHP(math.floor(mob:getMaxHP() * 0.75))
        mob:setLocalVar('PhaseState', 0)
        return
    end

    -- Below 50%: gain stat boosts and cleanse bind
    if hpp < 50 then
        mob:setMod(xi.mod.SLEEPRES,      100)
        mob:setMod(xi.mod.LULLABYRES,    100)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
        mob:setMod(xi.mod.MDEF,          100)

        if mob:hasStatusEffect(xi.effect.BIND) then
            mob:delStatusEffect(xi.effect.BIND)
            mob:resetEnmity(target)
        end
    end

    -- Arrow shield below 25%
    if hpp < 25 then
        mob:addStatusEffect(xi.effect.ARROW_SHIELD, 1, 0, 99999)
    else
        mob:delStatusEffect(xi.effect.ARROW_SHIELD)
    end

    -- Reset phase tracker at full HP
    if hpp == 100 then
        mob:setLocalVar('PhaseState', 0)
        return
    end

    -- Phase ability triggers
    local phaseState = mob:getLocalVar('PhaseState')
    local t          = target:getPos()
    local pos        = NearLocation(t, 1.5, math.random() * math.pi)
    pos.rot          = target:getRotPos()

    for _, phase in ipairs(phaseAbilities) do
        if hpp < phase.hpp and phaseState == phase.varState - 1 then
            mob:setLocalVar('PhaseState', phase.varState)
            mob:resetEnmity(target)
            mob:delStatusEffect(xi.effect.SLEEP_I)
            mob:delStatusEffect(xi.effect.SLEEP_II)
            mob:delStatusEffect(xi.effect.LULLABY)
            mob:teleport(pos, target)
            mob:useMobAbility(xi.mobSkill.MIJIN_GAKURE_1)
            return
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    getPoxhound():updateEnmity(target)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pick = additionalEffectPool[math.random(#additionalEffectPool)]

    if target:hasStatusEffect(pick.effect) then
        mob:resetEnmity(target)
        return 0, 0, 0
    end

    local resist = applyResistanceAddEffect(mob, target, pick.element, pick.effect)

    if math.random(0, 99) >= 20 or resist <= 0.5 then
        return 0, 0, 0
    end

    target:addStatusEffect(pick.effect, pick.power, pick.tick, math.floor(pick.duration * resist))
    return xi.action.addEffect.NONE, xi.msg.basic.ADD_EFFECT_STATUS, pick.effect
end

entity.onMobDisengage = function(mob)
    mob:setUnkillable(true)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
end

return entity
