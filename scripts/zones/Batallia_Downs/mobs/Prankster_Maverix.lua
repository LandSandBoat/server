-----------------------------------
-- Area: Batallia Downs
--   NM: Prankster Maverix
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 164)
end

return entity
