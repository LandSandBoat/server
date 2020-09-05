-----------------------------------
-- Area: Pso'Xja
--   NM: Golden-Tongued Culberry
-----------------------------------
mixins = {require("scripts/mixins/families/tonberry")}
local ID = require("scripts/zones/PsoXja/IDs")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 6)
end

function onMobFight(mob, target)
    mob:SetAutoAttackEnabled(false)
    mob:SetMobAbilityEnabled(false)
    if target:isPet() then
        mob:setMod(dsp.mod.FASTCAST, 100)
        mob:castSpell(367, target) -- Insta-death any pet with most enmity.
        mob:setMod(dsp.mod.FASTCAST, 10)
    end
end

function onMobDeath(mob, player, isKiller)
end
