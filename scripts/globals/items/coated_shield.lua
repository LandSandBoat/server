-----------------------------------
-- ID: 12406
-- Item: Coated Shield
-- Item Effect: Shell
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.SHELL)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.items.COATED_SHIELD
    then
        target:delStatusEffect(xi.effect.SHELL)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local power = 1055 -- Shell I   (27/256)
    local tier = 1
    local bonus = 0
    if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        bonus = 39 -- (1/256 bonus buff per tier)
    end

    power = power + (bonus * tier)
    if
        target:addStatusEffect(xi.effect.SHELL, power, 0, 1800, 0, 0, tier, xi.items.COATED_SHIELD)
    then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
