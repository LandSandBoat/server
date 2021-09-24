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
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/pets")
require("scripts/globals/msg")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif target:getMaster() ~= nil and target:getMaster():isPC() then
        return xi.msg.basic.THAT_SOMEONES_PET, 0
    else
        return 0, 0
    end
end

ability_object.onUseAbility = function(player, target, ability)
    if target:isPC() then
        ability:setMsg(xi.msg.basic.NO_EFFECT)
    else
        local Tamed = false

        if player:getLocalVar("Tamed_Mob") == target:getID() then
            player:addMod(xi.mod.CHARM_CHANCE, 10)
            Tamed = true
        end

        player:charmPet(target)

        if Tamed then
            player:delMod(xi.mod.CHARM_CHANCE, 10)
            player:setLocalVar("Tamed_Mob", 0)
        end
    end
end

return ability_object
