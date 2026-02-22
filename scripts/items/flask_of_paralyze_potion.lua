-----------------------------------
-- ID: 4159
-- Item: Paralyze Potion
-- Item Effect: This potion induces paralyze.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.PARALYSIS) then
        target:addStatusEffect(xi.effect.PARALYSIS, { power = 20, duration = 180, origin = user })
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
