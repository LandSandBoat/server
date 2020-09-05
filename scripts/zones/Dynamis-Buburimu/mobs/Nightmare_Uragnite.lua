-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Uragnite
-----------------------------------
mixins = {
    require("scripts/mixins/dynamis_dreamland"),
    require("scripts/mixins/families/uragnite")
}
-----------------------------------

function onMobSpawn(mob)
    mob:setLocalVar("dynamis_currency", 1455)
end

function onMobDeath(mob, player, isKiller)
end
