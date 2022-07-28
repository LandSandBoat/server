-----------------------------------
-- Mix: Panacea-1 - Removes anything a Panacea can remove.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.PARALYSIS)
    target:delStatusEffect(xi.effect.BIND)
    target:delStatusEffect(xi.effect.WEIGHT)
    target:delStatusEffect(xi.effect.ADDLE)
    target:delStatusEffect(xi.effect.BURN)
    target:delStatusEffect(xi.effect.FROST)
    target:delStatusEffect(xi.effect.CHOKE)
    target:delStatusEffect(xi.effect.RASP)
    target:delStatusEffect(xi.effect.SHOCK)
    target:delStatusEffect(xi.effect.DROWN)
    target:delStatusEffect(xi.effect.DIA)
    target:delStatusEffect(xi.effect.BIO)
    target:delStatusEffect(xi.effect.STR_DOWN)
    target:delStatusEffect(xi.effect.DEX_DOWN)
    target:delStatusEffect(xi.effect.VIT_DOWN)
    target:delStatusEffect(xi.effect.AGI_DOWN)
    target:delStatusEffect(xi.effect.INT_DOWN)
    target:delStatusEffect(xi.effect.MND_DOWN)
    target:delStatusEffect(xi.effect.CHR_DOWN)
    target:delStatusEffect(xi.effect.MAX_HP_DOWN)
    target:delStatusEffect(xi.effect.MAX_MP_DOWN)
    target:delStatusEffect(xi.effect.ATTACK_DOWN)
    target:delStatusEffect(xi.effect.EVASION_DOWN)
    target:delStatusEffect(xi.effect.DEFENSE_DOWN)
    target:delStatusEffect(xi.effect.MAGIC_DEF_DOWN)
    target:delStatusEffect(xi.effect.INHIBIT_TP)
    target:delStatusEffect(xi.effect.MAGIC_ACC_DOWN)
    target:delStatusEffect(xi.effect.MAGIC_ATK_DOWN)

    skill:setMsg(xi.msg.basic.SKILL_ERASE)
    return 0
end

return mobskill_object
