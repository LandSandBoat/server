-----------------------------------
--  Tourbillion
--
--  Description: Delivers an area attack. Additional effect duration varies with TP. Additional effect: Weakens defense.
--  Type: Physical
--  Shadow per hit
--  Range: Unknown range
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 316 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1805 then
            return 0
        else
            return 1
        end
    end

    --[[ TODO: Khimaira should only use this when its wings are up, which is animationsub() == 0.
    There's no system to put them "down" yet, so it's not really fair to leave it active.
    Tyger's fair game, though. :) ]]
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local ftp    = 1.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    local duration = 20 * (skill:getTP() / 1000)

    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.DEFENSE_DOWN, 20, 0, duration)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
