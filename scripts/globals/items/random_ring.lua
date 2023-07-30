-----------------------------------
-- ID: 15770
-- Item: Random Ring
-- Item Effect: DEX + 1~8
-- Duration: 30 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.RANDOM_RING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.RANDOM_RING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.RANDOM_RING) then

        if target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.RANDOM_RING) then
            local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
            if effect then
                local power = math.random(1, 8)

                target:addMod(xi.mod.DEX, power)
                effect:addMod(xi.mod.DEX, power)
            end
        end
    end
end

itemObject.onEffectGain = function(target, effect)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
