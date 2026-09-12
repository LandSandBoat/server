--[[
https://ffxiclopedia.fandom.com/wiki/Category:Uragnites
https://www.bg-wiki.com/bg/Category:Uragnite

Uragnite mob can optionally be modified by calling xi.mix.uragnite.config(mob, params) from within onMobSpawn.

params is a table that can contain the following keys:
    inShellSkillList : skill list given to mob when it enters shell (default: 250)
    noShellSkillList : skill list given to mob when it exits shell (default: 251)
    chanceToShell    : percent chance to enter shell when hit by a physical attack (default: 20)
    timeInShellMin   : least time mob can stay in shell, in seconds (default: 30)
    timeInShellMax   : most time mob can stay in shell, in seconds (default: 45)
    inShellRegen     : amount of regen mob gets while in shell (default: 50)

Example:

xi.mix.uragnite.config(mob, {
    chanceToShell = 10,
    timeInShellMin = 45,
    timeInShellMin = 60,
})

--]]
require('scripts/globals/mixins')
-----------------------------------
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.uragnite = xi.mix.uragnite or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- animationSub 4 is out of the shell, 5 is closed
local open   = 4
local closed = 5

-- an idle rest lasts 45 to 70 s; four rests in five close the shell for 18 to 32 s and open it 2 s before the walk
local idleRestMin     = 45
local idleRestMax     = 70
local idleClosedMin   = 18
local idleClosedMax   = 32
local idleCloseChance = 80
local idleOpenBefore  = 2

local function enterShell(mob)
    mob:setAnimationSub(closed)
    mob:setAutoAttackEnabled(false)
    mob:addMod(xi.mod.UDMGPHYS, -7500)
    mob:addMod(xi.mod.UDMGRANGE, -7500)
    mob:addMod(xi.mod.UDMGMAGIC, -7500)
    mob:addMod(xi.mod.UDMGBREATH, -7500)
    mob:addMod(xi.mod.REGEN, mob:getLocalVar('[uragnite]inShellRegen'))
    mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar('[uragnite]inShellSkillList'))
end

local function exitShell(mob)
    mob:setAnimationSub(open)
    mob:setAutoAttackEnabled(true)
    mob:delMod(xi.mod.UDMGPHYS, -7500)
    mob:delMod(xi.mod.UDMGRANGE, -7500)
    mob:delMod(xi.mod.UDMGMAGIC, -7500)
    mob:delMod(xi.mod.UDMGBREATH, -7500)
    mob:delMod(xi.mod.REGEN, mob:getLocalVar('[uragnite]inShellRegen'))
    mob:setMobMod(xi.mobMod.SKILL_LIST, mob:getLocalVar('[uragnite]noShellSkillList'))
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

xi.mix.uragnite.config = function(mob, params)
    if params.inShellSkillList and type(params.inShellSkillList) == 'number' then
        mob:setLocalVar('[uragnite]inShellSkillList', params.inShellSkillList)
    end

    if params.noShellSkillList and type(params.noShellSkillList) == 'number' then
        mob:setLocalVar('[uragnite]noShellSkillList', params.noShellSkillList)
    end

    if params.chanceToShell and type(params.chanceToShell) == 'number' then
        mob:setLocalVar('[uragnite]chanceToShell', params.chanceToShell)
    end

    if params.timeInShellMin and type(params.timeInShellMin) == 'number' then
        mob:setLocalVar('[uragnite]timeInShellMin', params.timeInShellMin)
    end

    if params.timeInShellMax and type(params.timeInShellMax) == 'number' then
        mob:setLocalVar('[uragnite]timeInShellMax', params.timeInShellMax)
    end

    if params.inShellRegen and type(params.inShellRegen) == 'number' then
        mob:setLocalVar('[uragnite]inShellRegen', params.inShellRegen)
    end
end

g_mixins.families.uragnite = function(uragniteMob)
    -- at spawn, give mob default skill lists for in-shell and out-of-shell states
    -- these defaults can be overwritten by using xi.mix.uragnite.config() in onMobSpawn.

    uragniteMob:addListener('PRESPAWN', 'URAGNITE_SPAWN', function(mob)
        mob:setLocalVar('[uragnite]noShellSkillList', 251)
        mob:setLocalVar('[uragnite]inShellSkillList', 250)
        mob:setLocalVar('[uragnite]chanceToShell', 20)
        mob:setLocalVar('[uragnite]timeInShellMin', 30)
        mob:setLocalVar('[uragnite]timeInShellMax', 45)
        mob:setLocalVar('[uragnite]inShellRegen', 50)
        mob:setAnimationSub(open)
    end)

    uragniteMob:addListener('TAKE_DAMAGE', 'URAGNITE_TAKE_DAMAGE', function(mob, amount, attacker, attackType, damageType)
        if attackType == xi.attackType.PHYSICAL then
            if
                math.randomInt(1, 100) <= mob:getLocalVar('[uragnite]chanceToShell') and
                mob:getAnimationSub() == open
            then
                enterShell(mob)
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                local timeInShell = math.randomInt(mob:getLocalVar('[uragnite]timeInShellMin'), mob:getLocalVar('[uragnite]timeInShellMax'))
                mob:timer(timeInShell * 1000, function(mobArg)
                    exitShell(mobArg)
                end)
            end
        end
    end)

    uragniteMob:addListener('ROAM_TICK', 'URAGNITE_ROAM_TICK', function(mob)
        if
            mob:isFollowingPath() or
            mob:getCurrentAction() == xi.action.category.SLEEP or
            mob:getAnimationSub() ~= open
        then
            return
        end

        local rest = math.randomInt(idleRestMin, idleRestMax)
        mob:wait(rest * 1000)
        if math.randomInt(1, 100) > idleCloseChance then
            return
        end

        local openAt  = rest - idleOpenBefore
        local closeAt = math.max(0, openAt - math.randomInt(idleClosedMin, idleClosedMax))
        mob:timer(closeAt * 1000, function(mobArg)
            if mobArg:getAnimationSub() == open and not mobArg:isEngaged() then
                enterShell(mobArg)
            end
        end)

        mob:timer(openAt * 1000, function(mobArg)
            if mobArg:getAnimationSub() == closed then
                exitShell(mobArg)
            end
        end)
    end)
end

return g_mixins.families.uragnite
