-----------------------------------------
-- ID: 5829
-- Item: Lucid Ether III
-- Item Effect: Restores 1000 MP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")

function onItemCheck(target)
    if target:getMP() == target:getMaxMP() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end
    return 0
end

function onItemUse(target)
    target:messageBasic(tpz.msg.basic.RECOVERS_MP, 0, target:addMP(1000*ITEM_POWER))
end
