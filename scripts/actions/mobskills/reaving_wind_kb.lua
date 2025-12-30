-----------------------------------
--  Reaving Wing (Aura Knockback)
--  Description: Does no damage, knockback only.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Notes: Zirnitra uses multiple times while aura is active.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobWeaponSkill = function(target, mob, skill, action)
    skill:setMsg(xi.msg.basic.NONE)

    -- > 24% movement speed reduction in gear negates knockback
    if target:getMod(xi.mod.MOVE_SPEED_STACKABLE) < -10 then
        action:knockback(target:getID(), xi.action.knockback.NONE)
    end
end

return mobskillObject
