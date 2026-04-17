-----------------------------------
-- Pandemic Nip
-- Family: Gnat
-- Description: Single target damage and transfers up to five current enfeebles to target player.
-- Notes: Transfers debuffs to the target player (maximum 5). Includes Dancer's Quickstep's Evasion Down and Box Step's Defense Down.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    --[[local removables =
    {
        -- Songs
        xi.effect.ELEGY,
        xi.effect.REQUIEM,
        xi.effect.THRENODY,
        xi.effect.NOCTURNE,

        -- Enfeebling
        xi.effect.FLASH,
        xi.effect.BLINDNESS,
        xi.effect.PARALYSIS,
        xi.effect.POISON,
        xi.effect.CURSE_I,
        xi.effect.CURSE_II,
        xi.effect.DISEASE,
        xi.effect.PLAGUE,
        xi.effect.WEIGHT,
        xi.effect.BIND,
        xi.effect.ADDLE,
        xi.effect.SLOW,
        xi.effect.INUNDATION,

        -- DoTs
        xi.effect.BIO,
        xi.effect.DIA,
        xi.effect.BURN,
        xi.effect.FROST,
        xi.effect.CHOKE,
        xi.effect.RASP,
        xi.effect.SHOCK,
        xi.effect.DROWN,
        xi.effect.HELIX,
        -- TODO : Check if Kaustra should be included

        -- Main Stat Downs
        xi.effect.STR_DOWN,
        xi.effect.DEX_DOWN,
        xi.effect.VIT_DOWN,
        xi.effect.AGI_DOWN,
        xi.effect.INT_DOWN,
        xi.effect.MND_DOWN,
        xi.effect.CHR_DOWN,

        -- Combat Stat Downs
        xi.effect.ACCURACY_DOWN,
        xi.effect.ATTACK_DOWN,
        xi.effect.EVASION_DOWN,
        xi.effect.DEFENSE_DOWN,

        -- Magic Stat Downs
        xi.effect.MAGIC_ACC_DOWN,
        xi.effect.MAGIC_ATK_DOWN,
        xi.effect.MAGIC_EVASION_DOWN,
        xi.effect.MAGIC_DEF_DOWN,

        -- HP/MP/TP Stat Downs
        xi.effect.MAX_TP_DOWN,
        xi.effect.MAX_MP_DOWN,
        xi.effect.MAX_HP_DOWN,
        xi.effect.INHIBIT_TP,

        -- Dancer Debuffs
        xi.effect.WEAKENED_DAZE_1,
        xi.effect.WEAKENED_DAZE_2,
        xi.effect.WEAKENED_DAZE_3,
        xi.effect.WEAKENED_DAZE_4,
        xi.effect.WEAKENED_DAZE_5,
        xi.effect.SLUGGISH_DAZE_1,
        xi.effect.SLUGGISH_DAZE_2,
        xi.effect.SLUGGISH_DAZE_3,
        xi.effect.SLUGGISH_DAZE_4,
        xi.effect.SLUGGISH_DAZE_5,
        xi.effect.BEWILDERED_DAZE_1,
        xi.effect.BEWILDERED_DAZE_2,
        xi.effect.BEWILDERED_DAZE_3,
        xi.effect.BEWILDERED_DAZE_4,
        xi.effect.BEWILDERED_DAZE_5,
        xi.effect.LETHARGIC_DAZE_1,
        xi.effect.LETHARGIC_DAZE_2,
        xi.effect.LETHARGIC_DAZE_3,
        xi.effect.LETHARGIC_DAZE_4,
        xi.effect.LETHARGIC_DAZE_5,
    }]]

    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.numHits        = 1
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.SLASHING
    params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        -- TODO: Transfer debuff effects to target
        -- JPWiki says 5 effects, Jimmayus spreadsheet says 1 effect.
    end

    -- TODO: JPWiki says even if the attack is absorbed by shadows, then the debuffs on the mob are still cleared. Need captures

    return info.damage
end

return mobskillObject
