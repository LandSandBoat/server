-----------------------------------
-- ID: 15452
-- Item: Fisherman's Belt
-- Enchantment: Synthesis image support
-- 2Min, All Races
-----------------------------------
-- Enchantment: Synthesis image support
-- Duration: 2 Earth Hours
-- Fishing Skill +2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    local imagery =
    {
        xi.effect.FISHING_IMAGERY,
        xi.effect.WOODWORKING_IMAGERY,
        xi.effect.SMITHING_IMAGERY,
        xi.effect.GOLDSMITHING_IMAGERY,
        xi.effect.CLOTHCRAFT_IMAGERY,
        xi.effect.LEATHERCRAFT_IMAGERY,
        xi.effect.BONECRAFT_IMAGERY,
        xi.effect.ALCHEMY_IMAGERY,
        xi.effect.COOKING_IMAGERY
    }

    for _, effect in ipairs(imagery) do
        if target:hasStatusEffect(effect) then
            result = xi.msg.basic.ITEM_UNABLE_TO_USE
        end
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FISHING_IMAGERY, 2, 0, 7200)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FISH, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FISH, 1)
end

return itemObject
