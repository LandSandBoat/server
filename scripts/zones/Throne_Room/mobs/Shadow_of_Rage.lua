-----------------------------------
-- Area: Throne Room
--  Mob: Shadow of Rage
-- Bastok mission 9-2 BCNM Fight (Phase 2)
-----------------------------------
local ID = zones[xi.zone.THRONE_ROOM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    -- 50% chance to immediately TP move again (but only once per chain)
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'SHADOW_TP_CHAIN', function(mobEntity, skillID)
        local justChained = mobEntity:getLocalVar('justChained')

        -- Only allow chaining if this wasn't already a chained TP move
        if justChained == 0 and math.random(1, 100) <= 50 then
            mobEntity:setTP(3000)
            mobEntity:setLocalVar('justChained', 1) -- Mark this as a chained TP
        else
            -- Reset the chained flag for next potential chain
            mobEntity:setLocalVar('justChained', 0)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefieldArea = mob:getBattlefield():getArea()
        local areaOffset = (battlefieldArea - 1) * 4
        local zeid2Id = ID.mob.ZEID_BCNM_OFFSET + areaOffset + 1
        local zeid2 = GetMobByID(zeid2Id)

        -- Set clone respawn if it's not already set
        if zeid2 and zeid2:isAlive() then
            local currentRespawnTime = zeid2:getLocalVar('petRespawnTime')
            local currentTime = GetSystemTime()

            if currentRespawnTime == 0 or currentTime >= currentRespawnTime then
                zeid2:setLocalVar('petRespawnTime', currentTime + 60)
            end
        end
    end
end

return entity
