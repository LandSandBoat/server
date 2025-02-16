-----------------------------------
-- Mix: Panacea-1 - Removes anything a Panacea can remove.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

local statii =
{
    xi.effect.PARALYSIS,
    xi.effect.BIND,
    xi.effect.WEIGHT,
    xi.effect.ADDLE,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,
    xi.effect.DIA,
    xi.effect.BIO,
    xi.effect.SLOW,
    xi.effect.ELEGY,
    xi.effect.REQUIEM,
    xi.effect.HELIX,
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,
    xi.effect.MAX_HP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,
    xi.effect.MAGIC_DEF_DOWN,
    xi.effect.INHIBIT_TP,
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
}

-- TODO: verify messaging
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local lastEffect = 0
    for _, effect in pairs(statii) do
        if target:delStatusEffect(effect) then
            lastEffect = effect
        end
    end

    skill:setMsg(xi.msg.basic.SKILL_ERASE)
    return lastEffect
end

return mobskillObject
