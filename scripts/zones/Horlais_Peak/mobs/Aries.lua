-----------------------------------
-- Area: Horlais Peak
--  Mob: Aries
-- BCNM: Today's Horoscope
-----------------------------------
local ID = zones[xi.zone.HORLAIS_PEAK]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Ninjutsu resists
-- TODO: Song resists

local regenPower     = 100
local skillWeights   =
{
    { id = xi.mobSkill.PETRIBREATH, chance = 40 },
    { id = xi.mobSkill.GREAT_BLEAT, chance = 35 },
    { id = xi.mobSkill.RUMBLE,      chance = 10 },
    { id = xi.mobSkill.RAGE_2,      chance = 10 },
    { id = xi.mobSkill.RAM_CHARGE,  chance = 5  },
}

-----------------------------------
-- Used to block the self-sleep action while taking other actions.
-----------------------------------
local abilityBlocked = function(mob)
    local action = mob:getCurrentAction()

    return
        action == xi.action.category.MOBABILITY_START or
        action == xi.action.category.MOBABILITY_USING or
        action == xi.action.category.MOBABILITY_FINISH or
        action == xi.action.category.MAGIC_START or
        action == xi.action.category.MAGIC_CASTING or
        action == xi.action.category.MAGIC_FINISH
end

-----------------------------------
-- Applies self-sleep and accompanying actions.
-----------------------------------
local applySelfSleep = function(mob)
    if abilityBlocked(mob) then
        mob:setLocalVar('sleepWhenFree', 1)
        return
    end

    mob:setLocalVar('isSelfSleeping', 1)
    mob:setMod(xi.mod.REGEN, regenPower)
    mob:addStatusEffect(xi.effect.SLEEP_I, 255, 3, 30 * 3600)
    mob:messageText(mob, ID.text.FALLS_INTO_A_DEEP_SLEEP)
end

-----------------------------------
-- Handle switching between sleep and awake states.
-- Note: Regen status serves as a just went to sleep or just waking up flag as well.
-- Note: Players can put Aries to sleep and it regens.
-----------------------------------
local handleSleepStates = function(mob, isAsleep)
    local isSelfSleep = mob:getLocalVar('isSelfSleeping') == 1
    local activeRegen = mob:getMod(xi.mod.REGEN)

    -- Sleeping. Make sure regen is applied.
    if isAsleep and activeRegen <= 0 then
        mob:setMod(xi.mod.REGEN, regenPower)
        return
    end

    -- Awake. Make sure regen is removed and do the whoosh if waking from self-sleep.
    if not isAsleep and activeRegen > 0 then
        mob:setMod(xi.mod.REGEN, 0)

        if isSelfSleep then
            mob:useMobAbility(xi.mobSkill.VULTURE_3)    -- This is actually Smite of Rage (404), but that doesn't make the animation.
            mob:setLocalVar('isSelfSleeping', 0)
        end
    end
end

-----------------------------------
-- Sets initial mob-specific immunities and effects.
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

-----------------------------------
-- Initialize local variables for Rumble and Ram Charge chains, etc.
-----------------------------------
entity.onMobEngage = function(mob, target)
    mob:setLocalVar('doubleAbilityCount', 0)
    mob:setLocalVar('doubleAbilityID', 0)
    mob:setLocalVar('proximityTimer', 0)
end

-----------------------------------
-- Primary battle loop.
-----------------------------------
entity.onMobFight = function(mob, target)
    local isAsleep       = mob:getStatusEffect(xi.effect.SLEEP_I)
    local doubleAbility  = mob:getLocalVar('doubleAbilityCount')
    local sleepProximity = 15
    local proximityTimer = 3

    handleSleepStates(mob, isAsleep)

    -- Use Rumble or Ram Charge twice in a row.
    if doubleAbility > 0 and not abilityBlocked(mob) then
        local abilityID = mob:getLocalVar('doubleAbilityID')
        mob:useMobAbility(abilityID)
    end

    -- Use self-sleep after Petribreath.
    if
        not abilityBlocked(mob) and
        not isAsleep and
        mob:getLocalVar('petribreathSelfSleep') == 1
    then
        mob:setLocalVar('petribreathSelfSleep', 0)
        applySelfSleep(mob)
    end

    -- Handle self-sleep when target is 15+ yalms away.
    if target then
        if mob:checkDistance(target) > sleepProximity and not isAsleep then
            local now = GetSystemTime()

            -- Aries doesn't immediately go to sleep when ranged. Start a timer.
            if mob:getLocalVar('proximityTimer') == 0 then
                mob:setLocalVar('proximityTimer', now)
            end

            if now - mob:getLocalVar('proximityTimer') > proximityTimer then
                mob:setLocalVar('proximityTimer', 0)
                applySelfSleep(mob)
            end
        else
            mob:setLocalVar('proximityTimer', 0)
        end
    end

    -- Self-sleep was blocked. Go to sleep when able.
    if mob:getLocalVar('sleepWhenFree') == 1 then
        mob:setLocalVar('sleepWhenFree', 0)
        applySelfSleep(mob)
    end
end

-----------------------------------
-- Favors certain moves over others.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target)
    local abilityRoll    = math.random(1, 100)
    local probabilitySum = 0

    for _, skill in ipairs(skillWeights) do
        probabilitySum = probabilitySum + skill.chance

        if abilityRoll <= probabilitySum then
            return skill.id
        end
    end

    return 0
end

-----------------------------------
-- Handle local variables upon weaponskill use.
-----------------------------------
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local doubleAbilityCount = mob:getLocalVar('doubleAbilityCount')

    -- Put self to sleep after Petribreath.
    if skillID == xi.mobSkill.PETRIBREATH then
        mob:setLocalVar('petribreathSelfSleep', 1)

    -- Rumble and Ram Charge are used twice in quick succession.
    elseif skillID == xi.mobSkill.RUMBLE or skillID == xi.mobSkill.RAM_CHARGE then
        mob:setLocalVar('doubleAbilityCount', doubleAbilityCount + 1)
        mob:setLocalVar('doubleAbilityID', skillID)
    end

    -- If this is the second ability in the Rumble/Ram Charge chain then reset the counter.
    if mob:getLocalVar('doubleAbilityCount') > 1 then
        mob:setLocalVar('doubleAbilityCount', 0)
        mob:setLocalVar('doubleAbilityID', 0)
    end
end

-----------------------------------
-- Handle special mob death actions.
-----------------------------------
entity.onMobDeath = function(mob, player, optParams)
end

return entity
