-----------------------------------
-- String Shredder
-- Description: Delivers a threefold attack. Critical hit rate varies with TP.
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

    params.baseDamage       = automaton:getWeaponDmg()
    params.numHits          = utils.clamp(2 + xi.automaton.getExtraHits(automaton, 2), 1, 8)
    params.fTP              = { 1.5, 1.5, 1.5 }
    params.vit_wSC          = 0.50
    params.attackMultiplier = { 1.36, 1.36, 1.36 }
    params.canCrit          = true
    params.criticalChance   = { 0.2, 0.4, 0.7 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = params.numHits

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end

return abilityObject
