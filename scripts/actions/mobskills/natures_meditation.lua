-----------------------------------
-- Nat. Meditation (Mob)
-- Gains an undispellable attack bonus that decays over time.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 30
    local attack = mob:getStat(xi.mod.ATT)
    local attBoost = attack * 0.3

    if not mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, attBoost, 0, duration)) -- Apply attack boost
        xi.mobskills.mobBuffMove(mob, xi.effect.ATTACK_BOOST, attBoost, 0, duration)
    end

    return xi.effect.ATTACK_BOOST
end

return mobskillObject
