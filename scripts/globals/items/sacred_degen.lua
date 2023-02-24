-----------------------------------
-- ID: 17683
-- Item: Sacred Degen
-- Enchantment: Enlight
-- Duration: 3 minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENLIGHT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.SACRED_DEGEN then
        target:delStatusEffect(xi.effect.ENLIGHT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENLIGHT
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)

    target:addStatusEffect(effect, potency, 0, 180, 0, 0, 0, xi.items.SACRED_DEGEN)
end

return itemObject
