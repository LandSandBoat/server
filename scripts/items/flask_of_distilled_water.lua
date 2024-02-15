-----------------------------------
-- ID: 4509
-- Item: Flask of distilled water
-- Item Effect: While Sha Wujing's Lance +1 is equipped:
--   5m 1HP/tick Regen effect. Lance does not need to remain equipped after use.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if
        target:getMod(xi.mod.DRINK_DISTILLED) == 1 and
        not target:hasStatusEffect(xi.effect.REGEN)
    then
        target:addStatusEffect(xi.effect.REGEN, 1, 3, 300)
    else
        -- Retail will consume the item while doing nothing but telling you there was no effect.
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
