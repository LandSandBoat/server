-----------------------------------
-- Area: Temple of Uggalepih
--  Mob: Tonberry's Avatar
-----------------------------------
mixins = { require('scripts/mixins/families/avatar') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() - 2 == zones[xi.zone.TEMPLE_OF_UGGALEPIH].mob.CRIMSON_TOOTHED_PAWBERRY then
        -- Crimson-toothed Pawberry's avatar is always carbuncle
        mob:setMobMod(xi.mobMod.AVATAR_PETID, xi.petId.CARBUNCLE)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
