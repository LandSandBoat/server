-----------------------------------------
-- ID: 5262
-- Item: Bottle Of Hysteroanima
-- Item Effect: HYSTERIA
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
    target:delStatusEffectSilent(xi.effect.HYSTERIA)
    target:addStatusEffectEx(xi.effect.HYSTERIA, xi.effect.HYSTERIA, 1, 0, math.random(25,32), 0, 0, 0, xi.effectFlag.NO_LOSS_MESSAGE)
end

return item_object
