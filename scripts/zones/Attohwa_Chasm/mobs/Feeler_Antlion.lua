-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Feeler Antlion
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.REGAIN, 40) -- Don't know exact value
    mob:addMod(xi.mod.REGEN, 100) -- Regen is 2% of HP per tick; intense HP regen
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)

    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('SAND_BLAST', 1)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId = skill:getID()
    local alastor = GetMobByID(ID.mob.ALASTOR_ANTLION)

    -- Sand Pit pops the next Executioner Antlion 3 seconds later, under the Feeler's target.
    if skillId == xi.mobSkill.SANDPIT_1 then
        mob:timer(3000, function(mobArg)
            local ambushTarget = mobArg:getTarget()
            if not ambushTarget then
                return
            end

            for _, executionerId in ipairs(ID.mob.EXECUTIONER_ANTLION) do
                local executioner = GetMobByID(executionerId)
                if executioner and not executioner:isSpawned() then
                    local pos = ambushTarget:getPos()

                    executioner:setSpawn(pos.x, pos.y, pos.z)
                    SpawnMob(executionerId):updateEnmity(ambushTarget)
                    break
                end
            end
        end)

    -- Sand Blast pops Alastor Antlion the same way, once per Feeler.
    elseif
        skillId == xi.mobSkill.SANDBLAST_1 and
        mob:getLocalVar('SAND_BLAST') == 1 and
        alastor and
        not alastor:isSpawned()
    then
        mob:setLocalVar('SAND_BLAST', 0)
        mob:timer(3000, function(mobArg)
            local ambushTarget = mobArg:getTarget()
            if not ambushTarget then
                return
            end

            local pos = ambushTarget:getPos()

            alastor:setSpawn(pos.x, pos.y, pos.z)
            SpawnMob(ID.mob.ALASTOR_ANTLION):updateClaim(ambushTarget)
        end)
    end
end

entity.onMobDespawn = function(mob)
    if attohwaChasmGlobal.canStartFeelerQMTimer() then
        GetNPCByID(ID.npc.QM_FEELER_ANTLION):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
