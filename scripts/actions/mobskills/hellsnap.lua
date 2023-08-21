-----------------------------------
-- Hellsnap
-- Stuns targets in an area of effect.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1839 then
            return 0
        else
            return 1
        end
    end

    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1840 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    return xi.effect.STUN
end

return mobskillObject
