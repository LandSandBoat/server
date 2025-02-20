-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = zones[xi.zone.VALLEY_OF_SORROWS]
mixins =
{
    require('scripts/mixins/rage'),
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

local intoShell = function(mob)
    mob:setLocalVar('changeTime', os.time() + 90)
    mob:setAnimationSub(1)
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.REGEN, 130)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

local outOfShell = function(mob)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobSpawn = function(mob)
    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)

    outOfShell(mob) -- Ensure out of shell mods are set on spawn

    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setLocalVar('dmgToChange', mob:getHP() - 1000)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.UDMGMAGIC, -3000)
    mob:setMod(xi.mod.CURSERES, 100)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 45) -- 130 total weapon damage
    mob:setMod(xi.mod.DEF, 702)
    mob:setMod(xi.mod.ATT, 395)
    mob:setMod(xi.mod.EVA, 310)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    -- Aspid changes shell state at 1000 HP intervals based on what HP it was at when it last changed shell
    -- If it in its shell, it will come out of shell at the damage threshold, reaching 100% HP, or 90 seconds have passed
    local changeHP = mob:getLocalVar('dmgToChange')

    if -- In shell
        mob:getAnimationSub() == 1 and
        (os.time() > mob:getLocalVar('changeTime') or
        mob:getHPP() == 100)
    then
        outOfShell(mob)
        mob:setAnimationSub(2)
        mob:setTP(3000) -- Immediately TPs coming out of shell
    end

    if
        changeHP ~= 0 and
        mob:getHP() <= changeHP
    then
        mob:setLocalVar('dmgToChange', 0)

        if mob:getAnimationSub() == 1 then
            outOfShell(mob)
            mob:setAnimationSub(2)
            mob:setTP(3000) -- Immediately TPs coming out of shell
        elseif
            mob:getAnimationSub() == 2 or
            mob:getAnimationSub() == 0
        then
            intoShell(mob)
        end

        -- Complete shell exit/enter animation then set hp change var
        mob:timer(1500, function(mobArg)
            mobArg:setLocalVar('dmgToChange', mob:getHP() - 1000)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
