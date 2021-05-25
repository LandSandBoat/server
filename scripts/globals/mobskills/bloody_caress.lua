-----------------------------------
--  Bloody Caress
--
--  Delivers a threefold attack. Additional effect: Drain
--  Type: Physical
--  100% TP: ??? / 250% TP: ??? / 300% TP: ???
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1

    -- TODO: Once `Floral Bouquet` TP move is implemented, this skill is eligible to target
    -- the charmed monsters.

    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_ACC_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    skill:setMsg(MobPhysicalDrainMove(mob, target, skill, MOBDRAIN_HP, dmg))

    return dmg
end

return mobskill_object
