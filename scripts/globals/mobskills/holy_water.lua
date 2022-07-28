-----------------------------------
-- Holy Water - Removes Curse, Zombie, and Doom.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.CURSE_I) then
        target:delStatusEffect(xi.effect.CURSE_I)
    end
    if target:hasStatusEffect(xi.effect.CURSE_II) then
        target:delStatusEffect(xi.effect.CURSE_II)
    end
    if target:hasStatusEffect(xi.effect.ZOMBIE) then
        target:delStatusEffect(xi.effect.ZOMBIE)
    end
    if target:hasStatusEffect(xi.effect.DOOM) then
        target:delStatusEffect(xi.effect.DOOM)
    end
    return 0
end

return mobskill_object
