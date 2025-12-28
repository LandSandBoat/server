-----------------------------------
-- Area: Bhaflau Remnants
--  MOB: Archaic Gear
--
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
mixins = { require('scripts/mixins/families/gear') }
-----------------------------------

local eastRampartPos =
    {
        [1] = { -300.0,  0.0, -75.0, 192 },
        [2] = { -315.0, -4.0,  20.0,   0 },
        [3] = { -220.0, -4.0, 125.0, 192 },
        [4] = { -300.0,  0.0, 195.0,  64 },
    }

local westRampartPos =
    {
        [1] = { -380.0,  0.0, -75.0, 192 },
        [2] = { -365.0, -4.0,  20.0, 128 },
        [3] = { -460.0, -4.0,   125, 192 },
        [4] = { -380.0,  0.0,   195,  64 },
    }

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance and instance:getStage() == 4 then
        mob:addListener('TAKE_DAMAGE', 'GEAR_TAKE_DAMAGE', function(mobArg, damage, attacker, attackType, damageType)
            if attackType ~= xi.attackType.RANGED then
                mobArg:independentAnimation(mob, 122, 0)
                mobArg:timer(4000, function(gearMob)
                    if gearMob and gearMob:isAlive() then
                        DespawnMob(gearMob:getID(), instance)
                    end
                end)
            end
        end)
    end
end

entity.onMobEngage = function(mob, target)
    local instance = mob:getInstance()

    if instance and instance:getStage() == 4 then
        local ce = 0
        local ve = 0
        ce = mob:getCE(target)
        ve = mob:getVE(target)

        if ce == 0 and ve == 0 then
            mob:independentAnimation(mob, 122, 0)
            mob:timer(4000, function(mobArg)
                if mobArg and mobArg:isAlive() then
                    DespawnMob(mobArg:getID(), instance)
                end
            end)
        end

        mob:removeListener('GEAR_TAKE_DAMAGE')
    end
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()

    if instance and instance:getStage() == 4 then
        if mob:getBattleTime() > 60 and mob:getLocalVar('teleport') == 0 then
            mob:setLocalVar('teleport', 1)
            mob:independentAnimation(mob, 122, 0)
            mob:timer(4000, function(mobArg)
                if mobArg and mobArg:isAlive() then
                    DespawnMob(mobArg:getID(), instance)
                end
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance and instance:getStage() == 4 then
            instance:setLocalVar('gearsKilled', instance:getLocalVar('gearsKilled') + 1)
            if instance:getLocalVar('gearsKilled') >= 10 then
                local mobID = mob:getID()
                -- east side
                if utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 17, 19)) then
                    instance:setLocalVar('dormantArea', 1)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(eastRampartPos[1])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 20, 21)) then
                    instance:setLocalVar('dormantArea', 2)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(eastRampartPos[2])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 22, 23)) then
                    instance:setLocalVar('dormantArea', 3)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(eastRampartPos[3])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 24, 26)) then
                    instance:setLocalVar('dormantArea', 4)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(eastRampartPos[4])
                -- west side
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 27, 29)) then
                    instance:setLocalVar('dormantArea', 5)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(westRampartPos[1])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 30, 31)) then
                    instance:setLocalVar('dormantArea', 6)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(westRampartPos[2])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 32, 33)) then
                    instance:setLocalVar('dormantArea', 7)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(westRampartPos[3])
                elseif utils.contains(mobID, utils.slice(ID.mob.ARCHAIC_GEAR, 34, 36)) then
                    instance:setLocalVar('dormantArea', 8)
                    GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setPos(westRampartPos[4])
                end

                GetNPCByID(ID.npc.DORMANT_RAMPART[4], instance):setStatus(xi.status.NORMAL)
            end
        end

        xi.salvage.spawnTempChest(mob)
    end
end

return entity
