-----------------------------------
-- Ability: Mug
-- Steal gil from enemy.
-- Obtained: Thief Level 35
-- Recast Time: 5:00
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability, action)
    local thfLevel
    local gil = 0

    if (player:getMainJob() == xi.job.THF) then
        thfLevel = player:getMainLvl()
    else
        thfLevel = player:getSubLvl()
    end

    -- TODO: Need to verify if there's a message associated with this
    local jpValue = player:getJobPointLevel(xi.jp.MUG_EFFECT)
    if jpValue > 0 and player:getMainJob() == xi.job.THF then
        local hpSteal = ((player:getStat(xi.mod.AGI) + player:getStat(xi.mod.DEX)) * jpValue) * 0.05
        local mobHP = target:getHP()

        if hpSteal > mobHP then
            hpSteal = mobHP
        end

        target:addHP(-hpSteal)
        player:addHP(hpSteal)
    end

    local mugChance = 90 + thfLevel - target:getMainLvl()

    if (target:isMob() and math.random(100) < mugChance and target:getMobMod(xi.mobMod.MUG_GIL) > 0) then
        local purse = target:getMobMod(xi.mobMod.MUG_GIL)
        local fatpurse = target:getGil()
        gil = fatpurse / (8 + math.random(0, 8))
        if (gil == 0) then
            gil = fatpurse / 2
        end
        if (gil == 0) then
            gil = fatpurse
        end
        if (gil > purse) then
            gil = purse
        end

        if (gil <= 0) then
            ability:setMsg(xi.msg.basic.MUG_FAIL)
        else
            gil = gil * (1 + player:getMod(xi.mod.MUG_EFFECT))
            player:addGil(gil)
            target:setMobMod(xi.mobMod.MUG_GIL, target:getMobMod(xi.mobMod.MUG_GIL) - gil)
            ability:setMsg(xi.msg.basic.MUG_SUCCESS)
        end
    else
        ability:setMsg(xi.msg.basic.MUG_FAIL)
        action:setAnimation(target:getID(), 184)
    end

    return gil
end

return ability_object
