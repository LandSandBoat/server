-----------------------------------
-- Nosferatu's Kiss
-- Family: Vampyr
-- Deals Dark damage to all targets in an area around the user. Additional effect: HP, MP and TP drain.
-- Note: Foe level * 0.5~1 for HP/TP. MP unknown.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl()
    params.fTP            = { 1.00, 1.00, 1.00 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.NONE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    -- TODO: MP/TP Drain should not break stoneskin. May need to rework how drain skills are handled when multiple drians types are done at same time.

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Considerations for capturing:
        -- 1. MP/TP Drains from magic mobskills typically are not affected by Shell/Resists/MDB.
        -- 2. HP Drains are typically affected by shell but not MDB.
        -- 3. Taking note of the previous points, test and compare the HP Drain and the resulting MP/TP Drains with/without Shell.
        -- If these are calculated seperatly, we may need to split drain skills into their own functions with their own parameters.

        -- Capture shows the following effects on a level 99 player from a level 85 mob:
        -- 108 HP drained
        -- 60 TP drained
        -- 25 MP drained

        local drainedHP = math.random(info.damage / 2, info.damage)
        local drainedMP = math.random(info.damage / 3, info.damage / 2)
        local drainedTP = math.random(info.damage / 2, info.damage)

        -- TODO: Capture power for effects. Current numbers roughly based off video capture.
        skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, drainedHP))
        xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.MP, drainedMP)
        xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.TP, drainedTP)
    end

    return info.damage
end

return mobskillObject
