-----------------------------------
-- Ability: Despoil
-- Steal items and debuffs enemy.
-- Obtained: Thief Level 77
-- Recast Time: 5:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/jobpoints")
require("scripts/globals/magic")
require("scripts/globals/msg")
require("scripts/globals/status")
-----------------------------------
local ability_object = {}

local despoilDebuffs =
{
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_DEF_DOWN,
    xi.effect.SLOW
}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:getFreeSlotsCount() == 0 then
        return xi.msg.basic.FULL_INVENTORY, 0
    end

    if player:getObjType() == xi.objType.TRUST then
        if player:getMaster():getFreeSlotsCount() == 0 then
            return 1, 0
        end
    end

    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability, action)
    local level = player:getMainLvl() -- Can only reach THF77 as main job
    local despoilMod = player:getMod(xi.mod.DESPOIL)
    local despoilChance = 50 + despoilMod * 2 + level - target:getMainLvl() -- Same math as Steal

    -- TODO: Need to verify if there's a message associated with this
    local jpValue = player:getJobPointLevel(xi.jp.DESPOIL_EFFECT)
    if jpValue > 0 and player:getMainJob() == xi.job.THF then
        local tpSteal = jpValue * 0.02
        local mobTP = target:getTP()

        if tpSteal > mobTP then
            tpSteal = mobTP
        end

        target:addTP(-tpSteal)
        player:addTP(tpSteal)
    end

    local stolen = target:getDespoilItem()
    if target:isMob() and math.random(100) < despoilChance and stolen then
        if player:getObjType() == xi.objType.TRUST then
            player:getMaster():addItem(stolen)
        else
            player:addItem(stolen)
        end
        target:itemStolen()

        -- Attempt to grab the debuff from the DB
        -- If there isn't a debuff assigned to the item stolen, select one at random
        local debuff = player:getDespoilDebuff(stolen)
        if not debuff then
            debuff = despoilDebuffs[math.random(#despoilDebuffs)]
        end
        local power = processDebuff(player, target, ability, debuff) -- Also sets ability message
        target:addStatusEffect(debuff, power, 0, 90)
    else
        action:setAnimation(target:getID(), 182)
        ability:setMsg(xi.msg.basic.STEAL_FAIL) -- Failed
    end

    return stolen
end

function processDebuff(player, target, ability, debuff)
    local power = 10
    if debuff == xi.effect.ATTACK_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_ATT_DOWN)
        power = 20
    elseif debuff == xi.effect.DEFENSE_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_DEF_DOWN)
        power = 30
    elseif debuff == xi.effect.MAGIC_ATK_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_MATT_DOWN)
    elseif debuff == xi.effect.MAGIC_DEF_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_MDEF_DOWN)
        power = 20
    elseif debuff == xi.effect.EVASION_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_EVA_DOWN)
        power = 30
    elseif debuff == xi.effect.ACCURACY_DOWN then
        ability:setMsg(xi.msg.basic.DESPOIL_ACC_DOWN)
        power = 20
    elseif debuff == xi.effect.SLOW then
        ability:setMsg(xi.msg.basic.DESPOIL_SLOW)
        local dMND = player:getStat(xi.mod.MND) - target:getStat(xi.mod.MND)
        if dMND >= 0 then
            power = 2 * dMND + 1500
        else
            power = dMND + 1500
        end
        power = utils.clamp(power, 750, 3000)
    end

    return power
end

return ability_object
