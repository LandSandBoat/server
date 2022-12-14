-----------------------------------
-- Berserk
-- Berserk Ability.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = (116 / 256) * 100

    -- Dolls Berserk is Warcry
    -- TODO: Separate file
    if
        mob:getFamily() == 83 or
        mob:getFamily() == 84 or
        mob:getFamily() == 85 or
        mob:getFamily() == 498
    then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.WARCRY, 33, 0, 120))

        return xi.effect.WARCRY
    end

    skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BERSERK, power, 0, math.random(120, 180)))
    return xi.effect.BERSERK
end

return mobskillObject
