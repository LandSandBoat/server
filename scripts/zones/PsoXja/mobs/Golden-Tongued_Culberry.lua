-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-----------------------------------
mixins = { require("scripts/mixins/families/tonberry") }
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/items")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
    mob:addListener("ITEM_DROPS", "ITEM_DROPS_CULBERRY", function(mobArg, loot)
        loot:addItemFixed(xi.items.UGGALEPIH_PENDANT, mob:getLocalVar("DropRate"))
    end)
end

entity.onMobFight = function(mob, target)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    if target:isPet() then
        mob:setMod(xi.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(xi.mod.FASTCAST, 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
