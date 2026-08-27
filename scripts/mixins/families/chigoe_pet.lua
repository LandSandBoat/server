-- Chigoe(pet) family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

-- Hosts spawn one chigoe per TP move unless listed here.
local chigoesPerUse =
{
    [xi.mobPool.MOSSHORN]  = 2, -- Rams shed two at a time.
    [xi.mobPool.PEALLAIDH] = 2,
}

g_mixins.families.chigoe_pet = function(hostMob)
    local ID = zones[hostMob:getZoneID()]

    hostMob:addListener('WEAPONSKILL_USE', 'MOB_SPAWN_CHIGOE', function(mob, target, skill, tp, action, damage)
        -- AoE TP moves fire this once per target hit. Only the primary target's hit sheds.
        if not target or target:getID() ~= skill:getPrimaryTargetID() then
            return
        end

        local mobName = mob:getName()

        -- Requires a Chigoe.lua with the chigoe mixin for this to work
        if ID.mob.CHIGOES[mobName] == nil then
            return
        end

        local hostID = mob:getID()

        -- Hosts share the pool. Count only the chigoes this host put out.
        local aliveChigoes = 0
        for _, mobID in pairs(ID.mob.CHIGOES[mobName]) do
            local chigoe = GetMobByID(mobID)

            if
                chigoe and
                chigoe:isSpawned() and
                chigoe:getLocalVar('chigoeHost') == hostID
            then
                aliveChigoes = aliveChigoes + 1
            end
        end

        -- Retail caps each host at 5 of its own chigoes.
        local numChigoesToSpawn = math.min(chigoesPerUse[mob:getPool()] or 1, 5 - aliveChigoes)
        if numChigoesToSpawn <= 0 then
            return
        end

        -- Self-targeted TP moves like rage pass the host itself as the target.
        if target:getID() == hostID then
            target = mob:getTarget()
        end

        for _, mobID in pairs(ID.mob.CHIGOES[mobName]) do
            local chigoe = GetMobByID(mobID)

            if chigoe and not chigoe:isSpawned() then
                chigoe:setSpawn(hostMob:getXPos() + math.randomInt(-2, 2), hostMob:getYPos(), hostMob:getZPos() + math.randomInt(-2, 2), hostMob:getRotPos())
                chigoe:spawn()
                chigoe:setLocalVar('chigoeHost', hostID)
                if target then
                    chigoe:updateEnmity(target)
                end

                chigoe:addListener('DISENGAGE', 'CHIGOE_PET_DESPAWN', function(mobArg)
                    DespawnMob(mobArg:getID())
                    mobArg:removeListener('CHIGOE_PET_DESPAWN')
                end)

                numChigoesToSpawn = numChigoesToSpawn - 1
                if numChigoesToSpawn == 0 then
                    return
                end
            end
        end
    end)
end

return g_mixins.families.chigoe_pet
