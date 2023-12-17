-----------------------------------
-- ID: 19210
-- Stygian Ash
-----------------------------------
local itemObject = {}

itemObject.onItemEquip = function(target, item)
    target:addListener('RANGE_STATE_EXIT', 'STYGIAN_ASH_THROWN', function(playerArg, targetArg, action)
        -- if throw didn't miss, set localvar
        if targetArg then
            local targID = targetArg:getID()
            if action:getMsg(targID) ~= xi.msg.basic.RANGED_ATTACK_MISS then
                targetArg:setLocalVar('StygianLanded', 1)
            end
        end
    end)
end

itemObject.onItemUnequip = function(target, item)
    -- item is unequipped when thrown, don't remove listener immediately
    target:timer(500, function(targetArg)
        targetArg:removeListener('STYGIAN_ASH_THROWN')
    end)
end

return itemObject
