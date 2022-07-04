---------------------------------------------------
--  Cosmic Elucidation
--  Description: Cosmic Elucidation inflicts heavy AOE damage to everyone in the battle.
--  Type:
--  Utsusemi/Blink absorb: Ignores shadows
--  Range:
--  Notes: Ejects all combatants from the battlefield, resulting in a failure.
---------------------------------------------------
require("settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/msg")
---------------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 1 -- only scripted use
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 2
local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*21, xi.magic.ele.LIGHT, dmgmod, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, 0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)

    -- TODO: Cosmic Elucidation has a special message shown below
    -- However it always displays 0 DMG even though its sopposed to show the amount of dmg a player takes
    -- Need to figure out how to pass DMG through to this specific message.
    --skill:setMsg(302) -- cosmic elucidation messageid

    return dmg

end

return mobskill_object
