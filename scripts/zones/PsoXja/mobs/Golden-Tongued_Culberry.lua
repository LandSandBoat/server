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
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 6)
end

entity.onMobFight = function(mob, target)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    if target:isPet() then
        mob:setMod(tpz.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(tpz.mod.FASTCAST, 10)
    end
end

function onMobDeath(mob, player, isKiller)
end

return entity
