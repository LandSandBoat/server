-----------------------------------
-- Spider Web
-- Entangles all targets in an area of effect.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effectparams =
    {
        effectId = xi.effect.SLOW,
        power    = 3000,
        duration = 90,
        tier     = 8, -- https://wiki.ffo.jp/html/4125.html
    }

    xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectparams, true)

    return xi.effect.SLOW
end

return mobskillObject
