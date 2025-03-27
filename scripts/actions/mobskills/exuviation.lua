-----------------------------------
-- Exuviation (Self-Heal + Debuff Removal)
-- Family: Wamoura
-- Type: Healing + Full Erase
-- Range: Self
-- Notes:
-- - All Wamoura now heal based on level.
-- - Tax'et uses a steeper curve post-99.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effectCount = 0

    -- Use the same debuff list as Taxet.lua for consistency
    local removables = {
        xi.effect.FLASH,
        xi.effect.BLINDNESS,
        xi.effect.PARALYSIS,
        xi.effect.POISON,
        xi.effect.DISEASE,
        xi.effect.PLAGUE,
        xi.effect.WEIGHT,
        xi.effect.BIND,
        xi.effect.BIO,
        xi.effect.DIA,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SILENCE,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,
        xi.effect.SLOW,
        xi.effect.ADDLE,
        xi.effect.HELIX,
        xi.effect.ACCURACY_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.INHIBIT_TP,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.MAGIC_EVASION_DOWN,
        xi.effect.MAGIC_DEF_DOWN,
        xi.effect.MAX_TP_DOWN,
        xi.effect.MAX_MP_DOWN,
    }

    for _, effect in ipairs(removables) do
        if mob:hasStatusEffect(effect) then
            mob:delStatusEffect(effect)
            effectCount = effectCount + 1
        end
    end

    if effectCount > 0 then
        local currentRemoved = mob:getLocalVar('debuffsRemoved')
        local totalRemoved   = mob:getLocalVar('totalDebuffsRemoved')

        mob:setLocalVar('debuffsRemoved', currentRemoved + effectCount)
        mob:setLocalVar('totalDebuffsRemoved', totalRemoved + effectCount)
    end

    local totalHealing = 0
    if effectCount > 0 then
        local level = mob:getMainLvl()
        local basePerDebuff = 0

        if level >= 100 then
            basePerDebuff = math.floor(25 + (level ^ 1.692))
        elseif level >= 50 then
            basePerDebuff = math.floor(25 + (level ^ 1.392))
        else
            basePerDebuff = math.floor(level * 1.15)
        end

        local multiplier = mob:getLocalVar('exuviationHealMultiplier')
        if multiplier == 0 then
            multiplier = 1
        end

        totalHealing = math.floor(basePerDebuff * effectCount * multiplier)
    end

    skill:setMsg(xi.msg.basic.SELF_HEAL)
    return xi.mobskills.mobHealMove(mob, totalHealing)
end

return mobskillObject
