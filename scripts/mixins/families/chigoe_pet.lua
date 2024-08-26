-- Chigoe(pet) family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe_pet = function(hostMob)
    local ID = zones[hostMob:getZoneID()]

    hostMob:addListener('WEAPONSKILL_USE', 'MOB_SPAWN_CHIGOE', function(mob, target)
        local mobName = mob:getName()

        -- Requires a Chigoe.lua with the chigoe mixin for this to work
        if ID.mob.CHIGOES[mobName] == nil then
            return
        end

        for _, mobID in pairs(ID.mob.CHIGOES[mobName]) do
            local chigoe = GetMobByID(mobID)

            if chigoe and not chigoe:isSpawned() then
                chigoe:setSpawn(hostMob:getXPos() + math.random(-2, 2), hostMob:getYPos() + math.random(-2, 2), hostMob:getZPos() + math.random(-2, 2), hostMob:getRotPos())
                chigoe:spawn()
                if target then
                    chigoe:updateEnmity(target)
                end

                chigoe:addListener('DISENGAGE', 'CHIGOE_DISENGAGE', function(mobArg)
                    DespawnMob(mobArg:getID())
                    mobArg:removeListener('CHIGOE_DISENGAGE')
                end)

                return
            end
        end
    end)
end

return g_mixins.families.chigoe_pet
