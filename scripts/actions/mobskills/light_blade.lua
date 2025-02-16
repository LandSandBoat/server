-----------------------------------
--  Light Blade
--  Description: Deals very high physical damage to a single player.
--  Type: Ranged
--  Damage decreases the farther away the target is from him.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)
    -- TODO: There's no MOBPARAM_RANGED, but MOBPARAM doesn't appear to do anything?
    -- Guessing ~40-100% damage based on range (20/50+).
    -- TODO: Find better data?
    -- ~400-450ish at tanking/melee range for a PLD with defender up and earth staff.
    -- ~750 for a DRG/BLU w/o Cocoon up at melee range.
    -- Wiki says 1k, videos were actually less, so trusting videos.
    local distance = mob:checkDistance(target)
    distance = utils.clamp(distance, 0, 40)
    dmg = dmg * ((50 - distance) / 50)

    target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
