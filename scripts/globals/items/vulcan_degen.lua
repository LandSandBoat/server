-----------------------------------
-- ID: 17705
-- Item: Vulcan Degen
-- Item Effect: Enfire
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENFIRE)
    if effect ~= nil and effect:getSubType() == 17705 then
        target:delStatusEffect(xi.effect.ENFIRE)
    end
    return 0
end

item_object.onItemUse = function(target)
    local effect = xi.effect.ENFIRE
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)

    target:addStatusEffect(effect, potency, 0, 180, 17705)
end

return item_object
