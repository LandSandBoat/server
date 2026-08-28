-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Kirin's Avatar
-----------------------------------
---@type TMobEntity
local entity = {}

mixins = { require('scripts/mixins/families/avatar') }

entity.onMobSpawn = function(mob)
    -- Prevent summoning Fenrir as a possible Astral Flow avatar
    local avatars =
    {
        xi.petId.CARBUNCLE,
        xi.petId.IFRIT,
        xi.petId.TITAN,
        xi.petId.LEVIATHAN,
        xi.petId.GARUDA,
        xi.petId.SHIVA,
        xi.petId.RAMUH,
    }

    mob:setMobMod(xi.mobMod.AVATAR_PETID, utils.randomEntry(avatars))
end

return entity
