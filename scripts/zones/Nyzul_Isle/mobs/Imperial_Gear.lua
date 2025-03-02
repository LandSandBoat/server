-----------------------------------
-- Area: Nyzul Isle (Path of Darkness)
--  Mob: Imperial Gear
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local progress = instance:getProgress()

    if progress >= 24 then
        local mobs = instance:getMobs()

        for i, v in pairs(mobs) do
            if v:getID() == ID.mob.AMNAF_BLU then
                local pos = v:getPos()

                if mob:getID() == ID.mob.IMPERIAL_GEAR_OFFSET then
                    mob:setPos(pos.x + 2, pos.y, pos.z, pos.rot)
                elseif mob:getID() == ID.mob.IMPERIAL_GEAR_OFFSET + 1 then
                    mob:setPos(pos.x, pos.y, pos.z + 2, pos.rot)
                elseif mob:getID() == ID.mob.IMPERIAL_GEAR_OFFSET + 2 then
                    mob:setPos(pos.x - 2, pos.y, pos.z, pos.rot)
                elseif mob:getID() == ID.mob.IMPERIAL_GEAR_OFFSET + 3 then
                    mob:setPos(pos.x, pos.y, pos.z - 2, pos.rot)
                end
            end
        end
    end
end

entity.onMobEngage = function(mob, target)
    local naja = GetMobByID(ID.mob.NAJA_SALAHEEM, mob:getInstance())

    if naja then
        naja:setLocalVar('ready', 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
