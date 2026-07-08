-----------------------------------
-- Area: Sacrarium
--  Mob: Fomor's Avatar
-----------------------------------
mixins = { require('scripts/mixins/families/avatar') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.AVATAR_PETID, xi.petId.FENRIR)
end

return entity
