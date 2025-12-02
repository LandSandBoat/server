-----------------------------------
-- Microspores
-- Family: Funguar
-- Description: Transfers a single negative ailment from the user to its' target.
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
-- Range: 14.7 - TODO: Capture Exact Range - Range set based off of other Funguar abilities
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numEffectsTransferred = 0
    local availableEffects = {}

    local removables =
    {
        -- Songs
        xi.effect.ELEGY,
        xi.effect.REQUIEM,
        xi.effect.THRENODY,

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
        xi.effect.MAX_HP_DOWN
    }

    -- Check which effects the mob actually has from our list
    for _, effectId in ipairs(removables) do
        if mob:hasStatusEffect(effectId) then
            table.insert(availableEffects, effectId)
        end
    end

    -- Transfer only 1 random effect
    if #availableEffects > 0 then
        -- Shuffle and pick the first one
        availableEffects = utils.shuffle(availableEffects)
        local effectId = availableEffects[1]
        local effect = target:getStatusEffect(effectId)

        if effect and target:delStatusEffect(effectId) then
            target:addStatusEffect(
                effectId,
                effect:getPower(),
                effect:getTick(),
                math.ceil(effect:getTimeRemaining() / 1000), -- Gets the remaining time and converts milliseconds to seconds
                effect:getSubType(),
                effect:getSubPower(),
                effect:getTier()
            )
            numEffectsTransferred = 1
        end
    end

    skill:setMsg(xi.msg.basic.NONE)

    return numEffectsTransferred
end

return mobskillObject
