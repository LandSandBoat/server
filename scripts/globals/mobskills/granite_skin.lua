-----------------------------------
-- Granite Skin
-- Description: Physical Shield
-- TODO: This is a buff that makes target in front of target deal 0 physical damage.
-- This will need a new effect and some kind of check to zero it properly.
-- https://www.bg-wiki.com/ffxi/Locus_Wivre
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobBuffMove(mob, xi.effect.PHYSICAL_SHIELD, 3, 0, 30)
    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
