-----------------------------------
-- Yztarg Skill Attack 01
-- Family: Yztarg
-- Description: Yztarg swipes target with its right arm.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING -- TODO: Capture damageType
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: Capture shadowBehavior
    params.primaryMessage = xi.msg.basic.HIT_DMG

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: JPWiki states this inflicts TP Down (Reduces current TP of target hit rather than a full reset or Max TP Down).

        -- Capture from Ophiotaurus:
        -- Player(Primary Target): 2373 TP -> Skillattack lands and granted 21 TP(Total now 2394) -> TP gets reduced to 1197 (50%)
        -- Trust Valaineral(Secondary Target): 776 TP -> Skillattack lands but grants 0 TP due to being a secondary target -> TP gets reduced to 396.
    end

    return info.damage
end

return mobskillObject
