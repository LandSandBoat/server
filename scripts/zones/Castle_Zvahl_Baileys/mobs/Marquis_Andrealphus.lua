-----------------------------------
-- Area: Castle Zvahl Baileys (161)
-- NM: Marquis Andrealphus
-- Quest: Better The Demon You Know
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local zvahlID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
---@type TMobEntity
local entity = {}

local doSubstitute = function(mob, target)
    local hpp = mob:getHPP()

    -- Interaction with pets/trusts is currently unknown, set to only activate if the target is a PC
    if
        hpp <= 66 and
        target:isPC()
    then
        mob:useMobAbility(xi.mobSkill.SUBSTITUTE) -- Casts "Escape" on the currently tanking player
        mob:setLocalVar('castEscape', 1)
        mob:messageText(mob, zvahlID.text.BEGONE_FROM_THESE_HALLS)
    elseif
        hpp <= 33 and
        target:isPC()
    then
        mob:useMobAbility(xi.mobSkill.SUBSTITUTE) -- Casts "Escape" on the currently tanking player
        mob:setLocalVar('castEscape', 2)
        mob:messageText(mob, zvahlID.text.BEGONE_FROM_THESE_HALLS)
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- Will agro any player reguardless of level
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()
    local escapePlayer = mob:getLocalVar('castEscape')

    -- When the NM's health hits ~66% and ~33% it will attempt to cast escape on whoever is currently tanking
    if
        hpp <= 66 and
        escapePlayer == 0
    then
        doSubstitute(mob, target)
    elseif
        hpp <= 33 and
        escapePlayer < 2
    then
        doSubstitute(mob, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- Despawns the "Demon Banneret" and "Demon Secretary" adds
    local mobId = mob:getID()

    for i = mobId + 1, mobId + 4 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

entity.onMobDespawn = function(mob)
    -- Despawns the "Demon Banneret" and "Demon Secretary" adds
    local mobId = mob:getID()

    for i = mobId + 1, mobId + 4 do
        if GetMobByID(i):isSpawned() then
            DespawnMob(i)
        end
    end
end

return entity
