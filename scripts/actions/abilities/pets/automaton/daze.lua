-----------------------------------
-- Daze
-- Description: Delivers a single attack. Damage varies with TP. Additional Effect: Stun.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 1
    params.fTP              = { 5.0, 5.5, 6.0 }
    params.dex_wSC          = 0.60
    params.accuracyModifier = { 150, 150, 150 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.fTP     = { 6.0, 8.5, 11.0 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end

return abilityObject
