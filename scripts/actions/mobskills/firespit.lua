-----------------------------------
--  Firespit
--  Description: Deals fire damage to an enemy.
--  Type: Magical (Fire)
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getFamily() == 91 then
        local mobSkin = mob:getModelId()

        if mobSkin == 1639 then
            return 0
        else
            return 1
        end
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage  = mob:getWeaponDmg() * 4
    local numhits = math.random(2, 3)

    if
        mob:getMainJob() == xi.job.BLM or
        mob:getMainJob() == xi.job.WHM
    then
        numhits = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    end

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, numhits)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
