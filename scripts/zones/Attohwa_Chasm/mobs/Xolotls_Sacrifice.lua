-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Xolotl's Sacrifice
-- Note: Pet for Xolotl
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local xolotl = GetMobByID(zones[xi.zone.ATTOHWA_CHASM].mob.XOLOTL)
        if xolotl then
            xolotl:setLocalVar('sacrifice_spawn_time', GetSystemTime() + 60)
        end
    end
end

return entity
