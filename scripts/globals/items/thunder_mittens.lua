-----------------------------------
-- ID: 14987
-- Thunder Mittens
--  Enchantment: "Enthunder"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENTHUNDER)
    if effect ~= nil and effect:getItemSourceID() == xi.items.THUNDER_MITTENS then
        target:delStatusEffect(xi.effect.ENTHUNDER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENTHUNDER
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)

    target:addStatusEffect(effect, potency, 0, 180, 0, 0, 0, xi.items.THUNDER_MITTENS)
end

return itemObject
