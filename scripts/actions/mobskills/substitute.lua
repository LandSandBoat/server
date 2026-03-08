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

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.NONE)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.ESCAPE, duration = 3, origin = mob, icon = 0 })
end

return mobskillObject
