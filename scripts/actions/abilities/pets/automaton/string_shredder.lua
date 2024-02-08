-----------------------------------
-- String Shredder
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.THUNDER_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 2,
        atkmulti = 1.36,
        weaponType = xi.skill.SWORD,
        ftpMod = { 1.5, 1.5, 1.5 },
        critVaries = { 0.2, 0.4, 0.7 },
        vit_wsc = 0.5,
    }

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

    return damage
end

return abilityObject
