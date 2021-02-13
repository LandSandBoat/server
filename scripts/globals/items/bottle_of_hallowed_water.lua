-----------------------------------
-- ID: 5306
-- Item: Bottle of Hallowed Water
-- Item Effect: Removes curse. Better chance to remove doom.
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local curse = target:getStatusEffect(tpz.effect.CURSE_I)
    local curse2 = target:getStatusEffect(tpz.effect.CURSE_II)
    local bane = target:getStatusEffect(tpz.effect.BANE)
    local power = 33 + target:getMod(tpz.mod.ENHANCES_HOLYWATER)

    if (target:hasStatusEffect(tpz.effect.DOOM) and power > math.random(1, 100)) then
        target:delStatusEffect(tpz.effect.DOOM)
        target:messageBasic(tpz.msg.basic.NARROWLY_ESCAPE)
    elseif (curse ~= nil and curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
        target:delStatusEffect(tpz.effect.CURSE_II)
        target:delStatusEffect(tpz.effect.BANE)
    elseif (curse ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
        target:delStatusEffect(tpz.effect.BANE)
    elseif (curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_II)
        target:delStatusEffect(tpz.effect.BANE)
    elseif (curse ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_I)
    elseif (curse2 ~= nil) then
        target:delStatusEffect(tpz.effect.CURSE_II)
    elseif (bane ~= nil) then
        target:delStatusEffect(tpz.effect.BANE)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
