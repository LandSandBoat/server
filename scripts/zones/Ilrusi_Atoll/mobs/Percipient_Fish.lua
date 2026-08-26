-----------------------------------
-- Area: Ilrusi Atoll
--  Mob: Percipient Fish
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.HPP, 100) -- Retail captured, keeps HP correct at all level caps.
end

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)

    mob:setMod(xi.mod.STORETP, 20)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
end

return entity
