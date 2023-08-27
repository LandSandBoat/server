-----------------------------------
-- Ability: Light Arts
-- Optimizes white magic capability while lowering black magic proficiency. Grants a bonus to divine, enhancing, enfeebling, and healing magic. Also grants access to Stratagems.
-- Obtained: Scholar Level 10
-- Recast Time: 1:00
-- Duration: 2:00:00
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if
        player:hasStatusEffect(xi.effect.LIGHT_ARTS) or
        player:hasStatusEffect(xi.effect.ADDENDUM_WHITE)
    then
        return xi.msg.basic.EFFECT_ALREADY_ACTIVE, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    player:delStatusEffectSilent(xi.effect.DARK_ARTS)
    player:delStatusEffect(xi.effect.ADDENDUM_BLACK)
    player:delStatusEffect(xi.effect.PARSIMONY)
    player:delStatusEffect(xi.effect.ALACRITY)
    player:delStatusEffect(xi.effect.MANIFESTATION)
    player:delStatusEffect(xi.effect.EBULLIENCE)
    player:delStatusEffect(xi.effect.FOCALIZATION)
    player:delStatusEffect(xi.effect.EQUANIMITY)
    player:delStatusEffect(xi.effect.IMMANENCE)

    local effectbonus = player:getMod(xi.mod.LIGHT_ARTS_EFFECT)
    local regenbonus  = 0

    if player:getMainJob() == xi.job.SCH and player:getMainLvl() >= 20 then
        regenbonus = 3 * math.floor((player:getMainLvl() - 10) / 10)
    end

    player:addStatusEffect(xi.effect.LIGHT_ARTS, effectbonus, 0, 7200, 0, regenbonus)

    return xi.effect.LIGHT_ARTS
end

return abilityObject
