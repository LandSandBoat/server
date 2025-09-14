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
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.INVINCIBLE, cooldown = 180, hpp = 50 }, -- "Has access to Invincible, which it may use several times."
        },
    })

    -- Change animation to humanoid w/ prismatic core
    mob:setAnimationSub(1)
    mob:setModelId(1169)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 73)
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar('delay')
    local lastCast = mob:getLocalVar('LAST_CAST')
    local spell = mob:getLocalVar('COPY_SPELL')

    if mob:getBattleTime() - lastCast > 30 then
        mob:setLocalVar('COPY_SPELL', 0)
        mob:setLocalVar('delay', 0)
    end

    -- Block usage of invincible if either kf'ghrah is alive
    local bothKfghrahDead = GetMobByID(ID.mob.KFGHRAH_WHM):isDead() and GetMobByID(ID.mob.KFGHRAH_BLM):isDead()
    if bothKfghrahDead then
        mob:setLocalVar('[jobSpecial]hpp_1', 50)
    else
        -- Set impossible HPP threshold while either kf'ghrah is alive
        mob:setLocalVar('[jobSpecial]hpp_1', 0)
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
