-----------------------------------
-- Diamondhide
--
-- Description: Gives the effect of "Stoneskin."
-- Type: Magical
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 600 -- Guesstimated, def not based on mobs lv+hp*tp like was previously in this script..
    skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.STONESKIN, power, 0, 300))
    return xi.effect.STONESKIN
end

return mobskillObject
