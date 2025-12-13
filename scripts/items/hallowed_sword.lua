-----------------------------------
-- ID: 16550
-- Item: Hallowed Sword
-- Item Effect: Enlight
-----------------------------------
---@type TItem

local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffectBySource(xi.effect.ENLIGHT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HALLOWED_SWORD) ~= nil then
        target:delStatusEffect(xi.effect.ENLIGHT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HALLOWED_SWORD)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.HALLOWED_SWORD) then
        target:addStatusEffect(xi.effect.ENLIGHT, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HALLOWED_SWORD)
    end
end

itemObject.onEffectGain = function(target, effect)
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)
    effect:addMod(xi.mod.ENSPELL, xi.element.LIGHT)
    effect:addMod(xi.mod.ENSPELL_DMG, potency)
    effect:addMod(xi.mod.ENSPELL_CHANCE, 100)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
