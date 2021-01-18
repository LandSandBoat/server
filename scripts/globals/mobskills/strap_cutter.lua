-----------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
-- todo make a random for which gear to remove and how many pieces
    local REMOVE = 0xFFFF

    target:addStatusEffectEx(tpz.effect.ENCUMBRANCE_I, tpz.effect.ENCUMBRANCE_I, REMOVE, 0, 60)
end

return mobskill_object
