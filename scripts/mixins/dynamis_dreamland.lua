-----------------------------------
-- Dynamis procs mixin
-----------------------------------
require('scripts/globals/mixins')
require('scripts/globals/dynamis')
-----------------------------------
g_mixins = g_mixins or {}

g_mixins.dynamis_dreamland = function(dynamisDreamlandMob)
    local procTimes =
    {
        weaponskill =
        {
            [xi.item.TUKUKU_WHITESHELL  ] = {  0,  8 },
            [xi.item.ORDELLE_BRONZEPIECE] = { 16, 24 },
            [xi.item.ONE_BYNE_BILL      ] = {  8, 16 },
        },

        magic =
        {
            [xi.item.TUKUKU_WHITESHELL  ] = {  8, 16 },
            [xi.item.ORDELLE_BRONZEPIECE] = {  0,  8 },
            [xi.item.ONE_BYNE_BILL      ] = { 16, 24 },
        },

        jobAbility =
        {
            [xi.item.TUKUKU_WHITESHELL  ] = { 16, 24 },
            [xi.item.ORDELLE_BRONZEPIECE] = {  8, 16 },
            [xi.item.ONE_BYNE_BILL      ] = {  0,  8 },
        },
    }

    -- "With Treasure Hunter on every procced monster, you can expect approximately 1.7 coins per kill on average."
    -- "Without Treasure Hunter, you can expect about 1.25 coins per kill on average."
    -- "Without a proc, the coin drop rate is very low (~10%)"
    local thCurrency =
    {
        [0] = { single = 100, hundred =  5 },
        [1] = { single = 115, hundred = 10 },
        [2] = { single = 145, hundred = 20 },
        [3] = { single = 190, hundred = 35 },
        [4] = { single = 250, hundred = 50 },
    }

    dynamisDreamlandMob:addListener('MAGIC_TAKE', 'DYNAMIS_MAGIC_PROC_CHECK', function(target, caster, spell, action)
        local isPrimary = action and target:getID() == action:getPrimaryTargetID()
        local chance = isPrimary and 8 or 1 -- Lowered chance if not primary target. 1% is likely not the right number, submit captures.

        if math.random(1, 100) > chance then
            return
        end

        if target:getLocalVar('dynamis_proc') ~= 0 then
            return
        end

        local currency = target:getLocalVar('dynamis_currency')
        local vanaHour = VanadielHour()

        if
            currency == 0 or
            (vanaHour >= procTimes.magic[currency][1] and
            vanaHour < procTimes.magic[currency][2])
        then
            xi.dynamis.procMonster(target, caster)
        end
    end)

    dynamisDreamlandMob:addListener('WEAPONSKILL_TAKE', 'DYNAMIS_WS_PROC_CHECK', function(user, target, skill, tp, action)
        local isPrimary = action and target:getID() == action:getPrimaryTargetID()
        local chance = isPrimary and 25 or 2 -- Lowered chance if not primary target. 2% is likely not the right number, submit captures.

        if math.random(1, 100) > chance then
            return
        end

        if target:getLocalVar('dynamis_proc') ~= 0 then
            return
        end

        local currency = target:getLocalVar('dynamis_currency')
        local vanaHour = VanadielHour()

        if
            currency == 0 or
            (vanaHour >= procTimes.weaponskill[currency][1] and
            vanaHour < procTimes.weaponskill[currency][2])
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisDreamlandMob:addListener('ABILITY_TAKE', 'DYNAMIS_ABILITY_PROC_CHECK', function(user, target, skill, action)
        local isPrimary = action and target:getID() == action:getPrimaryTargetID()
        local chance = isPrimary and 20 or 2 -- Lowered chance if not primary target. 2% is likely not the right number, submit captures.

        if math.random(1, 100) > chance then
            return
        end

        if target:getLocalVar('dynamis_proc') ~= 0 then
            return
        end

        local currency = target:getLocalVar('dynamis_currency')
        local vanaHour = VanadielHour()
        if
            currency == 0 or
            (vanaHour >= procTimes.jobAbility[currency][1] and
            vanaHour < procTimes.jobAbility[currency][2])
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisDreamlandMob:addListener('DEATH', 'DYNAMIS_ITEM_DISTRIBUTION', function(mob, killer)
        if not killer then
            return
        end

        local th            = thCurrency[math.min(mob:getTHlevel(), 4)]
        local singleChance  = mob:getMainLvl() > 90 and math.floor(th.single * 1.5) or th.single
        local hundredChance = th.hundred
        local currency      = mob:getLocalVar('dynamis_currency')
        if currency == 0 then
            currency = xi.item.TUKUKU_WHITESHELL + math.random(0, 2) * 3
        end

        -- White (special) adds 100% hundred slot
        if mob:getLocalVar('dynamis_proc') >= 4 then
            killer:addTreasure(currency + 1, mob)
        end

        -- Base hundred slot
        if mob:isNM() then
            killer:addTreasure(currency + 1, mob, hundredChance)
        end

        -- Red (high) adds 100% single slot
        if mob:getLocalVar('dynamis_proc') >= 3 then
            killer:addTreasure(currency, mob)
        end

        -- Yellow (medium) adds single slot
        if mob:getLocalVar('dynamis_proc') >= 2 then
            killer:addTreasure(currency, mob, singleChance)
        end

        -- Blue (low) adds single slot
        if mob:getLocalVar('dynamis_proc') >= 1 then
            killer:addTreasure(currency, mob, singleChance)
        end

        killer:addTreasure(currency, mob, singleChance) -- base single slot
    end)
end

return g_mixins.dynamis_dreamland
