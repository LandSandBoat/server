-----------------------------------
-- Area: Uleguerand Range
--  Mob: Mountain Worm NM
--  https://www.bg-wiki.com/ffxi/Mountain_Worm_(NM)
-- TODO allow deaggro (core CMobEntity::CanDeaggro() forces NM and Battlefield mobs to never stop chasing)
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, mob:getMaxHP() / 100)
end

entity.onMobFight = function(mob, target)
    -- TODO should only cast if out of melee range, but this PR should resolve that https://github.com/LandSandBoat/server/pull/5313
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
