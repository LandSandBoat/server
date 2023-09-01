-----------------------------------
-- Item Utils (Used by Skill Books)
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.itemUtils = {}

xi.itemUtils.removableEffects =
{
    xi.effect.PARALYSIS,
    xi.effect.POISON,
    xi.effect.BLINDNESS,
    xi.effect.SILENCE,
    xi.effect.DISEASE,
    xi.effect.PETRIFICATION,
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
    xi.effect.MAGIC_ATK_DOWN
}

xi.itemUtils.foodOnItemCheck = function(target, foodType)
    local result     = 0
    local targetRace = target:getRace()
    local canEatFish = targetRace == xi.race.MITHRA or target:getMod(xi.mod.EAT_RAW_FISH) == 1
    local canEatMeat = targetRace == xi.race.GALKA or target:getMod(xi.mod.EAT_RAW_MEAT) == 1

    if
        (foodType == xi.foodType.RAW_FISH and not canEatFish) or
        (foodType == xi.foodType.RAW_MEAT and not canEatMeat)
    then
        result = xi.msg.basic.CANNOT_EAT
    end

    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

xi.itemUtils.itemBoxOnItemCheck = function(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = xi.msg.basic.ITEM_NO_USE_INVENTORY
    end

    return result
end

xi.itemUtils.skillBookCheck = function(target, skillID)
    local skill   = skillID
    local mainCap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill) or 0
    local subCap  = target:getMaxSkillLevel(target:getSubLvl(), target:getSubJob(), skill) or 0
    local mainDif = (mainCap * 10) / 10 - (target:getCharSkillLevel(skill) * 10) / 100
    local subDif  = (subCap * 10) / 10 - (target:getCharSkillLevel(skill) * 10) / 100
    local noSkill = 0

    if mainCap == 0 then
        noSkill = noSkill + 1
    end

    if subCap == 0 then
        noSkill = noSkill + 1
    end

    if noSkill >= 2 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if mainCap > 0 and mainDif <= 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if subCap > 0 and mainCap == 0 and subDif <= 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

xi.itemUtils.skillBookUse = function(target, skillID)
    target:trySkillUp(skillID, target:getMainLvl(), true, true)
end

xi.itemUtils.pickItemRandom = function(target, itemgroup) -- selects an item from a weighted result table
    -- possible results
    local items = itemgroup

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick the weighted result
    local item = 0
    local pick = math.random(1, sum)
    sum = 0

    for i = 1, #items do
        sum = sum + items[i][1]
        if sum >= pick then
            item = items[i][2]
            break
        end
    end

    return item
end

xi.itemUtils.removeShield = function(effect, target)
    if effect == xi.effect.PHYSICAL_SHIELD then
        target:delStatusEffect(xi.effect.MAGIC_SHIELD)
    else
        target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    end
end

xi.itemUtils.addItemShield = function(target, power, duration, effect, special)
    if target:hasStatusEffect(effect) then
        local shield            = target:getStatusEffect(effect)
        local activeshieldpower = shield:getPower()

        if activeshieldpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            xi.itemUtils.removeShield(effect, target)
            target:addStatusEffect(effect, power, 0, duration, 0, special)
            target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
        end
    else
        xi.itemUtils.removeShield(effect, target)
        target:addStatusEffect(effect, power, 0, duration, 0, special)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
    end
end

xi.itemUtils.addItemEffect = function(target, effect, power, duration, subpower)
    if target:hasStatusEffect(effect) then
        local buff        = target:getStatusEffect(effect)
        local effectpower = buff:getPower()

        if effectpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect, power, 0, duration, 0, subpower)
        end
    else
        target:addStatusEffect(effect, power, 0, duration, 0, subpower)
    end
end

xi.itemUtils.addTwoItemEffects = function(target, effect1, effect2, power1, power2, duration)
    if target:hasStatusEffect(effect1) then
        local buff        = target:getStatusEffect(effect1)
        local effectpower = buff:getPower()

        if effectpower > power1 then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect1, power1, 0, duration, 0, power1)
        end
    else
        target:addStatusEffect(effect1, power1, 0, duration, 0, power1)
    end

    if target:hasStatusEffect(effect2) then
        local buff        = target:getStatusEffect(effect2)
        local effectpower = buff:getPower()

        if effectpower > power2 then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(effect2, power2, 0, duration, 0, power2)
        end
    else
        target:addStatusEffect(effect2, power2, 0, duration, 0, power2)
    end
end

xi.itemUtils.addItemExpEffect = function(target, effect, power, duration, subpower)
    local deleffect = xi.effect.COMMITMENT

    if effect == deleffect then
        deleffect = xi.effect.DEDICATION
    end

    if target:hasStatusEffect(effect) then
        local buff        = target:getStatusEffect(effect)
        local effectpower = buff:getPower()

        if effectpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffectSilent(deleffect)
            target:addStatusEffect(effect, power, 0, duration, 0, subpower)
        end
    else
        target:delStatusEffectSilent(deleffect)
        target:addStatusEffect(effect, power, 0, duration, 0, subpower)
    end
end

xi.itemUtils.removeStatus = function(target, effects)
    for _, effect in ipairs(effects) do
        if target:delStatusEffect(effect) then
            return true
        end
    end

    if target:eraseStatusEffect() ~= 255 then
        return true
    end

    return false
end

xi.itemUtils.removeMultipleEffects = function(target, effects, count, random)
    local effectsToRemove = effects

    if random == 1 then -- randomize which effects get removed
        effectsToRemove = utils.shuffle(effects)
    end

    if count > 0 then
        local removed = 0

        for i = 0, count do
            if not xi.itemUtils.removeStatus(target, effectsToRemove) then
                break
            end

            removed = removed + 1

            if removed >= count then
                break
            end
        end

        return removed
    end
end
