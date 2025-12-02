-----------------------------------
-- Area: The Garden of Ru'Hmet
--   NM: Jailer of Faith
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
local gardenGlobal = require('scripts/zones/The_Garden_of_RuHmet/globals')
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    -- Change animation to open
    mob:setAnimationSub(2)
    mob:setLocalVar('changeTime', GetSystemTime() + 180)
    mob:setMod(xi.mod.DMG, 1250) -- +12.5% damage taken with mouth open
    mob:addMod(xi.mod.DEF, 100)
    mob:setMod(xi.mod.EVA, math.floor(mob:getEVA() * 0.275)) -- +27.5% EVA
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)

    xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.MANAFONT, cooldown = math.random(60, 240) } } })
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
    local changeTime = mob:getLocalVar('changeTime')

    if GetSystemTime() > changeTime then
        -- Change close to open.
        if mob:getAnimationSub() == 1 then
            -- Euvhi deal 50% extra base damage with mouth open
            local damage = 1 + mob:getMainLvl() / 2
            mob:setMobMod(xi.mobMod.WEAPON_BONUS, damage)
            mob:setAnimationSub(2)
            mob:setMod(xi.mod.DMG, 1250) -- +12.5% damage taken with mouth open
            mob:setLocalVar('changeTime', GetSystemTime() + 180)
        else -- Change from open to close
            mob:setAnimationSub(1)
            mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
            mob:setMod(xi.mod.DMG, -2500) -- -25% damage taken with mouth closed
            mob:setLocalVar('changeTime', GetSystemTime() + 60)
        end
    end
end

entity.onMobDeath = function(mob)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FAITH):setPos(unpack(gardenGlobal.qmPosFaithTable[math.random(1, 5)]))
end

return entity
