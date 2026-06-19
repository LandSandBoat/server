-----------------------------------
-- Area: RaKaznar_Inner_Court
--  Mob: Whitenoise Bats
-- ERA Custom NM
-----------------------------------
local entity = {}

-- HP% thresholds at which phase abilities are used
local phaseAbilities =
{
    { hpp = 80, skillId = xi.mobSkill.COLD_BREATH,     varState = 1 },
    { hpp = 55, skillId = xi.mobSkill.HEAT_BREATH,     varState = 2 },
    { hpp = 30, skillId = xi.mobSkill.LEVEL_5_PETRIFY, varState = 3 },
    { hpp = 10, skillId = xi.mobSkill.FULMINATION,     varState = 4 },
}

-- Damage shield rotates every N seconds
local shieldInterval = 30

local shieldMods =
{
    [1] = xi.mod.UDMGPHYS,
    [2] = xi.mod.UDMGRANGE,
    [3] = xi.mod.UDMGMAGIC,
}

-- Clears all three damage-reduction mods to 0
local function clearShieldMods(mob)
    for _, modId in ipairs(shieldMods) do
        mob:setMod(modId, 0)
    end
end

-- Teleport-then-use helper to keep phase logic clean
local function doPhaseAbility(mob, target, skillId)
    local t   = target:getPos()
    local pos = NearLocation(t, 1.5, math.random() * math.pi)
    pos.rot   = target:getRotPos()

    mob:resetEnmity(target)
    mob:teleport(pos, target)
    mob:useMobAbility(skillId)
    mob:resetEnmity(target)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobFight = function(mob, target)
    local hpp        = mob:getHPP()
    local phaseState = mob:getLocalVar('PhaseState')

    -- Reset phase tracker when mob is at full HP
    if hpp == 100 then
        mob:setLocalVar('PhaseState', 0)
        return
    end

    -- Phase ability triggers
    for _, phase in ipairs(phaseAbilities) do
        if hpp < phase.hpp and phaseState == phase.varState - 1 then
            mob:setLocalVar('PhaseState', phase.varState)
            doPhaseAbility(mob, target, phase.skillId)
            return
        end
    end

    -- Rotating damage immunity shield (switches every shieldInterval seconds)
    local changeTime = mob:getLocalVar('ChangeTime')

    if mob:getBattleTime() - changeTime > shieldInterval then
        mob:setLocalVar('ChangeTime', mob:getBattleTime())

        local shield = math.random(#shieldMods)

        clearShieldMods(mob)
        mob:setMod(shieldMods[shield], -10000)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 65, power = 10 })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
