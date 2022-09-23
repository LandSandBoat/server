-----------------------------------
-- ID: 5837
-- Item: tube_of_clear_salve_i
-- Item Effect: Instantly removes 1-2 negative status effects at random from pet
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if not target:hasPet() then
        return xi.msg.basic.REQUIRES_A_PET
    end
    return 0
end

item_object.onItemUse = function(target)
    local pet = target:getPet()
    local effects =
    {
        xi.effect.PETRIFICATION,
        xi.effect.SILENCE,
        xi.effect.BANE,
        xi.effect.CURSE_II,
        xi.effect.CURSE_I,
        xi.effect.PARALYSIS,
        xi.effect.PLAGUE,
        xi.effect.POISON,
        xi.effect.DISEASE,
        xi.effect.BLINDNESS
    }

    local count = math.random(1, 2)
    local statusEffectTable = utils.shuffle(effects)

    local function removeStatus()
        for _, effect in ipairs(statusEffectTable) do
            if pet:delStatusEffect(effect) then return true end
        end
        if pet:eraseStatusEffect() ~= 255 then return true end
        return false
    end

    local removed = 0

    for i = 0, count do
        if not removeStatus() then break end
        removed = removed + 1
        if removed >= count then break end
    end

    return removed
end

return item_object
