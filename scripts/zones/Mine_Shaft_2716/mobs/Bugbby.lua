-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Bugbby
-----------------------------------
local ID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if not battlefield then
            return
        end

        local offset = (battlefield:getArea() - 1) * 5

        -- Enable mob abilities for all Moblins when Bugbear dies
        for i = 0, 3 do
            local moblin = GetMobByID(ID.mob.MOVAMUQ + offset + i)
            if moblin and moblin:isAlive() then
                moblin:setMobAbilityEnabled(true)
            end
        end
    end
end

return entity
