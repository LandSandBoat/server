-----------------------------------
-- Hysteric Assault
-- Family: Avatar (Siren)
-- Description: Delivers a fivefold attack. Additional Effect: HP Drain
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 5
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_5 -- TODO: Capture shadowBehavior
    params.canCrit        = true -- TODO: JPWiki states this can crit. Need captures of mobskill and blood pact.
    params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate (JPWiki says 5~10% at 0 TP to 50~% at 3000TP)

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
    end

    return info.damage
end

return mobskillObject
