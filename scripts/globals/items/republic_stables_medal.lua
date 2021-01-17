-----------------------------------------
-- ID: 13180
-- Item: Republic Stables Medal
-- Teleports to Chocobo Stables (Bastok)
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if not target:isZoneVisited(tpz.zone.BASTOK_MINES) then
        result = tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.CHOCO_BASTOK, 0, 4)
end

return item_object
