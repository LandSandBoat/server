-----------------------------------
-- Area: Throne Room
--  Mob: Demon's Avatar (Astral flow pet for Duke Dantalian)
-----------------------------------
mixins = { require('scripts/mixins/families/avatar') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AVATAR_PETID, xi.petId.SHIVA)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
