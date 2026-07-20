-----------------------------------
-- ID: 4213
-- Icarus Wing
-- Increases TP of the user by 1000
-- Modified by Store TP. https://wiki.ffo.jp/html/3809.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    local storeTPModifier = 1 + (target:getMod(xi.mod.STORETP) + target:getMerit(xi.merit.STORE_TP_EFFECT)) / 100

    target:addTP(math.floor(1000 * storeTPModifier))
    target:addStatusEffect(xi.effect.MEDICINE, { duration = 7200, origin = user })
end

return itemObject
