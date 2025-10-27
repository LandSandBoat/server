-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Lamp
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -101)

    -- TODO any other immunities?
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)

    -- "If all individuals who have developed enmity die, Pandemonium Warden will return to his spawn point, with his train of lamps, and will not be aggressive to any non-combat action"
    mob:setAggressive(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
