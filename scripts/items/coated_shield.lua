-----------------------------------
-- ID: 15838
-- Item: Coated Shield
-- Item Effect: Shell
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
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
    if target:addStatusEffect(xi.effect.SHELL, power, 0, 1800, 0, 0, tier) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
