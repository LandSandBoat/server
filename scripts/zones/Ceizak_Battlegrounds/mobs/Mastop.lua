-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Mastop
-- !pos -236 0 40 261
-- !additem 6014
-----------------------------------
---@type TMobEntity
local entity = {}

local boomingCD = 10
local auraDuration = 60
local auraChance = 20
local damageStages = { 0, -2500, -5000, -7500, -9900 } -- Predefined resistance stages

local function applyAura(mob)
    for _, effect in ipairs({ xi.effect.SILENCE, xi.effect.AMNESIA, xi.effect.POISON }) do
        mob:addStatusEffectEx(effect, effect, 6, 3, auraDuration, effect, 50, xi.auraTarget.ENEMIES, xi.effectFlag.AURA)
    end
end

local function trackDamage(mob, damage, attackType)
    local dmgVars = { [1] = 'physDmg', [2] = 'magDmg', [3] = 'rangedDmg' }
    local dmgKey = dmgVars[attackType]
    if dmgKey then
        mob:setLocalVar(dmgKey, mob:getLocalVar(dmgKey) + damage)
    end
end

local function getNextStage(currentResist, isIncreasing)
    for i, v in ipairs(damageStages) do
        if v == currentResist then
            if isIncreasing and i < #damageStages then
                return damageStages[i + 1] -- Move to next reduction stage
            elseif not isIncreasing and i > 1 then
                return math.min(damageStages[i - 1], 0) -- Recover, but never exceed 0
            end
        end
    end

    return currentResist -- Stay the same if already at the limit
end

local function adjustResistance(mob)
    local dmgTypes = {
        { key = 'physDmg', mod = xi.mod.UDMGPHYS },
        { key = 'magDmg', mod = xi.mod.UDMGMAGIC },
        { key = 'rangedDmg', mod = xi.mod.UDMGRANGE }
    }

    local highestIndex, highestDmg = nil, 0
    for i, data in ipairs(dmgTypes) do
        local dmg = mob:getLocalVar(data.key)
        if dmg > highestDmg then
            highestDmg = dmg
            highestIndex = i
        end
    end

    if not highestIndex then
        return
    end

    local newHighestMod = dmgTypes[highestIndex].mod

    -- Recover resistance for all other damage types
    for i, data in ipairs(dmgTypes) do
        if i ~= highestIndex then
            local currentResist = mob:getMod(data.mod)
            local newResist = getNextStage(currentResist, false) -- Recover resistance
            mob:setMod(data.mod, newResist)
        end
    end

    -- Reduce the new highest damage type resistance
    local currentResist = mob:getMod(newHighestMod)
    local newResist = getNextStage(currentResist, true) -- Move down (increase reduction)
    mob:setMod(newHighestMod, newResist)

    -- Store the new highest before resetting tracking
    mob:setLocalVar('highestDmgType', highestIndex)

    -- Reset all damage tracking
    for _, data in ipairs(dmgTypes) do
        mob:setLocalVar(data.key, 0)
    end
end

local function handleBoomingBombination(mob)
    adjustResistance(mob) -- Adjust resistances first
    mob:setLocalVar('boomingCooldown', os.time() + boomingCD)

    if math.random(100) <= auraChance then
        applyAura(mob)
    end

    -- Delay damage tracking reset by 2 seconds
    mob:timer(2000, function(mobArg)
        for _, key in ipairs({ 'physDmg', 'magDmg', 'rangedDmg' }) do
            mobArg:setLocalVar(key, 0)
        end

        mobArg:setLocalVar('highestDmgType', 0)
    end)
end

entity.onMobSpawn = function(mob)
    for _, var in ipairs({ 'boomingCooldown', 'physDmg', 'magDmg', 'rangedDmg', 'highestDmgType' }) do
        mob:setLocalVar(var, 0)
    end

    mob:addListener('WEAPONSKILL_USE', 'MASTOP_WEAPONSKILL_RESET', function(mobArg, target, weaponSkill, action)
        local weaponSkillID = type(weaponSkill) == 'table' and weaponSkill.getID and weaponSkill:getID() or weaponSkill

        -- Adjust resistance before resetting damage tracking
        if
            weaponSkillID == xi.mobSkill.BOOMING_BOMBINATION and
            os.time() >= mobArg:getLocalVar('boomingCooldown')
        then
            adjustResistance(mobArg)
            handleBoomingBombination(mobArg)
        end

        -- Reset damage tracking
        for _, key in ipairs({ 'physDmg', 'magDmg', 'rangedDmg' }) do
            mobArg:setLocalVar(key, 0)
        end

        mobArg:setLocalVar('highestDmgType', 0)
    end)

    mob:addListener('TAKE_DAMAGE', 'MASTOP_DAMAGE_TRACKING', function(mobArg, damage, attacker, attackType, damageType)
        trackDamage(mobArg, damage, attackType)
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    for _, mod in ipairs({ xi.mod.ACC, xi.mod.ATTP, xi.mod.UDMGPHYS, xi.mod.UDMGMAGIC, xi.mod.UDMGRANGE }) do
        mob:setMod(mod, 0)
    end
end

return entity
