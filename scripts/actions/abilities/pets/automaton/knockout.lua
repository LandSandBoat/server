-----------------------------------
-- Knockout
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.WIND_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 1,
        atkmulti = 1,
        accBonus = 50,
        weaponType = xi.skill.CLUB,
        ftpMod = { 4.0, 5.0, 5.5 },
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.agi_wsc = 1.0
        params.ftpMod = { 6.0, 8.5, 11.0 }
    end

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    if damage > 0 then
        if not target:hasStatusEffect(xi.effect.EVASION_DOWN) then
            target:addStatusEffect(xi.effect.EVASION_DOWN, 10, 0, 30)
        end
    end

    return damage
end

return abilityObject
