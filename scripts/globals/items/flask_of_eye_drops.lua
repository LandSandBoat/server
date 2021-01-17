-----------------------------------------
-- ID: 4150
-- Item: Eye Drops
-- Item Effect: This potion remedies blindness.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)

    if (target:hasStatusEffect(tpz.effect.BLINDNESS) == true) then
        target:delStatusEffect(tpz.effect.BLINDNESS)
    end
end


return item_object
