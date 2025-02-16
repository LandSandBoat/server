-----------------------------------
--  Final Sting
--  Description: Deals damage proportional to HP. Reduces HP to 1 after use. Damage varies with TP.
--  Type: Physical (Slashing)
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local param = skill:getParam()
    if param == 0 then
        param = 50
    end

    if mob:getHPP() <= param then
        return 0
    end

    return 1
end

-- TODO: this is totally wrong, see https://docs.google.com/spreadsheets/d/1YBoveP-weMdidrirY-vPDzHyxbEI2ryECINlfCnFkLI/
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local ftp    = 1

    local hpMod = skill:getMobHPP() / 100
    ftp = ftp + hpMod * 14 + math.random(2, 6)

    if mob:isMobType(xi.mobType.NOTORIOUS) then
        ftp = ftp * 5
    end

    mob:setHP(0)

    if mob:isDead() then
        mob:setAnimationSub(1) -- Don't die twice
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, ftp, xi.mobskills.physicalTpBonus.NO_EFFECT, 0, 0, 0)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
