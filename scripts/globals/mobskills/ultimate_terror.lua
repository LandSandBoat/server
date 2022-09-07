---------------------------------------------
-- Ultimate Terror
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)  

    local drained = 0
    local threshold = 3/7

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.STR_DOWN, 10, 3, 60))
        drained = drained + 1
    end
    
    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.DEX_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.VIT_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.AGI_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.INT_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, xi.effect.MND_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    if math.random() < threshold then
        skill:setMsg(xi.mobskills.MobDrainAttribute(mob, target, xi.effect.CHR_DOWN, 10, 3, 60))
        drained = drained + 1
    end

    return drained
    
end

return mobskill_object
