-----------------------------------
-- ID: 18052
-- Tredecim Scythe
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(player, item)
    player:setLocalVar('TREDECIM_COUNTER', 0)
end

itemObject.onItemEquip = function(player, item)
    player:addListener("ATTACK", "TREDECIM_ATTACK", function(playerArg, mob)
        -- Setting of critical attack is handled in battleentity.cpp
        playerArg:setLocalVar("TREDECIM_COUNTER", playerArg:getLocalVar("TREDECIM_COUNTER") + 1)
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener("TREDECIM_ATTACK")
end

return itemObject
