-----------------------------------
-- Ability: Addendum: Black
-- Allows access to additional Black Magic spells while using Dark Arts.
-- Obtained: Scholar Level 30
-- Recast Time: Stratagem Charge
-- Duration: 2 hours
--
-- Level   |Charges |Recharge Time per Charge
-- -----   -------- ---------------
-- 10      |1       |4:00 minutes
-- 30      |2       |2:00 minutes
-- 50      |3       |1:20 minutes
-- 70      |4       |1:00 minute
-- 90      |5       |48 seconds
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:delStatusEffectSilent(tpz.effect.LIGHT_ARTS)
    player:delStatusEffectSilent(tpz.effect.ADDENDUM_WHITE)
    player:delStatusEffectSilent(tpz.effect.DARK_ARTS)

    local skillbonus = player:getMod(tpz.mod.DARK_ARTS_SKILL)
    local effectbonus = player:getMod(tpz.mod.DARK_ARTS_EFFECT)
    local helixbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffectEx(tpz.effect.ADDENDUM_BLACK, tpz.effect.ADDENDUM_BLACK, effectbonus, 0, 7200, 0, helixbonus, true)

    return tpz.effect.ADDENDUM_BLACK
end
