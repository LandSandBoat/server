-----------------------------------
-- ??? Needles
-- Family: Cactuar
-- Description: Shoots multiple needles at enemies within range.
-- Notes: The Amigo Sabotender's special ability 1000 Needles has been renamed ??? Needles.
--        https://forum.square-enix.com/ffxi/threads/46068-Feb-19-2015-(JST)-Version-Update
--        from http://ffxiclopedia.wikia.com/wiki/%3F%3F%3F_Needles
--        "Seen totals ranging from 15, 000 to 55, 000 needles."
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage         = math.random(1000, 10000) / skill:getTotalTargets()
    params.numHits            = 1
    params.fTP                = { 1.0, 1.0, 1.0 }
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.PIERCING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
    params.guaranteedFirstHit = true
    params.skipPDIF           = true

    if mob:getID() == zones[xi.zone.ABYSSEA_ALTEPA].mob.CUIJATENDER then
        params.baseDamage = math.random(15000, 55000) / skill:getTotalTargets()
    end

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)
    end

    return info.damage
end

return mobskillObject
