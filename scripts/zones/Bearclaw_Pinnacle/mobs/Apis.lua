-----------------------------------
-- Area: Bearclaw Pinnacle
--  Mob: Apis
--  ENM: Holy Cow
-----------------------------------
---@type TMobEntity
local entity = {}

local colorPhaseData =
{
    [1] = { uDmgRange = -10000, uDmgMagic = -10000, uDmgPhys = -10000, uDmgBreath = -10000, baseDamageMultiplier = 100, delay = 260, doubleAttack =  0, injectedAction = 433 }, -- Immune to damage.
    [2] = { uDmgRange =      0, uDmgMagic =      0, uDmgPhys =      0, uDmgBreath =      0, baseDamageMultiplier = 150, delay = 260, doubleAttack =  0, injectedAction = 438 }, -- Neutral phase.
    [3] = { uDmgRange =   5000, uDmgMagic =   5000, uDmgPhys =   5000, uDmgBreath =   5000, baseDamageMultiplier = 400, delay = 200, doubleAttack = 25, injectedAction = 432 }, -- High attack, 50% increased damage from all sources.
    [4] = { uDmgRange =  -7500, uDmgMagic =  10000, uDmgPhys =  -7500, uDmgBreath =  10000, baseDamageMultiplier = 200, delay = 200, doubleAttack = 25, injectedAction = 439 }, -- High defense, double magic damage.
}

entity.onMobSpawn = function(mob)
    local colorPhase = colorPhaseData[1]

    -- Starts immune to all damage.
    mob:setMod(xi.mod.UDMGRANGE, colorPhase.uDmgRange)
    mob:setMod(xi.mod.UDMGMAGIC, colorPhase.uDmgMagic)
    mob:setMod(xi.mod.UDMGPHYS, colorPhase.uDmgPhys)
    mob:setMod(xi.mod.UDMGBREATH, colorPhase.uDmgBreath)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, colorPhase.baseDamageMultiplier)
    mob:setMod(xi.mod.DOUBLE_ATTACK, colorPhase.doubleAttack)
    mob:setDelay(colorPhase.delay)
    mob:setMod(xi.mod.ATT, 600)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 35)
    mob:setLocalVar('colorChangeTime', 0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('colorChangeTime', GetSystemTime() + 60)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local currentTime = GetSystemTime()
    local colorChangeTime = mob:getLocalVar('colorChangeTime')

    if currentTime < colorChangeTime then
        return
    end

    local nextPhase = math.randomInt(1, #colorPhaseData)
    local colorPhase = colorPhaseData[nextPhase]

    mob:setMod(xi.mod.UDMGRANGE, colorPhase.uDmgRange)
    mob:setMod(xi.mod.UDMGMAGIC, colorPhase.uDmgMagic)
    mob:setMod(xi.mod.UDMGPHYS, colorPhase.uDmgPhys)
    mob:setMod(xi.mod.UDMGBREATH, colorPhase.uDmgBreath)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, colorPhase.baseDamageMultiplier)
    mob:setMod(xi.mod.DOUBLE_ATTACK, colorPhase.doubleAttack)
    mob:setDelay(colorPhase.delay)
    mob:injectActionPacket(mob:getID(), 11, colorPhase.injectedAction, 0, 0x18, 0, 0, 0)
    mob:setLocalVar('colorChangeTime', currentTime + math.randomInt(60, 90))
end

return entity
