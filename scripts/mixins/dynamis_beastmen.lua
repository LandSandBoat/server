-- Dynamis procs mixin

require("scripts/globals/mixins")
require("scripts/globals/dynamis")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.dynamis_beastmen = function(mob)
    local procjobs = {
        [tpz.job.WAR] = "ws",
        [tpz.job.MNK] = "ja",
        [tpz.job.WHM] = "ma",
        [tpz.job.BLM] = "ma",
        [tpz.job.RDM] = "ma",
        [tpz.job.THF] = "ja",
        [tpz.job.PLD] = "ws",
        [tpz.job.DRK] = "ws",
        [tpz.job.BST] = "ja",
        [tpz.job.BRD] = "ma",
        [tpz.job.RNG] = "ja",
        [tpz.job.SAM] = "ws",
        [tpz.job.NIN] = "ja",
        [tpz.job.DRG] = "ws",
        [tpz.job.SMN] = "ma"
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
        [0] = {single = 100, hundo =  5},
        [1] = {single = 115, hundo = 10},
        [2] = {single = 145, hundo = 20},
        [3] = {single = 190, hundo = 35},
        [4] = {single = 250, hundo = 50},
    }

    mob:addListener("MAGIC_TAKE", "DYNAMIS_MAGIC_PROC_CHECK", function(target, caster, spell)
        if procjobs[target:getMainJob()] == "ma" and math.random(0, 99) < 8 and target:getLocalVar("dynamis_proc") == 0 then
            dynamis.procMonster(target, caster)
        end
    end)

    mob:addListener("WEAPONSKILL_TAKE", "DYNAMIS_WS_PROC_CHECK", function(target, user, wsid)
        if procjobs[target:getMainJob()] == "ws" and math.random(0, 99) < 25 and target:getLocalVar("dynamis_proc") == 0 then
            dynamis.procMonster(target, user)
        end
    end)

    mob:addListener("ABILITY_TAKE", "DYNAMIS_ABILITY_PROC_CHECK", function(mob, user, ability, action)
        if procjobs[mob:getMainJob()] == "ja" and math.random(0, 99) < 20 and mob:getLocalVar("dynamis_proc") == 0 then
            dynamis.procMonster(mob, user)
        end
    end)

    mob:addListener("DEATH", "DYNAMIS_ITEM_DISTRIBUTION", function(mob, killer)
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

            if mob:getLocalVar("dynamis_proc") >= 4 then killer:addTreasure(currency + 1, mob) end           -- white (special) adds 100% hundo slot
            if mob:isNM() then killer:addTreasure(currency + 1, mob, hundoChance) end                        -- base hundo slot

            if mob:getLocalVar("dynamis_proc") >= 3 then killer:addTreasure(currency, mob) end               -- red (high) adds 100% single slot
            if mob:getLocalVar("dynamis_proc") >= 2 then killer:addTreasure(currency, mob, singleChance) end -- yellow (medium) adds single slot
            if mob:getLocalVar("dynamis_proc") >= 1 then killer:addTreasure(currency, mob, singleChance) end -- blue (low) adds single slot
            killer:addTreasure(currency, mob, singleChance)                                                  -- base single slot
        end
    end)
end

return g_mixins.dynamis_beastmen
