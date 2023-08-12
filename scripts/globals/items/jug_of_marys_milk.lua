-----------------------------------
-- ID: 4527
-- Item: Jug of marys milk
-- Item Effect: This potion induces sleep.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if
        not target:hasStatusEffect(xi.effect.SLEEP_I) and
        not target:hasStatusEffect(xi.effect.SLEEP_II) and
        not target:hasStatusEffect(xi.effect.LULLABY)
    then
        target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, 60)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
