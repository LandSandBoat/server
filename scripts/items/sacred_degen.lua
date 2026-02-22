-----------------------------------
-- ID: 17683
-- Item: Sacred Degen
-- Enchantment: Enlight
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENLIGHT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_DEGEN) ~= nil then
        target:delStatusEffect(xi.effect.ENLIGHT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_DEGEN)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.SACRED_DEGEN) then
        local effect = xi.effect.ENLIGHT
        local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
        local potency = 0

        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end

        potency = utils.clamp(potency, 3, 25)

        target:addStatusEffect(effect, { power = potency, duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.SACRED_DEGEN })
    end
end

return itemObject
