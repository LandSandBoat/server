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
    mob:setMobMod(xi.mobMod.SUPERLINK, mob:getTargID())
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.ATT, 721)
    mob:setMod(xi.mod.DEF, 833)
    mob:setMod(xi.mod.STORETP, 100)
    mob:setMod(xi.mod.QUICK_MAGIC, 100) -- Spells are returned instantly.
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MODIFIER, 68)

    mob:setLocalVar('ghrahChangeTime', 0)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.INVINCIBLE_1, cooldown = 150, hpp = 50 }, -- Uses Invincible every 150 seconds when HP is below 50%.
        },
    })
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('ghrahChangeTime', GetSystemTime() + 45)
end

entity.onMobFight = function(mob, target)
    local ghrahWHM = GetMobByID(ID.mob.KFGHRAH_WHM)
    local ghrahBLM = GetMobByID(ID.mob.KFGHRAH_BLM)

    if
        not ghrahWHM or
        not ghrahBLM
    then
        return
    end

    -- If both Ghrah are dead, nothing to do here.
    if
        ghrahWHM:isDead() and
        ghrahBLM:isDead()
    then
        return
    end

    -- Both Ghrah always change into the same form, at the same form. The same form can be chosen more than once in a row.
    local currentTime     = GetSystemTime()
    local ghrahChangeTime = mob:getLocalVar('ghrahChangeTime')

    if currentTime < ghrahChangeTime then
        return
    end

    mob:setLocalVar('ghrahChangeTime', currentTime + 45)

    -- Forms - 0 = Ball, 2 = Spider, 3 = Bird. 1 is skipped because it's human form which these do not turn into.
    local chosenForm = utils.randomEntry({ 0, 2, 3 })

    if ghrahWHM:isAlive() then
        ghrahWHM:setLocalVar('desiredForm', chosenForm)
    end

    if ghrahBLM:isAlive() then
        ghrahBLM:setLocalVar('desiredForm', chosenForm)
    end
end

-- When both pets are alive, magic is returned immediately back at the caster.
entity.onMagicHit = function(caster, target, spell)
    local ghrahWHM = GetMobByID(ID.mob.KFGHRAH_WHM)
    local ghrahBLM = GetMobByID(ID.mob.KFGHRAH_BLM)

    if
        not ghrahWHM or
        not ghrahBLM
    then
        return
    end

    if
        ghrahWHM:isDead() and
        ghrahBLM:isDead()
    then
        return
    end

    if
        spell:tookEffect() and
        spell:getSpellGroup() ~= xi.magic.spellGroup.BLUE
    then
        target:castSpell(spell:getID(), caster)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawn the pets if alive
    DespawnMob(ID.mob.KFGHRAH_WHM)
    DespawnMob(ID.mob.KFGHRAH_BLM)
end

entity.onMobDespawn = function(mob)
    -- Move QM to random location
    GetNPCByID(ID.npc.QM_JAILER_OF_FORTITUDE):setPos(unpack(gardenGlobal.qmPosFortTable[math.randomInt(1, 5)]))
end

return entity
