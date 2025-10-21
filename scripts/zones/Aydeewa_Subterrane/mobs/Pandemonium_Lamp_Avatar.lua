-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Lamp (astral flow)
-- Note: The amount of avatars spawned is based on the number of living Pandemonium Lamps when PW calls avatars at each 25% hp
-----------------------------------
mixins = { require('scripts/mixins/families/avatar') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    for i, mobId in ipairs(zones[xi.zone.AYDEEWA_SUBTERRANE].mob.PANDEMONIUM_AVATARS) do
        if mob:getID() == mobId then
            mob:setMobMod(xi.mobMod.AVATAR_PETID, xi.petId.CARBUNCLE - 1 + i)
        end
    end

    -- 6:34 to 6:46 in this video: https://www.youtube.com/watch?v=T_Us2Tmlm-E
    -- shows approx 12 seconds between spawn and AF usage
    mob:setMobMod(xi.mobMod.AVATAR_ASTRAL_DELAY, 12000)

    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -101)

    -- TODO any other immunities?
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
