-----------------------------------
-- Benediction
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local removables = { xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.MAX_HP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.PARALYSIS, xi.effect.POISON,
                        xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
                        xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
                        xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
                        xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
                        xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
                        xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.SILENCE }

    for _, effect in ipairs(removables) do
        if (target:hasStatusEffect(effect)) then
            target:delStatusEffect(effect)
        end
    end

    local maxHeal = target:getMaxHP() - target:getHP()
    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        maxHeal = 0
    end
    target:addHP(maxHeal)
    target:wakeUp()
    skill:setMsg(xi.msg.basic.SELF_HEAL)

    if mob:hasStatusEffect(xi.effect.HYSTERIA) then
        skill:setMsg(xi.msg.basic.NONE)
        mob:delStatusEffect(xi.effect.HYSTERIA)
    end

    return maxHeal
end

return mobskillObject
