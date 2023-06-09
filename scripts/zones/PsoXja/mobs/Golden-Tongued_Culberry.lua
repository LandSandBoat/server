-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-----------------------------------
mixins = { require("scripts/mixins/families/tonberry") }
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/items")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener("ITEM_DROPS", "ITEM_DROPS_CULBERRY", function(mobArg, loot)
        loot:addItemFixed(xi.items.UGGALEPIH_PENDANT, mob:getLocalVar("DropRate"))
    end)

    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)

    -- Unconfirmed bonuses
    -- mob:setMod(xi.mod.MATT, 50)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobFight = function(mob, target)
    local action = mob:getCurrentAction()

    -- Cancels spell if target switches during casting
    if action == xi.action.MAGIC_START then
        mob:setLocalVar("currTarget", target)
    elseif
        action == xi.action.MAGIC_CASTING and
        not target == mob:getLocalVar("currTarget")
    then
        mob:clearActionQueue()
    end

    if target:isPet() then
        mob:addMod(xi.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:delMod(xi.mod.FASTCAST, 100)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
