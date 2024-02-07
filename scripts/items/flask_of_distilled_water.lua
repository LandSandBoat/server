-----------------------------------
-- ID: 4509
-- Item: Flask of distilled water
-- Item Effect: While Sha Wujing's Lance +1 is equipped:
--   5m 1HP/tick Regen effect. Lance does not need to remain equipped after use.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local mainWeapon = target:getEquipID(xi.slot.MAIN)

    if
        mainWeapon == xi.item.SHA_WUJINGS_LANCE_P1 and
        not target:hasStatusEffect(xi.effect.REGEN)
    then
        target:addStatusEffect(xi.effect.REGEN, 1, 1, 300)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
