-----------------------------------
-- Reinforcements
-- Calls forth reinforcements.
-- Note: Mob doors must be open
-- Todo: Mobs spawned from this need Special spawn animation set.
-----------------------------------

---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local spawnCount = mob:getLocalVar('spawnCount')
    local offset     = mob:getLocalVar('spawnOffset')
    local instance   = mob:getInstance()

    if instance then
        if spawnCount > 0 and mob:getAnimationSub() == 1 then
            for i = 1 + offset, spawnCount + offset do
                if not GetMobByID(mob:getID() + i, instance):isSpawned() then
                    return 0
                end
            end
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local spawnCount = mob:getLocalVar('spawnCount')
    local offset     = mob:getLocalVar('spawnOffset')
    local mobID      = mob:getID()
    local instance   = mob:getInstance()
    local ids        = {}

    if instance then
        -- find avail mobs to spawn
        for i = 1 + offset, spawnCount + offset do
            local tableMob = GetMobByID(mobID + i, instance)
            if tableMob and not tableMob:isSpawned() then
                table.insert(ids, mobID + i)
            end
        end

        -- random out the results of ids
        if #ids > 0 then
            local shuffledIDs = utils.shuffle(ids)
            local rampartMob  = GetMobByID(shuffledIDs[1], instance)

            mob:timer(2500, function(mobArg)
                if rampartMob and mobArg:isAlive() then
                    local pos = mobArg:getPos()
                    rampartMob:setSpawn(pos.x, pos.y, pos.z, pos.rot)
                    -- Needs specialSpawnAnimation true
                    SpawnMob(shuffledIDs[1], instance)
                    mobArg:setLocalVar('numberSpawned', mobArg:getLocalVar('numberSpawned') + 1)
                    rampartMob:setAggressive(true) -- all rampart mobs should be aggressive
                    -- below is for reactionary rampart mobs that should have hate linked
                    if mobArg:getName() == 'Reactionary_Rampart' and mobArg:isEngaged() then
                        rampartMob:updateEnmity(mobArg:getTarget())
                    end
                end
            end)
        end
    end

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
