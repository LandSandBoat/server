-----------------------------------
-- Area: Boneyard Gully
--  Mob: Parata
--  ENM: Shell We Dance?
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local mobId  = mob:getID()
    local mobHPP = mob:getHPP()
    local adds   = mob:getLocalVar('adds')
    local petId  = 0

    -- Pet #1 spawn at 95% hp or less
    if mobHPP <= 95 and adds == 0 then
        petId = mobId + 2

    -- Pet #2 spawn at 60% hp or less
    elseif mobHPP <= 60 and adds == 1 then
        petId = mobId + 3

    -- Pet #3 spawn at 40% hp or less
    elseif mobHPP <= 40 and adds == 2 then
        petId = mobId + 4
    end

    -- If we have spawned a pet
    if petId > 0 then
        mob:setLocalVar('adds', adds + 1)

        local pet = SpawnMob(petId)
        if pet then
            battlefield:insertEntity(pet:getTargID(), false, true)
            pet:updateEnmity(target)

            local pos = mob:getPos()
            pet:setPos(pos.x, pos.y, pos.z, pos.rot)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Kill adds.
    if optParams.isKiller or optParams.noKiller then
        local mobId = mob:getID()
        for i = 2, 4 do
            local pet = GetMobByID(mobId + i)
            if pet and pet:isAlive() then
                pet:setHP(0)
            end
        end
    end
end

return entity
