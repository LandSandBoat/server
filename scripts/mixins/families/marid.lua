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

-- Keyed off of level difference in tenths of a percent. 5 = 0.5%
-- TODO: At some threshold, the break chance increases to 33%. We do not know that threshold.
local breakChancePerMille =
{
    [-11] =   0,
    [-10] =   5,
    [-9]  =  10,
    [-8]  =  20,
    [-7]  =  30,
    [-6]  =  40,
    [-5]  =  50,
    [-4]  =  60,
    [-3]  =  70,
    [-2]  =  80,
    [-1]  =  90,
    [0]   = 100,
    [1]   = 120,
    [2]   = 140,
    [3]   = 140,
    [4]   = 140,
    [5]   = 140,
    [6]   = 140,
    [7]   = 140,
    [8]   = 140,
    [9]   = 140,
    [10]  = 180,
    [11]  = 180,
    [12]  = 180,
    [13]  = 250,
}

-- Relies on animation sub being set to on spawn
local handleBreak = function(mob)
    local brokenTusks = mob:getAnimationSub()

    if brokenTusks < 2 then
        mob:setAnimationSub(brokenTusks + 1)
    end
end

local function shouldBreak(mob, attacker)
    -- Mob busy and weapon can not be broken
    if busyActions[mob:getCurrentAction()] then
        return false
    end

    local dLvl = utils.clamp(attacker:getMainLvl() - mob:getMainLvl(), -11, 13)

    return math.randomInt(1, 1000) <= breakChancePerMille[dLvl]
end

g_mixins.families.marid = function(maridMob)
    maridMob:addListener('CRITICAL_TAKE', 'BREAK_CRITICAL_TAKE', function(target, attacker)
        if shouldBreak(target, attacker) then
            handleBreak(target)
        end
    end)

    maridMob:addListener('ABILITY_TAKE', 'BREAK_ABILITY_TAKE', function(user, target, ability)
        if breakingAbilities[ability:getID()] and shouldBreak(target, user) then
            handleBreak(target)
        end
    end)

    maridMob:addListener('WEAPONSKILL_TAKE', 'BREAK_WEAPONSKILL_TAKE', function(user, target)
        if shouldBreak(target, user) then
            handleBreak(target)
        end
    end)

    -- Add Tusks to loot pool depending on number of broken tusks.
    maridMob:addListener('ITEM_DROPS', 'MARID_ITEM_DROPS', function(mob, loot)
        local brokenTusks = mob:getAnimationSub()

        for _ = 1, brokenTusks do
            loot:addItem(xi.item.MARID_TUSK, xi.drop_rate.GUARANTEED)
        end
    end)
end

return g_mixins.families.marid
