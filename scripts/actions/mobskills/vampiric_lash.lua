-----------------------------------
-- Vampiric Lash
-- Family: Morbol
-- Description: Deals 200% physical damage to a single target. Additional Effect: HP Drain
-- Notes: (Unverified) In ToAU zones, this has an additional effect of absorbing all status effects.
--        (Verified) Will not absorb food in ToAU zones.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg() -- TODO: Capture baseDamage
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.PIERCING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipPDIF       = true

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
    end

    return info.damage
end

return mobskillObject
