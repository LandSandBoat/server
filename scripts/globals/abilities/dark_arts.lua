-----------------------------------
-- Ability: Dark Arts
-- Optimizes black magic capability while lowering white magic proficiency. Grants a bonus to enfeebling, elemental, and dark magic. Also grants access to Stratagems.
-- Obtained: Scholar Level 10
-- Recast Time: 1:00
-- Duration: 2:00:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------

function onAbilityCheck(player, target, ability)
    if player:hasStatusEffect(tpz.effect.DARK_ARTS) or player:hasStatusEffect(tpz.effect.ADDENDUM_BLACK) then
        return tpz.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end
    return 0, 0
end

function onUseAbility(player, target, ability)
    player:delStatusEffectSilent(tpz.effect.LIGHT_ARTS)
    player:delStatusEffect(tpz.effect.ADDENDUM_WHITE)
    player:delStatusEffect(tpz.effect.PENURY)
    player:delStatusEffect(tpz.effect.CELERITY)
    player:delStatusEffect(tpz.effect.ACCESSION)
    player:delStatusEffect(tpz.effect.RAPTURE)
    player:delStatusEffect(tpz.effect.ALTRUISM)
    player:delStatusEffect(tpz.effect.TRANQUILITY)
    player:delStatusEffect(tpz.effect.PERPETUANCE)

    local helixbonus = 0
    if (player:getMainJob() == tpz.job.SCH and player:getMainLvl() >= 20) then
        helixbonus = math.floor(player:getMainLvl() / 4)
    end

    player:addStatusEffect(tpz.effect.DARK_ARTS, 1, 0, 7200, 0, helixbonus)

    return tpz.effect.DARK_ARTS
end
