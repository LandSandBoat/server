-----------------------------------
--  Light Blade
--  Description: Deals very high physical damage to a single player.
--  Type: Ranged
--  Damage decreases the farther away the target is from him.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 8
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.SLASHING, info.hitslanded)
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

return mobskill_object
