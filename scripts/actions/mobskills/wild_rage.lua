-----------------------------------
--  Wild Rage
--
--  Description: Deals physical damage to enemies within area of effect.
--  Type: Physical
--  Utsusemi/Blink absorb: 2-3 shadows
--  Range: 15' radial
--  Notes: Has additional effect of Poison when used by King Vinegarroon.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

local platoonScorpionPoolID  = 3157
local wildRageDamageIncrease = 0.10

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 2.1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    if mob:getPool() == platoonScorpionPoolID then
        -- should not have to verify because platoon scorps only in battlefield
        local numScorpsDead = mob:getBattlefield():getLocalVar('[ODS]NumScorpsDead')

        -- Increase the strength of Wild Rage as scorps in the BC die
        -- https://ffxiclopedia.fandom.com/wiki/Operation_Desert_Swarm
        info.dmg = info.dmg * (1 + wildRageDamageIncrease * numScorpsDead)
    end

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    -- king vinegrroon
    if mob:getPool() == 2262 then
        xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.POISON, 25, 3, 60)
    end

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
