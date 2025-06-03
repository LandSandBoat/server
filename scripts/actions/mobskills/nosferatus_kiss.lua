-----------------------------------
-- Nosferatu's Kiss
-- Deals damage to all targets in an area around the user. Additional effect: HP, MP and TP drain.
-- Type: Magical
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: AoE
-- Note: Foe level * 0.5~1 for HP/TP. MP unknown.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- Capture shows the following effects on a level 99 player from a level 85 mob:
    -- 108 HP drained
    -- 60 TP drained
    -- 25 MP drained
    local drainedHp = math.random(mob:getMainLvl() / 2, mob:getMainLvl())
    local drainedTp = math.random(mob:getMainLvl() / 2, mob:getMainLvl())
    -- TODO: This needs more captures
    local drainedMp = math.random(mob:getMainLvl() / 3, mob:getMainLvl() / 2)

    drainedHp = xi.mobskills.mobFinalAdjustments(drainedHp, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.HP, drainedHp)
    xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.MP, drainedMp)
    xi.mobskills.mobPhysicalDrainMove(mob, target, skill, xi.mobskills.drainType.TP, drainedTp)
    skill:setMsg(xi.msg.basic.SKILL_DRAIN_HP)

    return drainedHp
end

return mobskillObject
