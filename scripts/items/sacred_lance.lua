-----------------------------------
-- ID: 14988
-- Item: Sacred Lance
-- Enchantment: Enlight
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENLIGHT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_LANCE) ~= nil then
        target:delStatusEffect(xi.effect.ENLIGHT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_LANCE)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.SACRED_LANCE) then
        local effect = xi.effect.ENLIGHT
        local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
        local potency = 0

        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end

        potency = utils.clamp(potency, 3, 25)

        target:addStatusEffect(effect, potency, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_LANCE)
    end
end

return itemObject
