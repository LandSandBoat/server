-----------------------------------
-- ID: 14992
-- Water Mitts
--  Enchantment: "Enwater"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENWATER)
    if effect ~= nil and effect:getItemSourceID() == xi.items.WATER_MITTS then
        target:delStatusEffect(xi.effect.ENWATER)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local effect = xi.effect.ENWATER
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)

    target:addStatusEffect(effect, potency, 0, 180, 0, 0, 0, xi.items.WATER_MITTS)
end

return itemObject
