-----------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.VUNKERL_INLET_S]
-----------------------------------
local entity = {}

local function callTigerPet(mob, target)
    local act         = mob:getCurrentAction()
    local petsSpawned = mob:getLocalVar('petsSpawned')
    local isBusy      = false

    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH
    then
        isBusy = true
    end

    if
        mob:actionQueueEmpty() and
        not isBusy
    then
        if petsSpawned ~= 1 then
            -- Begin casting animation
            mob:timer(1000, function(mobArg)
                mobArg:entityAnimationPacket('casm')
            end)

            -- End casting animation
            mob:timer(4000, function(mobArg)
                mobArg:entityAnimationPacket('shsm')

                -- If any of the pets are down, spawn them and assign enmity
                for _, tigerPet in ipairs(ID.mob.PALLASS_TIGER) do
                    local petId = GetMobByID(tigerPet)

                    if not petId:isSpawned() then
                        mob:setLocalVar('petsSpawned', 1)
                        mob:setLocalVar('respawnTime', os.time() + math.random(45, 60))
                        petId:setSpawn(mob:getXPos() + math.random(1, 3), mob:getYPos(), mob:getZPos() + math.random(1, 3))

                        if target ~= nil then
                            SpawnMob(petId:getID()):updateEnmity(target)
                        else
                            petId:spawn()
                        end
                    end
                end
            end)
        end
    end
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.FAMILIAR, cooldown = 60, hpp = 50 },
        },
    })

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'AWAKEN_PETS', function(mobArg, skillId)
        local familiarId = 740

        if skillId == familiarId then
            for _, tigerPet in ipairs(ID.mob.PALLASS_TIGER) do
                local petId = GetMobByID(tigerPet)

                if petId:isAlive() then
                    petId:delStatusEffect(xi.effect.SLEEP_I)
                    petId:delStatusEffect(xi.effect.SLEEP_II)
                    petId:delStatusEffect(xi.effect.LULLABY)
                    petId:addMod(xi.mod.SLEEPRES, 80)
                end
            end
        end
    end)

    callTigerPet(mob)
end

entity.onMobEngaged = function(mob, target)
    for _, tigerPet in ipairs(ID.mob.PALLASS_TIGER) do
        local petId = GetMobByID(tigerPet)

        if petId:isAlive() then
            petId:updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    if
        mob:getLocalVar('petsSpawned') ~= 1 and
        os.time() >= mob:getLocalVar('respawnTime')
    then
        callTigerPet(mob, target)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    for _, tigerPet in ipairs(ID.mob.PALLASS_TIGER) do
        DespawnMob(tigerPet)
    end

    xi.hunts.checkHunt(mob, player, 489)
end

return entity
