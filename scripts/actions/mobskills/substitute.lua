-----------------------------------
-- Substitute
-- Escapes the active target from the zone
-- This ability is currently bugged on retail
-- Player testimonies state that the escape won't happen if you're solo, however, we see the mob trying to use the ability on solo players in captures
-- TODO: Verify cast time, animation that plays on the player, what happens if cast on a pet, what happens if cast on a trust
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(xi.msg.basic.NONE)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.ESCAPE, 0, 3)
end

return mobskillObject
