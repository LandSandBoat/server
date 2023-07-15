-----------------------------------------
-- ID: 14810
-- Item: Signal Pearl
-- Calls forth an adventuring fellow
-----------------------------------------
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if
        target:getFellow() ~= nil or
        target:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) or
        target:hasStatusEffect(xi.effect.LEVEL_SYNC) or
        xi.settings.main.ENABLE_ADVENTURING_FELLOWS == nil or
        not xi.settings.main.ENABLE_ADVENTURING_FELLOWS
    then
            return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    if not target:canUseMisc(xi.zoneMisc.FELLOW) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    local wotgUnlock = target:getFellowValue("wotg_unlock")

    if target:getContinentID() == 3 and wotgUnlock == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:spawnFellow(target:getFellowValue("fellowid"))
    target:setFellowValue("bond", target:getFellowValue("bond") + 1)
end

return itemObject
