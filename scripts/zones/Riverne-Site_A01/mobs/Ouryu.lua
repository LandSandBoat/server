-----------------------------------
-- Ouryu Cometh
-- Riverne Site A, Cloud Evokers
-- !pos 184 0 344 30
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 15)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 60) -- Level 85 + 60 = 145 Base Weapon Damage
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OURYU_OVERWHELMER)
end

return entity
