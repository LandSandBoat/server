-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Mastop
-- !pos -240 0 36 261
-- !additem 6014
-----------------------------------
---@type TMobEntity
local entity = {}

local boomingMobSkillId = 2770  -- ID for the Booming Bombination skill
local reductionIncrement = 2500   -- Increment value for damage reduction per use
local damageCap = -10000          -- Maximum physical damage resistance (-100%)
local initialDamage = 0           -- Initial physical damage resistance (0%)
local auraDuration = 60           -- Duration of the aura effects in seconds
local auraChance = 20             -- 10% chance to apply an aura effect
local boomingCD = 10              -- Cooldown period in seconds for Booming Bombination

local function handleBoomingBombination(mob, target)
    local boomingUsageCount = mob:getLocalVar('boomingUsageCount') or 0
    local reduction = initialDamage - (boomingUsageCount * reductionIncrement)
    reduction = math.max(reduction, damageCap)

    mob:setMod(xi.mod.UDMGPHYS, reduction)
    mob:setMod(xi.mod.UDMGRANGE, reduction)

    boomingUsageCount = boomingUsageCount + 1
    mob:setLocalVar('boomingUsageCount', boomingUsageCount)
    mob:setLocalVar('boomingCooldown', os.time() + boomingCD)
end

local function applyAura(mob)
    local effects = { xi.effect.SILENCE, xi.effect.AMNESIA, xi.effect.POISON }

    for _, effect in ipairs(effects) do
        -- Apply each effect individually without overwriting others
        mob:addStatusEffectEx(effect, effect, 6, 3, auraDuration, effect, 50, xi.auraTarget.ENEMIES, xi.effectFlag.AURA)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ACC, 350)
    mob:setMod(xi.mod.ATTP, 100)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, initialDamage)
    mob:setMod(xi.mod.UDMGRANGE, initialDamage)
    mob:setLocalVar('boomingUsageCount', 0)
    mob:setLocalVar('boomingCooldown', 0)

    mob:addListener('WEAPONSKILL_USE', 'MASTOP_BOOMING_BOMBINATION', function(mobArg, target, weaponSkill, action)
        local weaponSkillID = type(weaponSkill) == 'table' and weaponSkill:getID() or weaponSkill
        local currentTime = os.time()
        local boomingCooldown = mobArg:getLocalVar('boomingCooldown')

        if weaponSkillID == boomingMobSkillId and currentTime >= boomingCooldown then
            handleBoomingBombination(mobArg, target)

            if math.random(100) <= auraChance then
                applyAura(mobArg)
            end
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:setMod(xi.mod.UDMGPHYS, initialDamage)
    mob:setMod(xi.mod.UDMGRANGE, initialDamage)
    mob:setMod(xi.mod.ACC, 0)
    mob:setMod(xi.mod.ATTP, 0)
end

return entity
