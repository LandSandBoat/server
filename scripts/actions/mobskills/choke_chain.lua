-----------------------------------
-- Choke Chain
-- Family: Ramparts
-- Description: Inflicts Amnesia, Bind, Silence to a single target.
-- Notes: Only used by Ramparts when its door is closed.
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- TODO: JPWiki states messaging priority is Amnesia > Silence > Bind.
    -- If this is true, we need a way to have a fall back to the next effect for skills that apply multiple effects.

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 60)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60)) -- TODO: Capture power

    return xi.effect.AMNESIA
end

return mobskillObject
