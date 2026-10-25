-----------------------------------
-- Ka-thwack
-- Family: Mimic (A.M.A.N. Trove)
-- Description: K.O.s everyone in range. A Reraise effect is used up instead, and the target takes magic damage.
-- Notes: Observed on retail: used about a second after the mimic is revealed, and wipes the party and its Trusts.
-- Goddess's Hymnus is its own effect, so it doesn't count as Reraise here, as the JP wiki and BG say.
-- Unresisted on retail, so it skips the death resistance checks other instant K.O. skills make.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if target:hasStatusEffect(xi.effect.RERAISE) then
        target:delStatusEffect(xi.effect.RERAISE)

        -- TODO: Capture needed. One retail sample did 4210 damage, so its scaling and element are unknown.
        -- It skips the damage pipeline on purpose until a capture shows what mitigates it.
        local damage = 4210
        target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ELEMENTAL)

        return damage
    end

    skill:setMsg(xi.msg.basic.SKILL_ENFEEB_IS)
    target:setHP(0)

    return xi.effect.KO
end

return mobskillObject
