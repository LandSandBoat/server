-----------------------------------
-- Base Nyzul Weapon
-----------------------------------
local itemObject = {}

itemObject.onItemEquip = function(target, item)
    xi.equipment.baseNyzulTemporarilyUnlockWS(target)

    target:addListener('WEAPONSKILL_STATE_EXIT', 'MYTHIC_WS_UNLOCK', function(playerArg, wsIdArg)
        xi.equipment.baseNyzulTemporarilyUnlockWS(playerArg)
    end)
end

itemObject.onItemUnequip = function(target, item)
    target:removeListener('MYTHIC_WS_UNLOCK')
end

return itemObject
