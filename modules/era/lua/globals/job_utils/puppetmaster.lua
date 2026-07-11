-----------------------------------
-- Module: Puppetmaster Job Adjustments
-----------------------------------
require('modules/module_utils')
-----------------------------------
local moduleName = 'era_job_utils_puppetmaster'

local m = Module:new(moduleName)

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

-- Overdrive: Revert duration from 180 to 60 seconds : https://wiki.ffo.jp/html/954.html
m:addOverride('xi.job_utils.puppetmaster.onAbilityUseOverdrive', function(player, target, ability, action)
    local pet = player:getPet()

    player:addStatusEffect(xi.effect.OVERDRIVE, { duration = 60 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = player })

    if pet then
        pet:addStatusEffect(xi.effect.OVERDRIVE, { duration = 60 + player:getMod(xi.mod.OVERDRIVE_BONUS_DURATION), origin = pet })
        action:ID(player:getID(), pet:getID())
    end

    return xi.effect.OVERDRIVE
end)

-- Repair: Revert recast to a flat 180 seconds : https://wiki.ffo.jp/html/954.html
m:addOverride('xi.job_utils.puppetmaster.onAbilityCheckRepair', function(player, target, ability)
    local msg, param = super(player, target, ability)

    if msg == 0 then
        ability:setRecast(180)
    end

    return msg, param
end)

local removableEffects =
{
    -- Songs
    xi.effect.ELEGY,
    xi.effect.REQUIEM,
    xi.effect.THRENODY,

    -- Enfeebling
    xi.effect.BLINDNESS,
    xi.effect.PARALYSIS,
    xi.effect.SILENCE,
    xi.effect.CURSE_I,
    xi.effect.CURSE_II,
    xi.effect.DISEASE,
    xi.effect.PLAGUE,
    xi.effect.WEIGHT,
    xi.effect.BIND,
    xi.effect.ADDLE,
    xi.effect.SLOW,
    xi.effect.PETRIFICATION,

    -- DoTs
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.POISON,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,

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

local function removeStatusEffects(pet, amountToRemove)
    local effectsRemoved = 0

    for _, effectId in ipairs(removableEffects) do
        if effectsRemoved >= amountToRemove then
            break
        end

        if pet:delStatusEffect(effectId) then
            effectsRemoved = effectsRemoved + 1
        end
    end

    return effectsRemoved
end

-- Repair: Remove the initial burst heal, leaving only the Regen and status removal effects
m:addOverride('xi.job_utils.puppetmaster.onAbilityUseRepair', function(player, target, ability, action)
    local pet = player:getPet()
    if not pet then
        return
    end

    -- Self-cast ability but reports on pet
    action:ID(player:getID(), pet:getID())

    local oilEquipped = xi.job_utils.puppetmaster.oilData[player:getEquipID(xi.slot.AMMO)]
    local regenAmount = oilEquipped.regen
    local regenTime   = oilEquipped.duration

    removeStatusEffects(pet, player:getMod(xi.mod.REPAIR_EFFECT))

    local bonus = 1 + player:getMerit(xi.merit.REPAIR_EFFECT) / 100 + player:getMod(xi.mod.REPAIR_POTENCY) / 100
    regenAmount = regenAmount * bonus

    pet:wakeUp()

    pet:delStatusEffect(xi.effect.REGEN)
    pet:addStatusEffect(xi.effect.REGEN, { power = regenAmount, duration = regenTime, origin = player, tick = 3 }) -- 3 = tick, each 3 seconds.
    player:removeAmmo(1)

    ability:setMsg(xi.msg.basic.USES_JA)
end)

return m
