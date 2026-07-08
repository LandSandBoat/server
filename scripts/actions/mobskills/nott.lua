-----------------------------------
-- Nott
-- Family: Humanoid Club Weaponskill
-- Description: Restores HP and MP. Amount restored varies with TP.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    mob:messageBasic(xi.msg.basic.READIES_SKILL, 0, xi.mobSkill.NOTT)

    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    action:setCategory(xi.action.category.WEAPONSKILL_FINISH)

    local hpPercent = xi.combat.physical.calculateTPfactor(skill:getTP(), { 22, 33, 52 })
    local mpPercent = xi.combat.physical.calculateTPfactor(skill:getTP(), { 15, 22, 35 })
    local hp        = math.floor(mob:getMaxHP() * hpPercent / 100)
    local mp        = math.floor(mob:getMaxMP() * mpPercent / 100)

    mob:addHP(hp)
    mob:addMP(mp)
    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_HP)

    return hp
end

return mobskillObject
