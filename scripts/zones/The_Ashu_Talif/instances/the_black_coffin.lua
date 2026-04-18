-----------------------------------
-- TOAU-15: The Black Coffin
-- !instance 6000
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
local instanceObject = {}

local crewTable =
{
    -- The Black Coffin - Wave 1
    [1] =
    {
        ID.mob.ASHU_CREW_OFFSET,
        ID.mob.ASHU_CREW_OFFSET + 1,
        ID.mob.ASHU_CREW_OFFSET + 2,
        ID.mob.ASHU_CREW_OFFSET + 3,
        ID.mob.ASHU_CREW_OFFSET + 4,
    },
    -- The Black Coffin - Wave 2
    [2] =
    {
        ID.mob.ASHU_CAPTAIN_OFFSET,
        ID.mob.ASHU_CAPTAIN_OFFSET + 1,
        ID.mob.ASHU_CAPTAIN_OFFSET + 2,
        ID.mob.ASHU_CAPTAIN_OFFSET + 3,
        ID.mob.ASHU_CAPTAIN_OFFSET + 4,
    },
}

instanceObject.registryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and
        player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instanceObject.entryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.THE_BLACK_COFFIN and
        player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instanceObject.onInstanceCreated = function(instance)
    instance:setProgress(0)
    instance:setLocalVar('wave2Spawned', 0)
    SpawnMob(ID.mob.GESSHO, instance)
    for _, mobId in pairs(crewTable[1]) do
        SpawnMob(mobId, instance)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:delKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, char in pairs(chars) do
        char:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        char:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    -- 2nd Wave: Spawn all mobs and apply transition logic with a delay before mobs are targetable
    if progress >= 5 and instance:getLocalVar('wave2Spawned') == 0 then
        instance:setLocalVar('wave2Spawned', 1)

        for _, mobId in pairs(crewTable[2]) do
            SpawnMob(mobId, instance)

            if mobId ~= ID.mob.ASHU_CAPTAIN_OFFSET then
                local mob = GetMobByID(mobId, instance)
                if mob then
                    mob:setUntargetable(true)
                    mob:hideName(true)
                    mob:stun(5000)
                    mob:timer(5000, function(m)
                        m:setUntargetable(false)
                        m:hideName(false)
                    end)
                end
            end
        end

        -- Gessho automatically engages the 2nd wave if he is alive
        local gessho = GetMobByID(ID.mob.GESSHO, instance)
        if gessho and gessho:isAlive() then
            gessho:timer(5000, function(gesshoMob)
                gesshoMob:updateEnmity(GetMobByID(crewTable[2][2], instance))
            end)
        end

        -- Captain jumps down after 10s (message + animation) then lands at 12s
        local captain = GetMobByID(ID.mob.ASHU_CAPTAIN_OFFSET, instance)
        if captain then
            captain:timer(10000, function(m)
                m:setLocalVar('jump', 1)
                m:showText(m, ID.text.OVERPOWERED_CREW)
                m:entityAnimationPacket(xi.animationString.JUMP_0)
            end)

            captain:timer(12000, function(m)
                local pos = { x = 0, y = -22, z = 13, rot = 192 }
                m:setLocalVar('jump', 2)
                m:setPos(pos.x, pos.y, pos.z, pos.rot)
                m:setSpawn(pos.x, pos.y, pos.z, pos.rot)
                m:entityAnimationPacket(xi.animationString.JUMP_1)
                m:showText(m, ID.text.TEST_YOUR_BLADES)
                m:timer(2000, function(captainArg)
                    captainArg:hideName(false)
                    captainArg:setUntargetable(false)
                    captainArg:setMobMod(xi.mobMod.NO_MOVE, 0)
                end)
            end)
        end
    end
end

instanceObject.onInstanceComplete = function(instance)
    local players = instance:getChars()

    local gessho = GetMobByID(ID.mob.GESSHO, instance)
    if gessho then
        gessho:setBehavior(bit.band(gessho:getBehavior(), bit.bnot(xi.behavior.NO_DESPAWN)))
        DespawnMob(ID.mob.GESSHO, instance)
    end

    for _, mobId in pairs(crewTable[2]) do
        DespawnMob(mobId, instance)
    end

    for i, player in pairs(players) do
        if
            player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and
            player:getMissionStatus(xi.mission.log_id.TOAU) == 1
        then
            player:setMissionStatus(xi.mission.log_id.TOAU, 2)
        end

        player:startEvent(102)
    end
end

return instanceObject
