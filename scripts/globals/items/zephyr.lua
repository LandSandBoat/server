-----------------------------------
-- ID: 18163
-- Item: Zephyr
-- Additional Effect: Removes Seiryu's Wind Damage
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onAdditionalEffect = function(player, target, damage)
    if (target:getFamily() == 278) then
        target:setMobMod(xi.mobMod.ADD_EFFECT, 0)
    end
    return 0, 0, 0
end

return item_object
