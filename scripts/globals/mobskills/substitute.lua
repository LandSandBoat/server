-----------------------------------
-- Substitute
-- Dummy ability used for 2hr animation by Jailer of Love.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

local resistances =
{
    xi.mod.SLASH_SDT,
    xi.mod.PIERCE_SDT,
    xi.mod.IMPACT_SDT,
    xi.mod.HTH_SDT,
}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local oldAnim = mob:getAnimationSub()
    local newAnim = oldAnim

    while newAnim == oldAnim do
        newAnim = math.random(1,3)
    end

    mob:setAnimationSub(newAnim)

    for i = 1, 4 do
        if i == newAnim then
            mob:setMod(resistances[i], 1000)
        else
            mob:setMod(resistances[i], -2500)
        end
    end

    if newAnim == 3 then
        mob:setMod(resistances[4], 1000)
    else
        mob:setMod(resistances[4], -2500)
    end

    skill:setMsg(xi.msg.basic.NONE)
    return 0
end

return mobskill_object
