-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Vampyr Jarl (Einherjar)
-- Notes: Immune to Bind/Gravity/Blind/Silence
-- Casts every 30 seconds
-- About every 2 minutes, upon using Nocturnal Servitude, will split into 6x Bats or 6x Wolves
-- The mobs will run around for 2 minutes, before pathing to a common location and "merging" back into Jarl
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
local vampyrWolf = zones[xi.zone.HAZHALM_TESTING_GROUNDS].mob.VAMPYR_WOLF
local vampyrBats = zones[xi.zone.HAZHALM_TESTING_GROUNDS].mob.VAMPYR_BATS
-----------------------------------
---@type TMobEntity
local entity = {}

local function despawnAllAdds()
    local allAdds = {}

    for _, id in ipairs(vampyrBats) do
        table.insert(allAdds, id)
    end

    for _, id in ipairs(vampyrWolf) do
        table.insert(allAdds, id)
    end

    for _, mobId in ipairs(allAdds) do
        local add = GetMobByID(mobId)
        if add and add:isSpawned() then
            DespawnMob(mobId)
        end
    end
end

local function vanish(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMobMod(xi.mobMod.NO_REST, 1)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setStatus(xi.status.INVISIBLE)
    mob:hideName(true)
    mob:setUntargetable(true)
end

local function reset(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.NO_AGGRO, 0)
    mob:setMobMod(xi.mobMod.NO_REST, 0)
    mob:hideName(false)
    mob:setUntargetable(false)
    mob:setStatus(xi.status.UPDATE)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
end

local function disableInteractions(mob)
    mob:disengage()
    mob:setMobMod(xi.mobMod.NO_AGGRO, 1)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)
end

local function allAddsGrouped(mob, jarl)
    local mobIds = jarl:getLocalVar('addsFamily') == 1 and vampyrBats or vampyrWolf

    for _, mobId in ipairs(mobIds) do
        if mobId ~= mob:getID() then
            local add = GetMobByID(mobId)
            if add and add:isAlive() then
                if mob:checkDistance(add) > 5 then
                    return false
                end
            end
        end
    end

    return true
end

local function onAddRoam(jarl, mob)
    local despawnTime   = mob:getLocalVar('despawnAt')
    local isPathingHome = mob:getLocalVar('isPathingHome')

    -- One of the 6 adds is invincible and will not engage
    if mob:getLocalVar('invincible') ~= 0 then
        disableInteractions(mob)
    end

    if despawnTime >= os.time() and not mob:isFollowingPath() then
        local pos = mob:getPos()
        mob:pathTo(pos.x + math.random(-30, 30), pos.y, pos.z + math.random(-30, 30), bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
        return
    end

    if despawnTime <= os.time() then
        local jarlPos = jarl:getPos()
        mob:pathTo(jarlPos.x, jarlPos.y, jarlPos.z, bit.bor(xi.pathflag.RUN, xi.pathflag.SCRIPT))
        if isPathingHome == 0 then
            disableInteractions(mob)
            mob:setLocalVar('isPathingHome', 1)
        else
            -- If all adds are grouped, despawn. This will make Jarl reappear.
            if allAddsGrouped(mob, jarl) then
                DespawnMob(mob:getID())
            elseif mob:checkDistance(jarl) < 5 then
                -- Wait for other adds to catch up
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
                mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
                mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 0)
            end
        end
    end
end

local function onAddDeath(jarl, mob)
    if jarl:isAlive() then
        -- Unclear if it's possible for Jarl to die while hidden
        local newHpp = math.max(jarl:getHPP() - 6, 1)
        jarl:setHP(jarl:getMaxHP() * newHpp / 100)
    end
end

local function onAddFight(mob)
    if mob:getLocalVar('invincible') ~= 0 then
        mob:disengage()
    end

    if mob:getLocalVar('despawnAt') <= os.time() then
        disableInteractions(mob)
    end
end

local function checkReappear(mob)
    if mob:getStatus() == xi.status.INVISIBLE then
        local addsMobs = mob:getLocalVar('addsFamily') == 1 and vampyrBats or vampyrWolf

        local allAddsDespawned = utils.all(addsMobs, function(_, mobId)
            local add = GetMobByID(mobId)
            return add and not add:isSpawned()
        end)

        if allAddsDespawned then
            reset(mob)
            mob:setLocalVar('nextTransform', os.time() + 120)
        end
    end
end

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
end

-- Should not be necessary but just in case, ensure all adds are despawned
entity.onMobDespawn = despawnAllAdds
entity.onMobSpawn   = despawnAllAdds

entity.onMobEngage  = function(mob, target)
    if mob:getLocalVar('nextTransform') == 0 then
        mob:setLocalVar('nextTransform', os.time() + 120)
    end

    reset(mob)
end

-- Check if adds are gone and we should reappear
entity.onMobFight = checkReappear
entity.onMobRoam  = checkReappear

entity.onMobWeaponSkill = function(target, mob, skill)
    -- If Nocturnal Servitude and timer is up, spawn a random set of adds
    if
        skill:getID() == xi.mobSkill.NOCTURNAL_SERVITUDE and
        mob:getLocalVar('nextTransform') <= os.time()
    then
        local selectedMobs
        vanish(mob)
        if math.random(1, 2) == 1 then
            selectedMobs = vampyrBats
            mob:setLocalVar('addsFamily', 1)
        else
            selectedMobs = vampyrWolf
            mob:setLocalVar('addsFamily', 2)
        end

        local randomInvincibleMob = utils.randomEntry(selectedMobs)
        -- Set up and spawn each add
        -- Tag the invincible add
        utils.each(selectedMobs, function(_, mobId)
            local add = GetMobByID(mobId)
            if add then
                add:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos())
                add:addListener('DEATH', 'JARL_DEATH', utils.bind(onAddDeath, mob))
                add:addListener('ROAM_TICK', 'JARL_ROAM', utils.bind(onAddRoam, mob))
                add:addListener('COMBAT_TICK', 'JARL_COMBAT_TICK', onAddFight)
                add:spawn()
                add:setLocalVar('despawnAt', os.time() + 120)
                if mobId == randomInvincibleMob then
                    add:setLocalVar('invincible', 1)
                end
            end
        end)
    end
end

return entity
