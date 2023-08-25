-----------------------------------
-- ID: 13173
-- Item: Memento Muffler
-- Item Effect: VIT +7
-- Duration: 3 minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.VIT_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.MEMENTO_MUFFLER then
        target:delStatusEffect(xi.effect.VIT_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.MEMENTO_MUFFLER) then
        target:addStatusEffect(xi.effect.VIT_BOOST, 7, 0, 300, 0, 0, 0, xi.items.MEMENTO_MUFFLER)
    end
end

return itemObject
