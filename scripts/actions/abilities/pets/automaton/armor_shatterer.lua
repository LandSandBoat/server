-----------------------------------
-- Armor Shatterer
-- Description: Delivers a fourfold attack. Additional Effect: Defense Down. Effect duration varies with TP.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.WIND_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 4
    params.fTP              = { 6.0, 6.0, 6.0 }
    params.dex_wSC          = 0.50
    params.attackMultiplier = { 1.25, 1.25, 1.25 }
    params.accuracyModifier = { 50, 50, 50 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_4
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    local duration = math.floor(60 + 3 * skill:getTP() / 100)

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.DEFENSE_DOWN, 15, 0, duration)
    end

    return info.damage
end

return abilityObject
