-----------------------------------
-- Area: Abyssea - Altepa
--  Mob: Desert Puk
-----------------------------------
mixins = { require("scripts/mixins/families/puk") }
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
