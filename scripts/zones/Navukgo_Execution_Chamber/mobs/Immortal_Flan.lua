-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Immortal Flan
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    local bf = mob:getBattlefield()
    local mobOffset = (bf:getArea() - 1) * 7
    if bf:getLocalVar('flans_spawned') ~= 1 then
        local entrants = bf:getLocalVar('num_entrants')
        if entrants >= 4 then
            GetMobByID(ID.mob.IMMORTAL_FLAN2 + mobOffset):spawn()
        end

        if entrants >= 7 then
            GetMobByID(ID.mob.IMMORTAL_FLAN3 + mobOffset):spawn()
        end

        if entrants >= 10 then
            GetMobByID(ID.mob.IMMORTAL_FLAN4 + mobOffset):spawn()
        end

        if entrants >= 13 then
            GetMobByID(ID.mob.IMMORTAL_FLAN5 + mobOffset):spawn()
        end

        if entrants >= 16 then
            GetMobByID(ID.mob.IMMORTAL_FLAN6 + mobOffset):spawn()
        end

        bf:setLocalVar('flans_spawned', 1)
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
