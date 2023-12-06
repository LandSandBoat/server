-----------------------------------
-- ID: 18052
-- Tredecim Scythe
-----------------------------------
local itemObject = {}

itemObject.onItemEquip = function(target, item)
    target:addListener('MELEE_SWING_HIT', 'TREDECIM_MELEE_SWING_HIT', function(playerArg, targetArg, attackArg)
        local mainWeapon = playerArg:getEquippedItem(xi.slot.MAIN)
        if mainWeapon and mainWeapon:getID() == xi.item.TREDECIM_SCYTHE then
            local exData = mainWeapon:getExData()
            local count  = exData[0]

            if count % 13 == 12 then
                attackArg:setCritical(true)
            end

            exData[0] = (count + 1) % 13

            mainWeapon:setExData(exData)
        end
    end)
end

itemObject.onItemUnequip = function(target, item)
    target:removeListener('TREDECIM_MELEE_SWING_HIT')
end

return itemObject
