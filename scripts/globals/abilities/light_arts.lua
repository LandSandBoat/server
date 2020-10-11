-----------------------------------
-- Ability: Light Arts
-- Optimizes white magic capability while lowering black magic proficiency. Grants a bonus to divine, enhancing, enfeebling, and healing magic. Also grants access to Stratagems.
-- Obtained: Scholar Level 10
-- Recast Time: 1:00
-- Duration: 2:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:hasStatusEffect(tpz.effect.LIGHT_ARTS) or player:hasStatusEffect(tpz.effect.ADDENDUM_WHITE) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:delStatusEffectSilent(tpz.effect.DARK_ARTS)
    player:delStatusEffect(tpz.effect.ADDENDUM_BLACK)
    player:delStatusEffect(tpz.effect.PARSIMONY)
    player:delStatusEffect(tpz.effect.ALACRITY)
    player:delStatusEffect(tpz.effect.MANIFESTATION)
    player:delStatusEffect(tpz.effect.EBULLIENCE)
    player:delStatusEffect(tpz.effect.FOCALIZATION)
    player:delStatusEffect(tpz.effect.EQUANIMITY)
    player:delStatusEffect(tpz.effect.IMMANENCE)

    local skillbonus = player:getMod(tpz.mod.LIGHT_ARTS_SKILL)
    local effectbonus = player:getMod(tpz.mod.LIGHT_ARTS_EFFECT)
    local regenbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    player:addStatusEffect(tpz.effect.LIGHT_ARTS, effectbonus, 0, 7200, 0, regenbonus)

    return tpz.effect.LIGHT_ARTS
end
