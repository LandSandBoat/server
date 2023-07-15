-----------------------------------
-- Mind Wall
--
-- Description: Activates a shield to absorb all incoming magical damage.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

local magicType =
{
    xi.mod.FIRE_ABSORB,
    xi.mod.ICE_ABSORB,
    xi.mod.WIND_ABSORB,
    xi.mod.EARTH_ABSORB,
    xi.mod.LTNG_ABSORB,
    xi.mod.WATER_ABSORB,
    xi.mod.LIGHT_ABSORB,
    xi.mod.DARK_ABSORB,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 3 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Temporary fix until MAGIC_ABSORB mod works
    for i = 1, 8 do
        mob:setMod(magicType[i], 1000)
    end
    mob:timer(1000 * math.random(28, 32), function(mobArg)
        for i = 1, 8 do
            mobArg:delMod(magicType[i], 1000)
        end
    end)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
