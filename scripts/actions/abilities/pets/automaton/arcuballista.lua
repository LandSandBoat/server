-----------------------------------
-- Arcuballista
-- Description: Delivers a single attack. Damage varies with TP.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.FIRE_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 1
    params.fTP              = { 2.5, 3.0, 4.0 }
    params.dex_wSC          = 0.60
    params.accuracyModifier = { 100, 100, 100 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.fTP     = { 7.0, 10.0, 13.0 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
