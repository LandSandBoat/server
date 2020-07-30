-----------------------------------
-- Ability: Tame
-- Makes target docile and more susceptible to charm.
-- Obtained: Beastmaster Level 30
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")

function onAbilityCheck(player, target, ability)
    return 0, 0
end

function onUseAbility(player, target, ability)
    if player:getPet() ~= nil then
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
        target:addEnmity(player, 1, 0)
        return 0
    end
    if target:getMobMod(tpz.mobMod.CHARMABLE) == 0 then
        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
        target:addEnmity(player, 1, 0)
        return 0
    end
    local resist = applyResistanceAbility(player, target, tpz.magic.ele.NONE, tpz.skill.NONE, player:getStat(tpz.mod.INT) - target:getStat(tpz.mod.INT))
    if resist <= 0.25 then
        ability:setMsg(tpz.msg.basic.JA_MISS_2)
        target:addEnmity(player, 1, 0)
        return 0
    else
        if target:isEngaged() then
            local enmitylist = target:getEnmityList()
            for _, enmity in ipairs(enmitylist) do
                if enmity.active and enmity.entity:getID() ~= player:getID() then
                    ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
                    target:addEnmity(player, 1, 0)
                    return 0
                elseif enmity.entity:getID() == player:getID() then
                    if not enmity.tameable then
                        ability:setMsg(tpz.msg.basic.JA_NO_EFFECT)
                        target:addEnmity(player, 1, 0)
                        return 0
                    end
                end
            end
            ability:setMsg(138) -- The x seems friendlier
            target:disengage()
        else
            player:setLocalVar("Tamed_Mob", target:getID())
            ability:setMsg(138) -- The x seems friendlier
        end
    end
end
