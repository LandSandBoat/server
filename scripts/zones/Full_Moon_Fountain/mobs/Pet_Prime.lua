-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Pet Prime
-- BCNM: Battaru Royale (ASA-10). Each clone's avatar: one astral flow, then gone.
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------
---@type TMobEntity
local entity = {}

-- In each area's order: Flames, Torrents, Boulders, Gusts, Sparks, Glaciers, Lights, Shadows.
local cloneFlows =
{
    xi.mobSkill.INFERNO_1,
    xi.mobSkill.TIDAL_WAVE_1,
    xi.mobSkill.EARTHEN_FURY_1,
    xi.mobSkill.AERIAL_BLAST_1,
    xi.mobSkill.JUDGMENT_BOLT_1,
    xi.mobSkill.DIAMOND_DUST_1,
    xi.mobSkill.SEARING_LIGHT_1,
    xi.mobSkill.HOWLING_MOON_2,
}

-- The avatar sits one id above its clone, and each area holds sixteen ids.
local function onTick(avatar)
    local currentTime = GetSystemTime()
    if currentTime >= avatar:getLocalVar('despawnAt') then
        DespawnMob(avatar:getID())
        return
    end

    if xi.combat.behavior.isEntityBusy(avatar) then
        return
    end

    local flowAt = avatar:getLocalVar('flowAt')
    if flowAt == 0 or currentTime < flowAt then
        return
    end

    local clone = GetMobByID(avatar:getID() - 1)
    if not clone then
        return
    end

    local target = clone:getTarget()
    if not target then
        return
    end

    avatar:setLocalVar('flowAt', 0)
    avatar:useMobAbility(cloneFlows[(clone:getID() - ID.mob.CLONE_OF_FLAMES) % 16 / 2 + 1], target)
end

entity.onMobInitialize = function(mob)
    mob:addListener('WEAPONSKILL_STATE_EXIT', 'ASA_AVATAR_FLOW', function(avatar, skillId, wasExecuted)
        -- Observed on retail: the avatar is gone three seconds after landing its flow.
        avatar:setLocalVar('flowAt', 0)
        avatar:setLocalVar('despawnAt', GetSystemTime() + 3)
    end)
end

entity.onMobSpawn = function(mob)
    local currentTime = GetSystemTime()

    mob:setMobMod(xi.mobMod.NO_MOVE, 1)

    -- Observed on retail: the avatar readies its flow two seconds after appearing.
    mob:setLocalVar('flowAt', currentTime + 2)

    -- TODO: Capture needed, an avatar that never lands its flow leaves after 15 seconds.
    mob:setLocalVar('despawnAt', currentTime + 15)
end

entity.onMobRoam = function(mob)
    onTick(mob)
end

entity.onMobFight = function(mob, target)
    onTick(mob)
end

return entity
