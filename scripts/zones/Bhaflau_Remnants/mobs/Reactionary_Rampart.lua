-----------------------------------
-- Area: Reactionary Rampart
-- MOB: Bhaflau Remnants Floor 1
-- Spawns a mob every 10 - 15 seconds
-- Low chance of spawning NMs
-- Will teleport party at 0% even if mobs are spawned from it alive
-----------------------------------

local pos =
{
    [1] =
    {
        [1] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 420, 16, -291,  64 },
        },
        [2] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 451, 16, -460, 255 },
        },
        [3] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 260, 16, -291,  64 },
        },
        [4] =
        {
            enter = { -340, 0, -530, 192 },
            exit  = { 229, 16, -460, 129 },
        },
    },
    [2] =
    {
        [1] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = {  309, -4, 260,  0 },
        },
        [2] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 340, -4, 229, 197 },
        },
        [3] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 371, -4, 260, 126 },
        },
        [4] =
        {
            enter = { -340, 0, -233, 64 },
            exit  = { 340, -4,  291, 63 },
        },
    },
    [3] =
    {
        [1] =
        {
            enter = { 260, 0.5, 114 , 192 },
            exit  = { -300, -4, -420,   0 },
        },
        [2] =
        {
            enter = { 260, 0.5,  114, 192 },
            exit  = { -380, -4, -420, 128 },
        },
    },
    [4] =
    {
        [1] =
        {
            enter = { 420,  0, 114, 192 },
            exit  = { -300, 0, -75, 192 },
        },
        [2] =
        {
            enter = { 420, 0, 114, 192 },
            exit  = { -315, -4, 20,  0 },
        },
        [3] =
        {
            enter = {  420,  0, 114, 192 },
            exit  = { -220, -4, 125, 192 },
        },
        [4] =
        {
            enter = { 420,  0, 114, 192 },
            exit  = { -300, 0, 195,  64 },
        },
        [5] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -380, 0, -75, 192 },
        },
        [6] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -365, -4, 20, 128 },
        },
        [7] =
        {
            enter = {  420,  0, 114, 192 },
            exit  = { -460, -4, 125, 192 },
        },
        [8] =
        {
            enter = {  420, 0, 114, 192 },
            exit  = { -380, 0, 195,  64 },
        },
    },
}

---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 0)
    mob:setMobMod(xi.mobMod.ROAM_TURNS, 0)
    mob:setMod(xi.mod.UDMGMAGIC, 1600)
    mob:setMod(xi.mod.UDMGPHYS, 160)
    mob:setMod(xi.mod.UDMGRANGE, 160)
--    mob:addStatusEffect(xi.effect.NO_REST, 1, 0, 0)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.SCENT)
    -- 70/30 split to be able to spawn a NM or not into rotation
    local canSpawnNM = 700
    if math.random(1000) > canSpawnNM then
        mob:setLocalVar('noSpawnNM', 1)
    end
end

entity.onMobEngaged = function(mob, target)
    mob:setAnimationSub(1)
    mob:setLocalVar('next', GetSystemTime())
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    local now = GetSystemTime()
    local next = mob:getLocalVar('next')

    if instance and now > next then
        local offset = mob:getID()
        for petid = offset + 1, offset + 5 do
            if not GetMobByID(petid, instance):isSpawned() then
                mob:setLocalVar('spawn', petid)
                mob:useMobAbility(2034)
                break
            end

            mob:setLocalVar('spawn', 0)
        end

        mob:setLocalVar('next', now + math.random(10, 15))
        mob:setHP(mob:getHP() - (mob:getMaxHP() / 100))

        local petid = mob:getLocalVar('spawn')
        if petid > 0 then
            mob:setLocalVar('spawn', 0)
            local nm = GetMobByID(offset + 6, instance)
            mob:timer(2500, function(mobArg)
                if not mobArg or mobArg:isDead() then
                    return
                end

                -- NM logic to insert into spawn next
                if mobArg:getLocalVar('noSpawnNM') == 0 then
                    if math.random(100) > 97 and not nm:isSpawned() then
                        petid = offset + 6
                    end
                end

                SpawnMob(petid, instance)
                local pet = GetMobByID(petid, instance)
                local targ = mobArg:getTarget()
                if targ then
                    pet:updateEnmity(targ)
                end
            end)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()

        if instance then
            local chars = instance:getChars()

            instance:setLocalVar('destination', 2) -- used for exit logic

            for i = mob:getID() + 1, mob:getID() + 6 do
                DespawnMob(i, instance)
            end

            for _, players in pairs(chars) do
                players:startCutscene(5)
            end
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 5 then
        local instance = player:getInstance()

        if instance then
            local stage = instance:getStage()
            local section = instance:getLocalVar('dormantArea')
            local sendTo = pos[stage][section].exit
            if sendTo then
                player:setPos(unpack(sendTo))
            end
        end
    end
end

return entity
