-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-----------------------------------
mixins = {require("scripts/mixins/families/tonberry")}
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 6)
end

entity.onMobFight = function(mob, target)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    if target:isPet() then
        mob:setMod(xi.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(xi.mod.FASTCAST, 10)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
