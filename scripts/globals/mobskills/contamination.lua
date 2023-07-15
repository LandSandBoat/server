-----------------------------------
-- Toxic Pick
-- Deals damage to a single target. Additional effect: Poison, Plague, Gravity effect on target
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local badEffects =
{
    xi.effect.SLEEP_I,
    xi.effect.POISON,
    xi.effect.PARALYSIS,
    xi.effect.BLINDNESS,
    xi.effect.SILENCE,
    xi.effect.PETRIFICATION,
    xi.effect.CURSE_I,
    xi.effect.STUN,
    xi.effect.BIND,
    xi.effect.WEIGHT,
    xi.effect.SLOW,
    xi.effect.SLEEP_II,
    xi.effect.PLAGUE,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
    xi.effect.DIA,
    xi.effect.BIO,
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,
    xi.effect.MAX_HP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,
    xi.effect.FLASH,
    xi.effect.DREAD_SPIKES,
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.REQUIEM,
    xi.effect.LULLABY,
    xi.effect.ELEGY,
    xi.effect.THRENODY,
}

local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local effects = mob:getStatusEffects()
    local count = 0
    local power = math.ceil(mob:getMainLvl() / 5)
    local poisonPower = 30

    for _, v in pairs (effects) do
        if count < 8 and v ~= nil then
            for y = 1, #badEffects do
                if mob:hasStatusEffect(badEffects[y]) then
                    if badEffects[y] == xi.effect.POISON then
                        target:addStatusEffect(badEffects[y], poisonPower, 0, 60)
                    else
                        target:addStatusEffect(badEffects[y], power, 0, 60)
                    end

                    mob:delStatusEffect(badEffects[y])
                end
            end
        end
    end

    skill:setMsg(xi.msg.basic.NONE)
end

return mobskillObject
