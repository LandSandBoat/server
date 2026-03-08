-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Mastop
-- !pos -236 0 40 261
-- !additem 6014
-----------------------------------
---@type TMobEntity
local entity = {}

local damageStages =
{
    0,
    -2500,
    -5000,
    -7500,
    -9900
}

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
    local dmgTypes =
    {
        { key = 'physDmg',   mod = xi.mod.UDMGPHYS  },
        { key = 'magDmg',    mod = xi.mod.UDMGMAGIC },
        { key = 'rangedDmg', mod = xi.mod.UDMGRANGE }
    }

    local highestIndex = 0
    local highestDmg   = 0

    for i, data in ipairs(dmgTypes) do
        local dmg = mob:getLocalVar(data.key)
        if dmg > highestDmg then
            highestDmg = dmg
            highestIndex = i
        end
    end

    if highestIndex == 0 then
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
    local newResist     = getNextStage(currentResist, true) -- Move down (increase reduction)
    mob:setMod(newHighestMod, newResist)

    -- Store the new highest before resetting tracking
    mob:setLocalVar('highestDmgType', highestIndex)

    -- Reset all damage tracking
    for _, data in ipairs(dmgTypes) do
        mob:setLocalVar(data.key, 0)
    end
end

local function handleBoomingBombination(mob)
    mob:setLocalVar('boomingCooldown', GetSystemTime() + 10)

    if math.random(1, 100) <= 20 then
        for _, effect in ipairs({ xi.effect.SILENCE, xi.effect.AMNESIA, xi.effect.POISON }) do
            mob:addStatusEffect(effect, { power = 6, duration = 60, origin = mob, tick = 3, subType = effect, subPower = 50, tier = xi.auraTarget.ENEMIES, flag = xi.effectFlag.AURA })
        end
    end
end

entity.onMobInitialize = function(mob)
    mob:addListener('WEAPONSKILL_USE', 'MASTOP_WEAPONSKILL_RESET', function(mobArg, target, skill, tp, action, damage)
        -- Adjust resistance before resetting damage tracking
        if
            skill:getID() == xi.mobSkill.BOOMING_BOMBINATION and
            GetSystemTime() >= mobArg:getLocalVar('boomingCooldown')
        then
            adjustResistance(mobArg)
            handleBoomingBombination(mobArg)
        end

        -- Reset damage tracking
        mobArg:setLocalVar('physDmg', 0)
        mobArg:setLocalVar('magDmg', 0)
        mobArg:setLocalVar('rangedDmg', 0)
        mobArg:setLocalVar('highestDmgType', 0)
    end)

    mob:addListener('TAKE_DAMAGE', 'MASTOP_DAMAGE_TRACKING', function(mobArg, damage, attacker, attackType, damageType)
        local dmgVars =
        {
            [1] = 'physDmg',
            [2] = 'magDmg',
            [3] = 'rangedDmg'
        }
        local dmgKey = dmgVars[attackType]
        if dmgKey then
            mob:setLocalVar(dmgKey, mob:getLocalVar(dmgKey) + damage)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.ACC, 0)
    mob:setMod(xi.mod.ATTP, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)

    mob:setLocalVar('boomingCooldown', 0)
    mob:setLocalVar('physDmg', 0)
    mob:setLocalVar('magDmg', 0)
    mob:setLocalVar('rangedDmg', 0)
    mob:setLocalVar('highestDmgType', 0)
end

return entity
