-----------------------------------
-- Ouryu Cometh
-- Riverne Site A, Cloud Evokers
-- !pos 184 0 344 30
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, player, optParams)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 60) -- Level 85 + 60 = 145 Base Weapon Damage
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.OURYU_OVERWHELMER)
end

return entity
