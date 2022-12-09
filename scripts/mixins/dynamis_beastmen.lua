-- Dynamis procs mixin

require("scripts/globals/mixins")
require("scripts/globals/dynamis")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.dynamis_beastmen = function(dynamisBeastmenMob)
    local procjobs =
    {
        [xi.job.WAR] = "ws",
        [xi.job.MNK] = "ja",
        [xi.job.WHM] = "ma",
        [xi.job.BLM] = "ma",
        [xi.job.RDM] = "ma",
        [xi.job.THF] = "ja",
        [xi.job.PLD] = "ws",
        [xi.job.DRK] = "ws",
        [xi.job.BST] = "ja",
        [xi.job.BRD] = "ma",
        [xi.job.RNG] = "ja",
        [xi.job.SAM] = "ws",
        [xi.job.NIN] = "ja",
        [xi.job.DRG] = "ws",
        [xi.job.SMN] = "ma"
    }

    local familyCurrency =
    {
        [334] = 1452, -- OrcNM (bronzepiece)
        [337] = 1455, -- QuadavNM (1 byne bill)
        [360] = 1449, -- YagudoNM (whiteshell)
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

    dynamisBeastmenMob:addListener("MAGIC_TAKE", "DYNAMIS_MAGIC_PROC_CHECK", function(target, caster, spell)
        if
            procjobs[target:getMainJob()] == "ma" and
            math.random(0, 99) < 8 and
            target:getLocalVar("dynamis_proc") == 0
        then
            xi.dynamis.procMonster(target, caster)
        end
    end)

    dynamisBeastmenMob:addListener("WEAPONSKILL_TAKE", "DYNAMIS_WS_PROC_CHECK", function(target, user, wsid)
        if
            procjobs[target:getMainJob()] == "ws" and
            math.random(0, 99) < 25 and
            target:getLocalVar("dynamis_proc") == 0
        then
            xi.dynamis.procMonster(target, user)
        end
    end)

    dynamisBeastmenMob:addListener("ABILITY_TAKE", "DYNAMIS_ABILITY_PROC_CHECK", function(mob, user, ability, action)
        if
            procjobs[mob:getMainJob()] == "ja" and
            math.random(0, 99) < 20 and
            mob:getLocalVar("dynamis_proc") == 0
        then
            xi.dynamis.procMonster(mob, user)
        end
    end)

    dynamisBeastmenMob:addListener("DEATH", "DYNAMIS_ITEM_DISTRIBUTION", function(mob, killer)
        if killer then
            local th = thCurrency[math.min(mob:getTHlevel(), 4)]
            local family = mob:getFamily()
            local currency = familyCurrency[family]
            if currency == nil then
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

            -- red (high) adds 100% single slot
            if mob:getLocalVar("dynamis_proc") >= 3 then
                killer:addTreasure(currency, mob)
            end

            -- yellow (medium) adds single slot
            if mob:getLocalVar("dynamis_proc") >= 2 then
                killer:addTreasure(currency, mob, singleChance)
            end

            -- blue (low) adds single slot
            if mob:getLocalVar("dynamis_proc") >= 1 then
                killer:addTreasure(currency, mob, singleChance)
            end

            killer:addTreasure(currency, mob, singleChance) -- base single slot
        end
    end)
end

return g_mixins.dynamis_beastmen
