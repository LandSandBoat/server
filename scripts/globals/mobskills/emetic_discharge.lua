-----------------------------------
-- Emetic Discharge
-- Family: Bloodlapper and Brummbar
-- Description: Transfers all ailments to target
-- Type: Enfeebling
-- Utsusemi/Blink absorb: 2-3 shadows
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local removables = { xi.effect.FLASH, xi.effect.BLINDNESS, xi.effect.ELEGY, xi.effect.REQUIEM, xi.effect.PARALYSIS, xi.effect.POISON,
                        xi.effect.CURSE_I, xi.effect.CURSE_II, xi.effect.DISEASE, xi.effect.PLAGUE, xi.effect.WEIGHT, xi.effect.BIND,
                        xi.effect.BIO, xi.effect.DIA, xi.effect.BURN, xi.effect.FROST, xi.effect.CHOKE, xi.effect.RASP, xi.effect.SHOCK, xi.effect.DROWN,
                        xi.effect.STR_DOWN, xi.effect.DEX_DOWN, xi.effect.VIT_DOWN, xi.effect.AGI_DOWN, xi.effect.INT_DOWN, xi.effect.MND_DOWN,
                        xi.effect.CHR_DOWN, xi.effect.ADDLE, xi.effect.SLOW, xi.effect.HELIX, xi.effect.ACCURACY_DOWN, xi.effect.ATTACK_DOWN,
                        xi.effect.EVASION_DOWN, xi.effect.DEFENSE_DOWN, xi.effect.MAGIC_ACC_DOWN, xi.effect.MAGIC_ATK_DOWN, xi.effect.MAGIC_EVASION_DOWN,
                        xi.effect.MAGIC_DEF_DOWN, xi.effect.MAX_TP_DOWN, xi.effect.MAX_MP_DOWN, xi.effect.MAX_HP_DOWN }

    local dmg = utils.takeShadows(target, 1, math.random(2, 3)) --removes 2-3 shadows
    --if removed more shadows than were up or there weren't any
    if dmg > 0 then
        for i, effect in ipairs(removables) do
            if mob:hasStatusEffect(effect) then
                local statusEffect = mob:getStatusEffect(effect)
                target:addStatusEffect(effect, statusEffect:getPower(), statusEffect:getTickCount(), statusEffect:getDuration())
                mob:delStatusEffect(effect)
            end
        end
    end

    skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    return 0
end

return mobskillObject
