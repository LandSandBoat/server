-----------------------------------
-- ID: 17706
-- Item: Vulcan Blade
-- Item Effect: Enfire
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENFIRE, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VULCAN_BLADE) ~= nil then
        target:delStatusEffect(xi.effect.ENFIRE, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.VULCAN_BLADE)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.VULCAN_BLADE) then
        local effect = xi.effect.ENFIRE
        local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
        local potency = 0

        if magicskill <= 200 then
            potency = 3 + math.floor(6 * magicskill / 100)
        elseif magicskill > 200 then
            potency = 5 + math.floor(5 * magicskill / 100)
        end

        potency = utils.clamp(potency, 3, 25)

        target:addStatusEffect(effect, { power = potency, duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.VULCAN_BLADE })
    end
end

return itemObject
