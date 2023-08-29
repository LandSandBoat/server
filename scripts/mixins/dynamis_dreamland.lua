-- Dynamis procs mixin
-- Customization:

require("scripts/globals/mixins")
require("scripts/globals/dynamis")

g_mixins = g_mixins or {}

-- dynamis_currency values:
--  t.whiteshell: 1449
--  o. bronzepiece: 1452
--  1 byne bill: 1455
--  random: 0

g_mixins.dynamis_dreamland = function(dynamisDreamlandMob)
    local proctimes =
    {
        WS =
        {
            [1449] = {  0,  8 },
            [1452] = { 16, 24 },
            [1455] = {  8, 16 },
        },

        Magic =
        {
            [1449] = {  8, 16 },
            [1452] = {  0,  8 },
            [1455] = { 16, 24 },
        },

        JA =
        {
            [1449] = { 16, 24 },
            [1452] = {  8, 16 },
            [1455] = {  0,  8 },
        },
    }

    -- "With Treasure Hunter on every procced monster, you can expect approximately 1.7 coins per kill on average."
    -- "Without Treasure Hunter, you can expect about 1.25 coins per kill on average."
    -- "Without a proc, the coin drop rate is very low (~10%)"
    local thCurrency =
    {
        [0] = { single = 100, hundo =  5 },
        [1] = { single = 115, hundo = 10 },
        [2] = { single = 145, hundo = 20 },
        [3] = { single = 190, hundo = 35 },
        [4] = { single = 250, hundo = 50 },
    }

    dynamisDreamlandMob:addListener("MAGIC_TAKE", "DYNAMIS_MAGIC_PROC_CHECK", function(target, caster, spell)
        local currency = target:getLocalVar("dynamis_currency")
        local vanaHour = VanadielHour()

        if
            math.random(0, 99) < 8 and
            target:getLocalVar("dynamis_proc") == 0 and
            (
                currency == 0 or
                (
                    vanaHour >= proctimes.Magic[currency][1] and
                    vanaHour < proctimes.Magic[currency][2]
                )
            )
        then
            xi.dynamis.procMonster(target, caster)
        end
    end)

    dynamisDreamlandMob:addListener("WEAPONSKILL_TAKE", "DYNAMIS_WS_PROC_CHECK", function(target, user, wsid)
        local currency = target:getLocalVar("dynamis_currency")
        local vanaHour = VanadielHour()

        if
            math.random(0, 99) < 25 and
            target:getLocalVar("dynamis_proc") == 0 and
            (
                currency == 0 or
                (
                    vanaHour >= proctimes.WS[currency][1] and
                    vanaHour < proctimes.WS[currency][2]
                )
            )
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisDreamlandMob:addListener("ABILITY_TAKE", "DYNAMIS_ABILITY_PROC_CHECK", function(target, user, ability, action)
        local currency = target:getLocalVar("dynamis_currency")
        local vanaHour = VanadielHour()

        if
            math.random(0, 99) < 20 and
            target:getLocalVar("dynamis_proc") == 0 and
            (
                currency == 0 or
                (
                    vanaHour >= proctimes.JA[currency][1] and
                    vanaHour < proctimes.JA[currency][2]
                )
            )
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisDreamlandMob:addListener("DEATH", "DYNAMIS_ITEM_DISTRIBUTION", function(mob, killer)
        if killer then
            local th = thCurrency[math.min(mob:getTHlevel(), 4)]
            local currency = mob:getLocalVar("dynamis_currency")
            if currency == 0 then
                currency = 1449 + math.random(0, 2) * 3
            end

            local singleChance = th.single
            local hundoChance = th.hundo
            if mob:getMainLvl() > 90 then
                singleChance = math.floor(singleChance * 1.5)
            end

            -- White (special) adds 100% hundred slot
            if mob:getLocalVar("dynamis_proc") >= 4 then
                killer:addTreasure(currency + 1, mob)
            end

            -- Base hundred slot
            if mob:isNM() then
                killer:addTreasure(currency + 1, mob, hundoChance)
            end

            -- Red (high) adds 100% single slot
            if mob:getLocalVar("dynamis_proc") >= 3 then
                killer:addTreasure(currency, mob)
            end

            -- Yellow (medium) adds single slot
            if mob:getLocalVar("dynamis_proc") >= 2 then
                killer:addTreasure(currency, mob, singleChance)
            end

            -- Blue (low) adds single slot
            if mob:getLocalVar("dynamis_proc") >= 1 then
                killer:addTreasure(currency, mob, singleChance)
            end

            killer:addTreasure(currency, mob, singleChance) -- base single slot
        end
    end)
end

return g_mixins.dynamis_dreamland
