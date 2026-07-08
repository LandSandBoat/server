-----------------------------------
-- Area: Monarch Linn
-- Mob : Hotupuku
-- ENM : Bugard in the Clouds
-----------------------------------
local entity = {}

local bugardSkills =
{
    xi.mobSkill.TAIL_ROLL,
    xi.mobSkill.TUSK,
    xi.mobSkill.SCUTUM,
    xi.mobSkill.BONE_CRUNCH,
    xi.mobSkill.AWFUL_EYE,
    xi.mobSkill.HEAVY_BELLOW,
}

local twoHours =
{
    xi.mobSkill.HUNDRED_FISTS_1,
    xi.mobSkill.INVINCIBLE_1,
    xi.mobSkill.MIGHTY_STRIKES_1,
}

local immunityMods =
{
    [1] = xi.mod.UDMGPHYS,
    [2] = xi.mod.UDMGMAGIC,
    [4] = xi.mod.UDMGRANGE,
}

local function getDamageTypeData(attacker, attackType)
    if attackType == xi.attackType.MAGICAL then
        return 'magicDamage', 2
    end

    if attackType == xi.attackType.RANGED then
        return 'rangedDamage', 4
    end

    if attackType == xi.attackType.PHYSICAL then
        -- Some ranged auto-attacks can arrive as PHYSICAL.
        local attackerAction = attacker and attacker:getCurrentAction() or nil
        if
            attackerAction and
            (attackerAction == xi.action.category.RANGED_START or
            attackerAction == xi.action.category.RANGED_FINISH)
        then
            return 'rangedDamage', 4
        end

        return 'meleeDamage', 1
    end

    return nil, 0
end

local function resetTpChain(mob)
    mob:setLocalVar('tpChainCount', 0)
    mob:setLocalVar('tpChainSkill', 0)
    mob:setLocalVar('tpChainPending', 0)
end

local function canUseTwoHour(mob)
    return
        mob:canUseAbilities() and
        not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS) and
        not mob:hasStatusEffect(xi.effect.INVINCIBLE) and
        not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES)
end

local function hasSkill(skillList, skillId)
    for _, listedSkillId in ipairs(skillList) do
        if listedSkillId == skillId then
            return true
        end
    end

    return false
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)

    mob:addListener('TAKE_DAMAGE', 'HOTUPUKU_DAMAGE_TRACKER', function(mobArg, damage, attacker, attackType, damageType)
        local damageKey, immunityMask = getDamageTypeData(attacker, attackType)
        if not damageKey then
            return
        end

        local accumulatedDamage = mobArg:getLocalVar(damageKey) + damage
        mobArg:setLocalVar(damageKey, accumulatedDamage)

        if accumulatedDamage >= 2000 then
            local immunityMod = immunityMods[immunityMask]
            if not immunityMod then
                return
            end

            local currentMask = mob:getLocalVar('immunityMask')
            if bit.band(currentMask, immunityMask) ~= 0 then
                return
            end

            mob:setLocalVar('immunityMask', bit.bor(currentMask, immunityMask))
            mob:setMod(immunityMod, -10000)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('immunityMask', 0)     -- Bitfield for phys/magic/ranged immunities already applied
    mob:setLocalVar('meleeDamage', 0)      -- Total physical damage taken for immunity tracking
    mob:setLocalVar('magicDamage', 0)      -- Total magical damage taken for immunity tracking
    mob:setLocalVar('rangedDamage', 0)     -- Total ranged damage taken for immunity tracking
    mob:setLocalVar('twoHourUsed', 0)      -- Set to 1 once Hotupuku has used a 2 hour ability, preventing further procs until the next one is scheduled
    mob:setLocalVar('nextTwoHourTime', 0)  -- Battle time at which Hotupuku can use a 2 hour ability again, set when a 2 hour is used
    mob:setLocalVar('tpChainCount', 0)     -- Tracks how many skills have been used in the current TP chain, resets after 2. Should be 0 when no chain is active.
    mob:setLocalVar('tpChainSkill', 0)     -- Set to the skill ID of the first skill used in a TP chain, which is the one that will be used for the entire chain
    mob:setLocalVar('tpChainPending', 0)   -- Set to 1 when a skill that can be chained is used, and the chain isn't already pending. When 1, the mob will use the appropriate chain skill on the next MobFight update, and then reset this to 0.
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.DEFP, 0)
    mob:addMod(xi.mod.DEF, 150)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 0)
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance         = 100,
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.EARTH,
        basePower      = math.randomInt(70, 90),
        actorStat      = xi.mod.INT,
    }

    return xi.combat.action.executeAddEffectDamage(mob, target, pTable)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- Handle first 2-hour ability.
    local battleTime = mob:getBattleTime()
    if mob:getLocalVar('twoHourUsed') == 0 then
        if
            mob:getMaxHP() - mob:getHP() >= 4000 and
            canUseTwoHour(mob)
        then
            mob:setLocalVar('twoHourUsed', 1)
            mob:setLocalVar('nextTwoHourTime', battleTime + math.randomInt(90, 210))
            mob:useMobAbility(twoHours[math.randomInt(1, #twoHours)])
            return
        end

    -- Handle subsequent 2-hour abilities.
    else
        if
            battleTime >= mob:getLocalVar('nextTwoHourTime') and
            canUseTwoHour(mob)
        then
            mob:setLocalVar('nextTwoHourTime', battleTime + math.randomInt(90, 210))
            mob:useMobAbility(twoHours[math.randomInt(1, #twoHours)])
            return
        end
    end

    -- Handle TP chain.
    if mob:getLocalVar('tpChainPending') == 1 and mob:canUseAbilities() then
        mob:setLocalVar('tpChainPending', 0)
        mob:useMobAbility(mob:getLocalVar('tpChainSkill'))
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()

    -- Handle 2-hour additional buffs.
    if hasSkill(twoHours, skillId) then
        mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
        mob:setMod(xi.mod.DELAYP, -40)
        mob:setMod(xi.mod.ACC, 150)
        mob:setMod(xi.mod.DOUBLE_ATTACK, 75)

        resetTpChain(mob)
        return
    end

    -- Hanlde TP chain breaking when using non chaining skills.
    if not hasSkill(bugardSkills, skillId) then
        resetTpChain(mob)
        return
    end

    -- TP chain x3 logic.
    local tpChainCount = mob:getLocalVar('tpChainCount')

    if tpChainCount == 0 then
        mob:setLocalVar('tpChainSkill', skillId)
    elseif tpChainCount == 1 then
        mob:setLocalVar('tpChainPending', 1)
        mob:setLocalVar('tpChainCount', tpChainCount + 1)
    else
        resetTpChain(mob)
    end
end

return entity
