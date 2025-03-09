-----------------------------------
-- Absorbing Kiss
-- Steal one effect
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numAttriDrained = 1

    if mob:getPool() == 3116 then -- BCNM20 Charming Trio: Pepper does all attribute drain
        numAttriDrained = 7

        for i = xi.effect.STR_DOWN, xi.effect.CHR_DOWN do
            xi.mobskills.mobDrainAttribute(mob, target, i, 8, 3, 120) -- Can drain up to -8 per stat
            skill:setMsg(xi.msg.basic.ATTR_DRAINED) -- Message for multiple attibutes drainged
        end

        return numAttriDrained
    end

    -- str down - chr down
    local effectType = math.random(xi.effect.STR_DOWN, xi.effect.CHR_DOWN)

    skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, effectType, 10, 3, 120))

    return numAttriDrained
end

return mobskillObject
