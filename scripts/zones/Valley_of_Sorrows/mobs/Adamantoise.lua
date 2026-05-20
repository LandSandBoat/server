-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Adamantoise
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

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 17000)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    -- Note: The BLU spell 1000 Needles from players also "has no effect", but there is no immunity for this at the moment.
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 90)
end

entity.onMobSpawn = function(mob)
    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)

    mob:setMod(xi.mod.DEF, 4112)
    mob:setMod(xi.mod.ATT, 450)
    mob:setMod(xi.mod.DMGMAGIC, -3500)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200) -- This lines up much closer with retail capture damage better than the set weapon damage numbers from the HNM sheet.
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.TORTOISE_TORTURER)
    end
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
