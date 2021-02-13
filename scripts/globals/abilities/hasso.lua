-----------------------------------
-- Ability: Hasso
-- Grants a bonus to attack speed, accuracy, and Strength when using two-handed weapons, but increases recast and casting times.
-- Obtained: Samurai Level 25
-- Recast Time: 1:00
-- Duration: 5:00
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if not target:isWeaponTwoHanded() then
        return tpz.msg.basic.NEEDS_2H_WEAPON, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    local strboost = 0

    if target:getMainJob() == tpz.job.SAM then
        strboost = target:getMainLvl() / 7
    elseif target:getSubJob() == tpz.job.SAM then
        strboost = target:getSubLvl() / 7
    end

    if strboost > 0 then
        target:delStatusEffect(tpz.effect.HASSO)
        target:delStatusEffect(tpz.effect.SEIGAN)
        target:addStatusEffect(tpz.effect.HASSO, strboost, 0, 300)
    end
end

return ability_object
