-----------------------------------------
-- ID: 5261
-- Item: Bottle Of Psychoanima
-- Item Effect: Intimidate
-----------------------------------------
require("scripts/globals/msg")
require("scripts/globals/status")
require("scripts/globals/player")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target, player)
    local result = 0
	if target:getSystem() ~= xi.ecosystem.EMPTY then -- Empty
        result = xi.msg.basic.ITEM_UNABLE_TO_USE
    elseif target:checkDistance(player) > 10 then
        result = xi.msg.basic.TOO_FAR_AWAY
    end

    return result
end

item_object.onItemUse = function(target, player)
    target:delStatusEffectSilent(xi.effect.INTIMIDATE)
    target:addStatusEffect(xi.effect.INTIMIDATE, 100, 0, math.random(25,32))
	player:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.INTIMIDATE, 0, target)
end

return item_object
