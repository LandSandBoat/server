-----------------------------------------
-- ID: 14664
-- Teleport ring: Vahzl
-- Enchantment: "Teleport-Vahzl"
-----------------------------------------

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:hasKeyItem(tpz.ki.VAHZL_GATE_CRYSTAL) == false) then
        result = 445
    end
    return result
end

function onItemUse(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.VAHZL, 0, 1)
end
