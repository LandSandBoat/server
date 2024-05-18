-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Immortal Flan
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------
local entity = {}

local flanOffsetTable =
{
    -- Flan 1 always spawns
    ID.mob.IMMORTAL_FLAN_OFFSET + 1, -- Flan 2
    ID.mob.IMMORTAL_FLAN_OFFSET + 2, -- Flan 3
    ID.mob.IMMORTAL_FLAN_OFFSET + 3, -- Flan 4
    ID.mob.IMMORTAL_FLAN_OFFSET + 4, -- Flan 5
    ID.mob.IMMORTAL_FLAN_OFFSET + 5, -- Flan 6
}

entity.onMobEngage = function(mob, target)
    local bf = mob:getBattlefield()
    local mobOffset = (bf:getArea() - 1) * 7
    if bf:getLocalVar('flans_spawned') ~= 1 then
        local entrants = bf:getLocalVar('num_entrants')
        if entrants >= 4 then
            GetMobByID(flanOffsetTable[1] + mobOffset):spawn()
        end

        if entrants >= 7 then
            GetMobByID(flanOffsetTable[2] + mobOffset):spawn()
        end

        if entrants >= 10 then
            GetMobByID(flanOffsetTable[3] + mobOffset):spawn()
        end

        if entrants >= 13 then
            GetMobByID(flanOffsetTable[4] + mobOffset):spawn()
        end

        if entrants >= 16 then
            GetMobByID(flanOffsetTable[5] + mobOffset):spawn()
        end

        bf:setLocalVar('flans_spawned', 1)
    end
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
