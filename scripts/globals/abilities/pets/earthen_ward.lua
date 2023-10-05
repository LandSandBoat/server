-----------------------------------
-- Earthen Ward
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

abilityObject.onPetAbility = function(target, pet, skill)
    local amount = pet:getMainLvl() * 2 + 50

    -- if current stoneskin is from Earthen Ward then overwrite
    -- need this logic here because Earthern Ward SS overwrites itself
    -- while normal spell-based SS does not overwrite itself
    local earthenWardTier = 3
    if target:hasStatusEffect(xi.effect.STONESKIN) then
        local status = target:getStatusEffect(xi.effect.STONESKIN)
        if status:getTier() == earthenWardTier then
            target:delStatusEffectSilent(xi.effect.STONESKIN)
        end
    end

    if target:addStatusEffect(xi.effect.STONESKIN, amount, 0, 900, 0, 0, earthenWardTier) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end

return abilityObject
