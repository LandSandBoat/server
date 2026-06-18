-----------------------------------
-- Salvage: Mob spawning logic.
-----------------------------------
xi = xi or {}
xi.salvage = xi.salvage or {}

xi.salvage.spawnGroup = function(instance, indexID)
    if indexID then
        for _, enemies in pairs(indexID) do
            if type(enemies) == 'table' then
                for _, groups in pairs(enemies) do
                    if type(groups) == 'table' then
                        for _, subGroups in pairs(groups) do
                            SpawnMob(subGroups, instance)
                            GetMobByID(subGroups, instance):setLocalVar('spawned', 1)
                        end
                    else
                        SpawnMob(groups, instance)
                        GetMobByID(groups, instance):setLocalVar('spawned', 1)
                    end
                end
            else
                SpawnMob(enemies, instance)
                GetMobByID(enemies, instance):setLocalVar('spawned', 1)
            end
        end
    end
end

xi.salvage.groupKilled = function(instance, indexID)
    for _, enemies in pairs(indexID) do
        if type(enemies) == 'table' then
            for _, groups in pairs(enemies) do
                if type(groups) == 'table' then
                    for _, subGroups in pairs(groups) do
                        local mob = GetMobByID(subGroups, instance)
                        if mob and mob:getLocalVar('spawned') == 0 then
                            return false
                        elseif mob and mob:isAlive() then
                            return false
                        end
                    end
                else
                    local mob = GetMobByID(groups, instance)
                    if mob and mob:getLocalVar('spawned') == 0 then
                        return false
                    elseif mob and mob:isAlive() then
                        return false
                    end
                end
            end
        else
            local mob = GetMobByID(enemies, instance)

            if mob and mob:getLocalVar('spawned') == 0 then
                return false
            elseif mob and mob:isAlive() then
                return false
            end
        end
    end

    return true
end
