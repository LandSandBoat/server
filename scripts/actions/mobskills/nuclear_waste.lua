-----------------------------------
--  Nuclear Waste
--  Description: Reduces elemental resistances by 50 to players in range.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:setLocalVar('nuclearWaste', 1)
    local resist = xi.mobskills.applyPlayerResistance(mob, xi.effect.ELEMENTALRES_DOWN, target, mob:getStat(xi.mod.INT) - target:getStat(xi.mod.INT), 0, 0)
    if resist >= 0.25 then
        target:addStatusEffectEx(xi.effect.ELEMENTALRES_DOWN, 0, 50, 0, 60)
        skill:setMsg(xi.msg.basic.NONE)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return xi.effect.ELEMENTALRES_DOWN
end

return mobskillObject
