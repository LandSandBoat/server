-----------------------------------
-- Daze
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1,
        accBonus = 150,
        ftpMod = { 5.0, 5.5, 6.0 },
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.dex_wsc = 1.0
        params.ftpMod = { 6.0, 8.5, 11.0 }
    end

    local damage = xi.autows.doAutoRangedWeaponskill(automaton, target, 0, params, skill:getTP(), true, skill, action)

    if damage > 0 then
        local chance = 0.033 * skill:getTP()
        if
            not target:hasStatusEffect(xi.effect.STUN) and
            chance >= math.random() * 100
        then
            target:addStatusEffect(xi.effect.STUN, 1, 0, 4)
        end
    end

    return damage
end

return abilityObject
