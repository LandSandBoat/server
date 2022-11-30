-----------------------------------
-- Ability: Repair
-- Uses oil to restore pet's HP.
-- Obtained: Puppetmaster Level 15
-- Recast Time: 3:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
local abilityObject = {}

local removableEffectIds =
{
    xi.effect.PETRIFICATION,
    xi.effect.SILENCE,
    xi.effect.BANE,
    xi.effect.CURSE_II,
    xi.effect.CURSE_I,
    xi.effect.PARALYSIS,
    xi.effect.PLAGUE,
    xi.effect.POISON,
    xi.effect.DISEASE,
    xi.effect.BLINDNESS,
}

local oilType =
{
--  ItemId                               { Base, %HP, Time(s) }
    [xi.items.CAN_OF_AUTOMATON_OIL   ] = { 10, 0.1,  30 },
    [xi.items.CAN_OF_AUTOMATON_OIL_P1] = { 20, 0.2,  60 },
    [xi.items.CAN_OF_AUTOMATON_OIL_P2] = { 30, 0.3,  90 },
    [xi.items.CAN_OF_AUTOMATON_OIL_P3] = { 40, 0.4, 120 },
}

local function removeStatus(pet)
    for _, effectId in ipairs(removableEffectIds) do
        if pet:delStatusEffect(effectId) then
            return true
        end
    end

    if pet:eraseStatusEffect() ~= xi.effect.NONE then
        return true
    end

    return false
end

abilityObject.onAbilityCheck = function(player, target, ability)
    if not player:getPet() then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif
        not player:getPetID() or
        not (player:getPetID() >= 69 and player:getPetID() <= 72)
    then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        local id = player:getEquipID(xi.slot.AMMO)

        if oilType[id] then
            return 0, 0
        else
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        end
    end
end

abilityObject.onUseAbility = function(player, target, ability)
    local pet                 = player:getPet()
    local petCurrentHP        = pet:getHP()
    local petMaxHP            = pet:getMaxHP()
    local numRemovableEffects = player:getMod(xi.mod.REPAIR_EFFECT)

    -- Need to start to calculate the HP to restore to the pet.
    -- Ref: http://ffxiclopedia.wikia.com/wiki/Repair
    local oilData      = oilType[player:getEquipID(xi.slot.AMMO)]
    local regenAmount  = oilData[1]
    local totalHealing = oilData[2]
    local regenTime    = oilData[3]

    for _ = 1, numRemovableEffects do
        if not removeStatus(pet) then
            break
        end
    end

    local bonus  = 1 + player:getMerit(xi.merit.REPAIR_EFFECT) / 100
    totalHealing = totalHealing * bonus

    bonus       = bonus + player:getMod(xi.mod.REPAIR_POTENCY) / 100
    regenAmount = regenAmount * bonus

    -- TODO: This needs verification
    totalHealing = math.min(totalHealing, petMaxHP - petCurrentHP)

    pet:addHP(totalHealing)
    pet:wakeUp()

    pet:delStatusEffect(xi.effect.REGEN)
    pet:addStatusEffect(xi.effect.REGEN, regenAmount, 3, regenTime) -- 3 = tick, each 3 seconds.
    player:removeAmmo()

    return totalHealing
end

return abilityObject
