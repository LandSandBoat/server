-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Fortitude
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, cooldown = 180, hpp = math.random(90, 95) }, -- "Has access to Invincible, which it may use several times."
        },
    })

    -- Change animation to humanoid w/ prismatic core
    mob:setAnimationSub(1)
    mob:setModelId(1169)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('delay')
    local lastCast = mob:getLocalVar('LAST_CAST')
    local spell = mob:getLocalVar('COPY_SPELL')

    if mob:getBattleTime() - lastCast > 30 then
        mob:setLocalVar('COPY_SPELL', 0)
        mob:setLocalVar('delay', 0)
    end

    if
        not GetMobByID(ID.mob.KFGHRAH_WHM):isDead() or
        not GetMobByID(ID.mob.KFGHRAH_BLM):isDead()
    then
        -- check for kf'ghrah
        if spell > 0 and not mob:hasStatusEffect(xi.effect.SILENCE) then
            if delay >= 3 then
                mob:castSpell(spell)
                mob:setLocalVar('COPY_SPELL', 0)
                mob:setLocalVar('delay', 0)
            else
                mob:setLocalVar('delay', delay + 1)
            end
        end
    end
end

entity.onMagicHit = function(caster, target, spell)
    if
        spell:tookEffect() and
        (caster:isPC() or caster:isPet()) and
        spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE
    then
        -- Handle mimicked spells
        target:setLocalVar('COPY_SPELL', spell:getID())
        target:setLocalVar('LAST_CAST', target:getBattleTime())
        target:setLocalVar('reflectTime', target:getBattleTime())
        target:setAnimationSub(1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawn the pets if alive
    DespawnMob(ID.mob.KFGHRAH_WHM)
    DespawnMob(ID.mob.KFGHRAH_BLM)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FORTITUDE):setPos(unpack(gardenGlobal.qmPosFortTable[math.random(1, 5)]))
end

return entity
