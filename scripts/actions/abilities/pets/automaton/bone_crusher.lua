-----------------------------------
-- Bone Crusher
-----------------------------------
local abilityObject = {}

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    local master = automaton:getMaster()
    return master:countEffect(xi.effect.LIGHT_MANEUVER)
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params =
    {
        numHits = 3,
        atkmulti = 1,
        weaponType = xi.skill.CLUB,
        ftpMod = { 1.5, 1.5, 1.5 },
        vit_wsc = 0.6,
    }

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftpMod = { 2.66, 2.66, 2.66 }

        if target:isUndead() then
            params.ftpMod = { 3.66, 3.66, 3.66 }
        end
    else
        if target:isUndead() then
            params.ftpMod = { 2.0, 2.0, 2.0 }
        end
    end

    local damage = xi.autows.doAutoPhysicalWeaponskill(automaton, target, 0, skill:getTP(), true, action, false, params, skill)

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
