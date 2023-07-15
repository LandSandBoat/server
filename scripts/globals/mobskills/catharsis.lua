-----------------------------------
-- Catharsis
-- Description: Restores HP.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/zone")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    -- TODO: Make separate mob skill list for CoP Hecteyes
    if
        target:getCurrentRegion() == xi.region.TAVNAZIANARCH or
        mob:getPool() == 3693 -- Sobbing Eyes
    then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Formula is Max HP * 32/256
    local potency = 1 / 8

    skill:setMsg(xi.msg.basic.SELF_HEAL)

    return xi.mobskills.mobHealMove(mob, mob:getMaxHP() * potency)
end

return mobskillObject
