-----------------------------------
--  Reaving Wind (Knockback)
--    Mob Ability: 2426
--  Description: Does no damage, knockback only.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Notes: Zirnitra uses multiple times while reaving wind aura is active.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
end

return mobskillObject
