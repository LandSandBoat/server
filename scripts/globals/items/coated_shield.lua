-----------------------------------
-- ID: 15838
-- Item: Coated Shield
-- Item Effect: Shell
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/utils")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 27 -- power/256 handled below to pass final DMGMAGIC value
    local tier = 1
    local buff = 0
    if target:getMod(xi.mod.ENHANCES_PROT_SHELL_RCVD) > 0 then
        buff = 1 -- Adds the tier as a bonus to power before calculation
    end
    power = utils.roundup((power + (buff * tier)) / 2.56) -- takes the result and converts it back to a usable DMGMAGIC value
    if (target:addStatusEffect(xi.effect.SHELL, power, 0, 1800, 0, 0, tier)) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.SHELL)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
