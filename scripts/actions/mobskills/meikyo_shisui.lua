-----------------------------------
-- Meikyo Shisui
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    xi.mobskills.mobBuffMove(mob, xi.effect.MEIKYO_SHISUI, 1, 0, 30)

    skill:setMsg(xi.msg.basic.USES)

    mob:addTP(3000)

    -- Some Notorious Monsters use more than 3 TP moves under the effects of Meikyo Shisui (Jailer of Temperance)
    local skillsAllowed = 3

    -- Checks the mobs local variable to see if there is a skill count override
    local skillOverride = mob:getLocalVar('[MeikyoShisui]SkillCount')
    if skillOverride > 0 then
        skillsAllowed = skillOverride
    end

    -- Sets the number of mob skills allowed under the effect of Meikyo Shisui, defaulting to 3 unless overridden
    mob:setLocalVar('[MeikyoShisui]MobSkillCount', skillsAllowed)

    return xi.effect.MEIKYO_SHISUI
end

return mobskillObject
