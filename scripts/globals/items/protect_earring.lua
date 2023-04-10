-----------------------------------
-- ID: 15838
-- Item: Protect Earring
-- Item Effect: Protect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local power = 20
    local tier = 1
    local bonus = 0
    if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        bonus = 2 -- 2x Tier from MOD
    end

    power = power + (bonus * tier)

    if target:addStatusEffect(xi.effect.PROTECT, power, 0, 1800, 0, 0, tier) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.PROTECT)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
