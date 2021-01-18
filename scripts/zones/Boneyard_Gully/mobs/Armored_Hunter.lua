-----------------------------------
-- Area: Boneyard Gully
--  Mob: Armored Hunter
-----------------------------------
mixins = {require("scripts/mixins/families/antlion_ambush")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Aggros via ambush, not superlinking
    mob:setMobMod(tpz.mobMod.SUPERLINK, 0)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 1)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
