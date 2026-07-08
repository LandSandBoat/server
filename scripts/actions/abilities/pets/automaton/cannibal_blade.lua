-----------------------------------
-- Cannibal Blade
-- Description: Delivers a single hit attack. Additional Effect: Convert damage dealt to HP.
-- SE claims this has a 1.0 MND wSC modifier. At this time it does not appear to have any scaling outside of Automaton Skill.
-- Cannot miss, cannot double attack, ignores PDIF, but is affected by Slashing/Physical DT modifiers.
-- Despite behaving like a magic ability, does not go through shadows.
-- Returns 0 TP.
-- TODO: Refine formula if more retail data becomes available.
-- Automaton Skill / 9.2 is very close, but not exact. Retail appears to use non-linear scaling or hidden stepping.
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()

    if not master then
        return
    end

    return master:countEffect(xi.effect.DARK_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage         = automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE) / 9.2
    params.numHits            = 1
    params.fTP                = { 11.0, 12.5, 14.0 }
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.SLASHING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.guaranteedFirstHit = true
    params.skipFSTR           = true
    params.skipPDIF           = true

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.fTP        = { 16.0, 23.5, 31.0 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        if not target:isUndead() then
            automaton:addHP(info.damage)
        end
    end

    -- Does not return TP.
    automaton:setTP(0)

    return info.damage
end

return abilityObject
