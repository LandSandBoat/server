-----------------------------------
-- Item Utils (Used by Skill Books)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.item_utils = {}

xi.item_utils.skillBookCheck = function(target, skillID)
    local skill = skillID
    local mainCap = target:getMaxSkillLevel(target:getMainLvl(), target:getMainJob(), skill) or 0
    local subCap = target:getMaxSkillLevel(target:getSubLvl(), target:getSubJob(), skill) or 0
    local mainDif = (mainCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
    local subDif = (subCap*10)/10 - (target:getCharSkillLevel(skill)*10)/100
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

xi.item_utils.skillBookUse = function(target, skillID)
    target:trySkillUp(skillID, target:getMainLvl(), true, true)
end

xi.item_utils.pickItemRandom = function(target, itemgroup) -- selects an item from a weighted result table
    -- possible results
    local items = itemgroup

    -- sum weights
    local sum = 0
    for i = 1, #items do
        sum = sum + items[i][1]
    end

    -- pick the weighted result
    local item = 0
    local pick = math.random(sum)
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

xi.item_utils.removeShield = function(effect, target)
    if effect == xi.effect.PHYSICAL_SHIELD then
        target:delStatusEffect(xi.effect.MAGIC_SHIELD)
    else
        target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    end
end

xi.item_utils.addItemShield = function(target, power, duration, effect, special)
    if target:hasStatusEffect(effect) then
        local shield = target:getStatusEffect(effect)
        local activeshieldpower = shield:getPower()

        if activeshieldpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            xi.item_utils.removeShield(effect, target)
            target:addStatusEffect(effect, power, 0, duration, 0, special)
            target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
        end
    else
        xi.item_utils.removeShield(effect, target)
        target:addStatusEffect(effect, power, 0, duration, 0, special)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, effect)
    end
end

xi.item_utils.addItemEffect = function(target, effect, power, duration, subpower)
    if target:hasStatusEffect(effect) then
        local buff = target:getStatusEffect(effect)
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

xi.item_utils.addTwoItemEffects = function(target, effect1, effect2, power1, power2, duration)
    if target:hasStatusEffect(effect1) then
        local buff = target:getStatusEffect(effect1)
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
        local buff = target:getStatusEffect(effect2)
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
