-----------------------------------------
-- ID: 15834
-- Item: Blind Ring
-- Item Effect: Enchantment Blind
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target, player)
    local result = 0
    if (target:checkDistance(player) > 10) then
        result = xi.msg.basic.TOO_FAR_AWAY
    end
    return result
end

item_object.onItemUse = function(target, player, item)
    local chance = 70
    if target:hasImmunity(64) or math.random(0, 100) >= chance then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:delStatusEffect(xi.effect.BLINDNESS)
        if (not target:hasStatusEffect(xi.effect.BLINDNESS)) then
            target:addStatusEffect(xi.effect.BLINDNESS, 10, 0, 30)
        end
    end
    target:updateClaim(player)
end

return item_object
