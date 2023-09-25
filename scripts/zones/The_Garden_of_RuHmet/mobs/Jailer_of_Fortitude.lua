-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Fortitude
-----------------------------------
local ID = require("scripts/zones/The_Garden_of_RuHmet/IDs")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/limbus")
require("scripts/globals/magic")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Change animation to humanoid w/ prismatic core
    mob:setAnimationSub(1)
    mob:setModelId(1169)
    mob:setMod(xi.mod.ATT, 716)
    mob:setMod(xi.mod.DEF, 836)
    mob:setMod(xi.mod.EVA, 250)
end

entity.onMobEngaged = function(mob, target)
    mob:setLocalVar("delay", 0)
    mob:setLocalVar("LAST_CAST", 0)
    mob:setLocalVar("COPY_SPELL", 0)
    mob:setLocalVar("twoHourCd", 0)
    local mobId = mob:getID()
    for i = mobId + 1, mobId + 2 do -- Kf'ghrah share hate with Jailer of Fortitude
        GetMobByID(i):updateEnmity(target)
    end
end

entity.onMobFight = function(mob, target)
    local delay = mob:getLocalVar("delay")
    local lastCast = mob:getLocalVar("LAST_CAST")
    local spell = mob:getLocalVar("COPY_SPELL")

    if mob:getBattleTime() - lastCast > 30 then
        mob:setLocalVar("COPY_SPELL", 0)
        mob:setLocalVar("delay", 0)
    end

    if
        not GetMobByID(ID.mob.KFGHRAH_WHM):isDead() or
        not GetMobByID(ID.mob.KFGHRAH_BLM):isDead()
    then
        -- check for kf'ghrah
        if spell > 0 and not mob:hasStatusEffect(xi.effect.SILENCE) then
            if delay >= 3 then
                mob:castSpell(spell)
                mob:setLocalVar("COPY_SPELL", 0)
                mob:setLocalVar("delay", 0)
            else
                mob:setLocalVar("delay", delay + 1)
            end
        end
    end

    -- Jailer of Fortitude does not use Invincible until he is below 50% HP and both Ghrah adds are dead.
    -- He will immediately use invincible upon both of them dying then again 3 minutes later.
    local canTwoHour = mob:getLocalVar("canTwoHour")
    local twoHourCd = mob:getLocalVar("twoHourCd")
    local battleTime = mob:getBattleTime()
    for i = ID.mob.KFGHRAH_WHM, ID.mob.KFGHRAH_BLM do
        local kfgrah = GetMobByID(i)
        if not kfgrah:isAlive() and mob:getHPP() < 50 and canTwoHour == 0 then
            mob:setLocalVar("canTwoHour", 1) -- both Kf'ghrah dead, first invincible
        end
    end

    if mob:getLocalVar("canTwoHour") == 1 then
        if battleTime - twoHourCd > 180 then -- second invincible roughly 3 minutes after the first
            mob:setLocalVar("twoHourCd", mob:getBattleTime())
            mob:useMobAbility(694)
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
        target:setLocalVar("COPY_SPELL", spell:getID())
        target:setLocalVar("LAST_CAST", target:getBattleTime())
        target:setLocalVar("reflectTime", target:getBattleTime())
        target:setAnimationSub(1)
    end

    return 1
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawn the pets if alive
    DespawnMob(ID.mob.KFGHRAH_WHM)
    DespawnMob(ID.mob.KFGHRAH_BLM)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FORTITUDE):setPos(unpack(ID.npc.QM_JAILER_OF_FORTITUDE_POS[math.random(1, 5)]))
end

return entity
