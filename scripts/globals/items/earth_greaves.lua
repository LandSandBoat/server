-----------------------------------------
-- ID: 15708
-- Item: earth_greaves Earth Greaves
-- Item Effect: Grants Wyvren Stoneskin (200)
-- Duration: Not stated on wiki
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:getPet() then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if target:getPetID() ~= xi.pet.id.WYVERN then
            return xi.msg.basic.ITEM_UNABLE_TO_USE
        else
            return 0, 0
        end
    end
end

itemObject.onItemUse = function(target)
    local wyvern = target:getPet()
    if wyvern then
        if wyvern:getStatusEffect(xi.effect.STONESKIN) then
            wyvern:delStatusEffectSilent(xi.effect.STONESKIN)
        end

        wyvern:addStatusEffect(xi.effect.STONESKIN, 200, 0, 180)
    end
end

return itemObject
