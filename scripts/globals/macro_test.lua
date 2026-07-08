-----------------------------------
-- Macro Test
-----------------------------------
xi = xi or {}
xi.macroTest = xi.macroTest or {}

local applyMacroTest = function(mobArg, attacker)
    if attacker and not attacker:hasStatusEffect(xi.effect.MACRO_TEST) then
        attacker:addStatusEffect(xi.effect.MACRO_TEST, { duration = 10, origin = mobArg })
    end
end

xi.macroTest.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setUnkillable(true)
    mob:setAutoAttackEnabled(false)
    mob:addImmunity(bit.bxor(0xFFFFFFFF, xi.immunity.TERROR)) -- All but Terror

    -- Can't have perma-Terror in a single call
    mob:addStatusEffect(xi.effect.TERROR, { power = 1, duration = 1, origin = mob })
    local terror = mob:getStatusEffect(xi.effect.TERROR)
    if terror then
        terror:setDuration(0)
    end

    mob:addListener('ATTACKED', 'MACRO_TEST_ATTACKED', function(mobArg, attacker, action)
        applyMacroTest(mobArg, attacker)
    end)

    mob:addListener('ABILITY_TAKE', 'MACRO_TEST_ABILITY_TAKE', function(user, target, skill, action)
        applyMacroTest(target, user)
    end)

    mob:addListener('MAGIC_TAKE', 'MACRO_TEST_MAGIC_TAKE', function(target, caster, spell)
        applyMacroTest(target, caster)
    end)

    mob:addListener('WEAPONSKILL_TAKE', 'MACRO_TEST_WEAPONSKILL_TAKE', function(user, target, skill, tp, action)
        applyMacroTest(target, user)
    end)
end
