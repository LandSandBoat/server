-----------------------------------
-- Holy Water - Removes Curse, Zombie, and Doom.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

local statii =
{
    xi.effect.CURSE_I,
    xi.effect.CURSE_II, -- AKA "Zombie"
    xi.effect.BANE,
}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = 33 + target:getMod(xi.mod.ENHANCES_HOLYWATER)
    local lastEffect = 0

    for _, effect in pairs(statii) do
        lastEffect = effect
        if target:hasStatusEffect(xi.effect.DOOM) and power > math.random(1, 100) then
            target:delStatusEffect(xi.effect.DOOM)
            target:messageBasic(xi.msg.basic.NARROWLY_ESCAPE)
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
            return xi.effect.DOOM
        else
            skill:setMsg(xi.msg.basic.NO_EFFECT)
        end

        if target:hasStatusEffect(effect) then
            target:delStatusEffect(effect)
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
            return lastEffect
        else
            skill:setMsg(xi.msg.basic.NO_EFFECT)
        end
    end
end

return mobskillObject
