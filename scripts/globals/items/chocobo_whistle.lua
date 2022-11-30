-----------------------------------
-- ID: 15533
-- Item: Chocobo Whistle
--
-- Notes: Can't use item below lv 20, no need to adjust duration for that.
--    Can't normally use enchantments when level sync'd below items level so no need to check.
--    Per wiki, can actually obtain without license, but cannot use, so we DO check that.
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.MOUNT) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    elseif not target:hasKeyItem(xi.ki.CHOCOBO_LICENSE) or target:hasEnmity() then
        return xi.msg.basic.ITEM_UNABLE_TO_USE -- Todo: Verify/correct message, order of message priority.
    end

    return 0
end

itemObject.onItemUse = function(target)
    -- Base duration 30 min, in seconds.
    local duration = 1800 + (target:getMod(xi.mod.CHOCOBO_RIDING_TIME) * 60)
    target:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, xi.mount.CHOCOBO, 0, duration, 0, 64, true)
end

return itemObject
