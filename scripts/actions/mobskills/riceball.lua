-----------------------------------
-- Riceball
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    mob:addMod(xi.mod.ATT, 50)
    mob:addMod(xi.mod.DEF, 30)
    mob:addMod(xi.mod.DEX, 4)
    mob:addMod(xi.mod.VIT, 4)
    mob:addMod(xi.mod.CHR, 4)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 5)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
