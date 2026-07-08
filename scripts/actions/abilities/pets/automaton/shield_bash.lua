-----------------------------------
-- Shield Bash (Automaton)
-- Description: Deals damage and stuns the target. Additional effect: Slow - Based on Earth Maneuvers if Hammermill is equipped.
-- Hammermill Slow increases with tiers per Earth Maneuver, at 3, overrides Haste (tier 6) -- Confirmed in Brenner.
-- https://wiki.ffo.jp/html/12156.html
-----------------------------------
---@type TAbilityAutomaton
local abilityObject = {}

-- Slow tier and duration based on Earth Maneuvers.
local slowTable =
{
    [1] = { tier = 4, duration = 30 },
    [2] = { tier = 5, duration = 50 },
    [3] = { tier = 6, duration = 70 },
}

local function applyHammermillSlow(automaton, target, skill, master)
    local power = automaton:getMod(xi.mod.AUTO_SHIELD_BASH_SLOW) * 100
    if power <= 0 then
        return
    end

    local slowTier = slowTable[master and master:countEffect(xi.effect.EARTH_MANEUVER) or 0]

    local params =
    {
        [1] = { effectId = xi.effect.SLOW, power = power, duration = slowTier.duration, tier = slowTier.tier },
    }

    xi.combat.action.executeMobskillStatusEffect(automaton, target, skill, params, { messageBypass = true })
end

abilityObject.onAutomatonAbilityCheck = function(target, automaton, skill)
    return 0
end

abilityObject.onAutomatonAbility = function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage     = automaton:getWeaponDmg()
    params.numHits        = utils.clamp(1 + xi.automaton.getExtraHits(automaton, 1), 1, 8)
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = params.numHits

    local hammermillEquipped = automaton:hasAttachmentSet(xi.item.HAMMERMILL_ATTACHMENT)

    if hammermillEquipped then
        local shieldBashBonus = 1.0 + automaton:getMod(xi.mod.SHIELD_BASH) / 100

        params.fTP =
        {
            params.fTP[1] * shieldBashBonus,
            params.fTP[2] * shieldBashBonus,
            params.fTP[3] * shieldBashBonus,
        }

        params.guaranteedFirstHit = true
    end

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.STUN, 1, 0, 6)

        -- Check for Hammermill, if equipped, apply Slow based on Earth Maneuvers.
        if hammermillEquipped then
            applyHammermillSlow(automaton, target, skill, master)
        end
    end

    return info.damage
end

return abilityObject
