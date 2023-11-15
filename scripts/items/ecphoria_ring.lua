-----------------------------------
-- ID: 15817
-- Item: Ecphoria Ring
-- Item Effect: This item remedies amnesia.
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local statusEffect = xi.effect.AMNESIA
    if target:hasStatusEffect(statusEffect) then
        local effectSubPower = target:getStatusEffect(statusEffect):getSubPower()
        -- If the amnesia is too strong, do not remove it. By default this would be zero allowing removal.
        -- (Ladybugs, Rafflesia, Promathia, certain NMs, low chance vs Disorienting Waul)
        if effectSubPower < math.random(1, 100) then
            target:delStatusEffect(statusEffect)
        end
    end
end

return itemObject
