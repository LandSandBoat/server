-----------------------------------
-- Area: Boneyard Gully
--  Mob: Shrewd Hunter
-----------------------------------
mixins = { require("scripts/mixins/families/antlion_ambush") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(xi.mobMod.SUPERLINK, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
