-----------------------------------
-- Dissolve
-- Description:
-- Only used by Blobdingnag, Morbid Molasses, and Fistule.
-- The enmity of the NM's target when this move is used will be erased a few seconds after the move is executed.
-- Peripheral targets that are hit by this attack will not have their enmity reset.
-----------------------------------

local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if target:isMob() then
        for _, targ in pairs(target:getEnmityList()) do
            mob:addEnmity(targ.entity, targ.ce, targ.ve)
            if targ.entity:isPC() then
                mob:updateClaim(targ.entity)
                target:resetEnmity(targ.entity)
            end
        end
    end

    return 0
end

return mobskillObject
