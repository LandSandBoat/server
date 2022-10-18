-----------------------------------
-- ID: 4150
-- Item: Eye Drops
-- Item Effect: This potion remedies blindness.
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)

    if (target:hasStatusEffect(xi.effect.BLINDNESS) == true) then
        target:delStatusEffect(xi.effect.BLINDNESS)
    end
end

return itemObject
