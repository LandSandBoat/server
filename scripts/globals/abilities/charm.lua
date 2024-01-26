-----------------------------------
-- Ability: Charm a monster
-- Tames a monster to fight by your side.
-- Obtained: Beastmaster Level 1
-- Recast Time: 0:15
-- Duration: Varies
-- Check            |Duration
-- ---------------- |--------------
-- Too Weak         |30 Minutes
-- Easy Prey        |20 Minutes
-- Decent Challenge |10 Minutes
-- Even Match       |3.0 Minutes
-- Tough            |1.5 Minutes
-- Very Tough       |1-20 seconds
-----------------------------------
require("scripts/globals/pets")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif target:getMaster() ~= nil and target:getMaster():isPC() then
        return xi.msg.basic.THAT_SOMEONES_PET, 0
    end

    return 0, 0
end

abilityObject.onUseAbility = function(player, target, ability)
    if target:getMobMod(xi.mobMod.CHARMABLE) == 0 then
        if not target:hasImmunity(xi.immunity.BIND) then
            ability:setMsg(xi.msg.basic.JA_ENFEEB_IS)
            local bindDuration = math.random(2, 8)

            -- based on rumors on forums
            -- needs capture for NM, Bind Immune, Bind Res Build, Ice Resist, etc
            if target:isNM() then
                bindDuration = bindDuration / 2
            end

            target:addStatusEffect(xi.effect.BIND, 1, 0, bindDuration, 0, 0)
            return xi.effect.BIND
        else
            ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
            return
        end
    end

    if target:isPC() then
        ability:setMsg(xi.msg.basic.NO_EFFECT)
    else
        local isTamed = false

        if player:getLocalVar("Tamed_Mob") == target:getID() then
            player:addMod(xi.mod.CHARM_CHANCE, 10)
            isTamed = true
        end

        if not player:charmPet(target) then
            ability:setMsg(xi.msg.basic.JA_MISS)
        end

        if isTamed then
            player:delMod(xi.mod.CHARM_CHANCE, 10)
            player:setLocalVar("Tamed_Mob", 0)
        end
    end
end

return abilityObject
