---------------------------------------------------
-- Ruinous Omen
-- Used by:  Diabolos
-- Deals damage equal to a random percentage of HP to enemies within area of effect
-- https://ffxiclopedia.fandom.com/wiki/Ruinous_Omen
-- Prime Avatar seems to do an unresisted ~66% HP reduction from players' current HP (not max HP)
-- RO by design cannot KO a target, but can significantly reduce its HP
-- Version used by player summoners seems capped at ~2% except against Behemoths
---------------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/utils")
---------------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dINT = math.floor(mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))

    -- Target HPP decrease seems to be about 66% unresisted.
    -- Maximum observed 72% (weakness to darkness?)
    -- Minimum observed 44% (high resist)
    local hppTarget = 66
    local hppMin = 44
    local hppMax = 75
    local dmgmod = 0.7   -- Estimated from keeping with a max of ~72% reduction
    local ratio = 4
    if dINT >= 0 then ratio = 6 end  -- Tilt the curve so that a small dINT doesn't tip too far in Diabolos' favour.
    hppTarget = hppTarget + (dINT / ratio)    -- A wild estimate.  Diabolos INT is 131 in Waking Dreams.

    -- hpp and damage do not correlate, but we can use the system to scale damage numbers
    hppTarget = xi.mobskills.mobMagicalMove(mob, target, skill, hppTarget, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus, 0)
    hppTarget = xi.mobskills.mobAddBonuses(mob, target, hppTarget.dmg, xi.magic.ele.DARK)
    hppTarget = xi.mobskills.mobFinalAdjustments(hppTarget, mob, skill, target, xi.attackType.SPECIAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    -- Clamp the HPP reduction to a 75% total cap and a 40% total Minimum
    hppTarget = utils.clamp(hppTarget, hppMin, hppMax)

    -- Convert the reduction into a player-specific amount based on their current HP
    local damage = target:getHP() * hppTarget / 100

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return damage
end

return mobskillObject
