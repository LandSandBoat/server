-----------------------------------
-- Area: Horlais Peak
--  Mob: Evil Oscar
-- KSNM30: Contaminated Colliseum
-----------------------------------
local ID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------
---@type TMobEntity
local entity = {}

-- { Phase HP%, First Inhale Delay, Interval Delay }
local breathTimers =
{
    [1] = {  30, 10,  4 },
    [2] = {  40, 12,  6 },
    [3] = {  50, 14,  8 },
    [4] = {  60, 16, 10 },
    [5] = {  70, 18, 12 },
    [6] = {  80, 20, 14 },
    [7] = {  90, 22, 16 },
    [8] = {  99, 24, 18 },
    [9] = { 100, 26, 20 },
}

local function calculatePhase(mob)
    local mobHPP = mob:getHPP()
    for phase = 1, 9 do
        if mobHPP <= breathTimers[phase][1] then
            return phase
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 65)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setLocalVar('inhaleCount', 0)
end

entity.onMobEngage = function(mob, target)
    if mob:getLocalVar('nextInhaleTime') == 0 then
        mob:setLocalVar('nextInhaleTime', GetSystemTime() + 15) -- First inhale is 15 seconds after engaging.
    end
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- If we've inhaled 3 times, use Extremely Bad Breath when the target is in range.
    local inhaleCount = mob:getLocalVar('inhaleCount')
    if
        inhaleCount >= 3 and
        mob:checkDistance(target) <= 10
    then
        mob:useMobAbility(xi.mobSkill.EXTREMELY_BAD_BREATH_1)
        mob:setLocalVar('inhaleCount', 0)
        mob:setLocalVar('nextInhaleTime', GetSystemTime() + breathTimers[calculatePhase(mob)][2])
        return
    end

    -- Inhale: Timer check.
    if GetSystemTime() < mob:getLocalVar('nextInhaleTime') then
        return
    end

    -- Inhale: Message handling.
    local battlefield = mob:getBattlefield()
    if battlefield then
        for _, player in pairs(battlefield:getPlayers()) do
            player:messageSpecial(ID.text.EVIL_OSCAR_BEGINS_FILLING)
        end
    end

    -- Inhale: Timer and count handling.
    mob:setLocalVar('inhaleCount', inhaleCount + 1)
    mob:setLocalVar('nextInhaleTime', GetSystemTime() + breathTimers[calculatePhase(mob)][3])
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.WEIGHT, { chance = 10, power = 75 })
end

return entity
