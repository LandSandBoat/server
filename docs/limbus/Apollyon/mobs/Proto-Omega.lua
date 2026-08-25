-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega
-----------------------------------
---@type TMobEntity
local entity = {}

local quadrupedForm = function(mob)
    mob:setLocalVar('phase', 1)
    mob:setLocalVar('phaseChangeTime', GetSystemTime())
    mob:setAnimationSub(1)
    mob:setDelay(180)
    mob:setMod(xi.mod.ATTP, 0)
    mob:setMod(xi.mod.UDMGPHYS, -9000)
    mob:setMod(xi.mod.UDMGRANGE, -9000)
    mob:setMod(xi.mod.UDMGMAGIC, -1000)
end

local bipedForm = function(mob)
    mob:setLocalVar('phase', 2)
    mob:setLocalVar('phaseChangeTime', GetSystemTime())
    mob:setAnimationSub(2)
    mob:setDelay(240)
    mob:setMod(xi.mod.ATTP, 200)
    mob:setMod(xi.mod.UDMGPHYS, -1000)
    mob:setMod(xi.mod.UDMGRANGE, -1000)
    mob:setMod(xi.mod.UDMGMAGIC, -9000)
end

local finalForm = function(mob)
    mob:setLocalVar('phase', 3)
    mob:setLocalVar('phaseChangeTime', GetSystemTime())
    mob:setAnimationSub(2)
    mob:setDelay(240)
    mob:setMod(xi.mod.ATTP, 250)
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
    mob:setMod(xi.mod.REGAIN, 50)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 30)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
    mob:setMod(xi.mod.COUNTER, 10)
    mob:setMod(xi.mod.REGAIN, 30)
    mob:setMod(xi.mod.REGEN, 25)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
    mob:setBaseSpeed(60)
    quadrupedForm(mob)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('phaseChangeTime', currentTime)
    mob:setLocalVar('gunpodTime', currentTime + math.randomInt(105, 150))
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime     = GetSystemTime()
    local phase           = mob:getLocalVar('phase')
    local phaseChangeTime = mob:getLocalVar('phaseChangeTime')

    -- Once Proto-Omega reaches 25% HP, it enters its final form and will not change forms again.
    if
        phase ~= 3 and
        mob:getHPP() <= 25
    then
        finalForm(mob)
        return
    end

    -- Swap between forms every 2 minutes.
    if
        phase ~= 3 and
        currentTime >= phaseChangeTime + 120
    then
        if mob:getAnimationSub() == 1 then
            bipedForm(mob)
        else
            quadrupedForm(mob)
        end

        -- AnimationSub() change timeout.
        mob:wait(4500)
        return
    end

    -- Gunpods can't be summoned in quadruped form, return.
    if phase == 1 then
        return
    end

    -- Not time to summon a gunpod yet, return.
    if currentTime < mob:getLocalVar('gunpodTime') then
        return
    end

    -- Too soon after the last gunpod died, return.
    if currentTime < mob:getLocalVar('podDeathTime') + 90 then
        return
    end

    -- Too soon after phase change to summon a gunpod, return.
    if currentTime < phaseChangeTime + 10 then
        return
    end

    local gunpod = GetMobByID(mob:getID() + 1)

    if not gunpod then
        return
    end

    -- Gunpod is spawned, return.
    if gunpod:isSpawned() then
        return
    end

    mob:setLocalVar('gunpodTime', currentTime + math.randomInt(180, 350))
    mob:useMobAbility(xi.mobSkill.POD_EJECTION)
end

local skillLists =
{
    [1] =
    {
        xi.mobSkill.PILE_PITCH_2,
        xi.mobSkill.GUIDED_MISSILE_2,
        xi.mobSkill.HYPER_PULSE_3,
        xi.mobSkill.TARGET_ANALYSIS_2,
        xi.mobSkill.ION_EFFLUX_2,
    },
    [2] =
    {
        xi.mobSkill.GUIDED_MISSILE_II,
        xi.mobSkill.FLOODLIGHT,
        xi.mobSkill.HYPER_PULSE_2,
        xi.mobSkill.STUN_CANNON,
    },
    [3] =
    {
        xi.mobSkill.COLOSSAL_BLOW,
        xi.mobSkill.LASER_SHOWER,
    },
}

entity.onMobMobskillChoose = function(mob, target, skillId)
    local phase     = mob:getLocalVar('phase')
    local skillList = { unpack(skillLists[phase] or {}) }

    if #skillList == 0 then
        return 0
    end

    if
        phase == 1 and
        target:isBehind(mob)
    then
        table.insert(skillList, xi.mobSkill.REAR_LASERS_2)
    end

    return skillList[math.randomInt(1, #skillList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 10,
        effectId = xi.effect.STUN,
        duration = math.randomInt(8, 10),
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.APOLLYON_RAVAGER)
    end

    if optParams.isKiller or optParams.noKiller then
        local gunpod = GetMobByID(mob:getID() + 1)

        if gunpod and gunpod:isSpawned() then
            DespawnMob(gunpod:getID())
        end
    end
end

return entity
