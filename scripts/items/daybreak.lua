-----------------------------------
-- ID: 22040
-- Daybreak
-- Able to cast "Dispelga"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
end

itemObject.onItemEquip = function(target, item)
    local mainWeapon = target:getEquippedItem(xi.slot.MAIN)
    if mainWeapon and mainWeapon:getID() == xi.item.DAYBREAK then
        target:addSpell(xi.magic.spell.DISPELGA, { silentLog = true, saveToDB = false })
    end
end

itemObject.onItemUnequip = function(target, item)
    target:delSpell(xi.magic.spell.DISPELGA, { saveToDB = false })
end

return itemObject
