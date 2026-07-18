-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Dilapidated Gate
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('hits', 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if not (optParams.isKiller or optParams.noKiller) then
        return
    end

    local instance = mob:getInstance()
    if not instance then
        return
    end

    local mobId      = mob:getID()
    local gateBaseId = ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].DILAPIDATED_GATE
    local doorId

    if mobId == gateBaseId then
        doorId = ID.npc.DOOR_1
    elseif mobId == gateBaseId + 1 then
        doorId = ID.npc.DOOR_2
    elseif mobId == gateBaseId + 2 then
        doorId = ID.npc.DOOR_3
    end

    if doorId then
        local door = GetNPCByID(doorId, instance)
        if door then
            door:setAnimation(8)
        end
    end
end

return entity
