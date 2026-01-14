-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- NM does not have 1.5x base DMG, instead they have increased attack
    mob:setMod(xi.mod.ATT, 235)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 366)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('cooldown', GetSystemTime() + 900)
end

return entity
