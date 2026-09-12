require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Break can not happen during these actions.
local busyActions = set{
    xi.action.category.WEAPONSKILL_FINISH,
    xi.action.category.JOBABILITY_FINISH,
    xi.action.category.RANGED_START,
    xi.action.category.ITEM_USING,
    xi.action.category.MAGIC_CASTING,
    xi.action.category.MOBABILITY_USING,
}

-- Set of job abilities that can break weapons.
local breakingAbilities = set{
    xi.jobAbility.SHIELD_BASH,
    xi.jobAbility.WEAPON_BASH,
    xi.jobAbility.JUMP, -- TODO: Unkown if crit is required.
    xi.jobAbility.HIGH_JUMP,
    xi.jobAbility.SPIRIT_JUMP,
    xi.jobAbility.SOUL_JUMP,
    xi.jobAbility.BOX_STEP,
    xi.jobAbility.STUTTER_STEP,
    xi.jobAbility.FEATHER_STEP,
}

-- TODO: Add an exclusion list of weaponskills based on the mob family.

local function nextRegrow(mob)
    local headRegrowMin = mob:getLocalVar('headRegrowMin')

    if headRegrowMin > 0 then
        mob:setLocalVar('headgrow', GetSystemTime() + math.randomInt(headRegrowMin, mob:getLocalVar('headRegrowMax')))
        mob:setLocalVar('headgrowHPP', 0)
        return
    end

    local hpp        = math.max(mob:getHPP(), 5)
    local regrowTime = 60 + math.floor((hpp - 5) * 900 / 95)

    mob:setLocalVar('headgrow', GetSystemTime() + regrowTime)
    mob:setLocalVar('headgrowHPP', hpp)
end

-- 0 -> 1 = 3 to 2 heads
-- 1 -> 2 = 2 to 1 heads
local function handleBreak(mob)
    local brokenHeads = mob:getAnimationSub()

    if brokenHeads < 2 then
        mob:wait(4000)
        mob:setLocalVar('animationLock', 1)
        mob:timer(1000, function(mobArg)
            mobArg:setAnimationSub(brokenHeads + 1)
            nextRegrow(mobArg)
            mobArg:timer(3000, function(mobArgTwo)
                mobArgTwo:setLocalVar('animationLock', 0)
            end)
        end)
    end
end

local function shouldBreak(mob)
    -- Mob is performing an action, return false.
    if busyActions[mob:getCurrentAction()] then
        return false
    end

    if mob:getLocalVar('animationLock') == 1 then
        return false
    end

    return math.randomInt(1, 100) <= 15 -- Static 15%
end

local function checkRegrowHead(mob)
    local brokenHeads = mob:getAnimationSub()

    if brokenHeads == 0 then
        return
    end

    local headgrow    = mob:getLocalVar('headgrow')
    local headgrowHPP = mob:getLocalVar('headgrowHPP')
    local currentHPP  = mob:getHPP()

    if currentHPP < headgrowHPP then
        headgrow = headgrow - (headgrowHPP - currentHPP) * 10
        mob:setLocalVar('headgrow', headgrow)
        mob:setLocalVar('headgrowHPP', currentHPP)
    end

    if busyActions[mob:getCurrentAction()] then
        return
    end

    if headgrow < GetSystemTime() then
        mob:setAnimationSub(brokenHeads - 1)
        nextRegrow(mob)
        mob:setLocalVar('animationLock', 1)
        mob:wait(4000)
        mob:timer(4000, function(mobArg)
            mobArg:setLocalVar('animationLock', 0)
            mobArg:setTP(3000)
        end)
    end
end

g_mixins.families.hydra = function(hydraMob)
    hydraMob:addListener('CRITICAL_TAKE', 'BREAK_CRITICAL_TAKE', function(target)
        if shouldBreak(target) then
            handleBreak(target)
        end
    end)

    hydraMob:addListener('ABILITY_TAKE', 'BREAK_ABILITY_TAKE', function(user, target, ability)
        if breakingAbilities[ability:getID()] and shouldBreak(target) then
            handleBreak(target)
        end
    end)

    hydraMob:addListener('WEAPONSKILL_TAKE', 'BREAK_WEAPONSKILL_TAKE', function(user, target)
        if shouldBreak(target) then
            handleBreak(target)
        end
    end)

    hydraMob:addListener('ROAM_TICK', 'HYDRA_ROAM_TICK', checkRegrowHead)
    hydraMob:addListener('COMBAT_TICK', 'HYDRA_COMBAT_TICK', checkRegrowHead)
end

return g_mixins.families.hydra
