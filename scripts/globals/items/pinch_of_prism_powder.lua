-----------------------------------
-- ID: 4164
-- Prism Powder
-- When applied, it makes things invisible.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local duration = math.random(130, 310)
    if target:hasStatusEffect(xi.effect.INVISIBLE) then
        target:delStatusEffect(xi.effect.INVISIBLE)
    end

    duration = duration + target:getMod(xi.mod.INVISIBLE_DURATION)

    target:addStatusEffect(xi.effect.INVISIBLE,1,10, math.floor(duration * xi.settings.main.SNEAK_INVIS_DURATION_MULTIPLIER))
end

return itemObject
