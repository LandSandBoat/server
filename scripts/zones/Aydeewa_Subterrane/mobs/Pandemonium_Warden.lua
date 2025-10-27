-----------------------------------
-- Area: Aydeewa Subterrane
--  ZNM: Pandemonium Warden
--
-- !pos 200 33 -140 68
-- Spawn by trading Pandemonium key: !additem 2572
-- Wiki: https://ffxiclopedia.fandom.com/wiki/Pandemonium_Warden
--       https://www.bg-wiki.com/ffxi/Pandemonium_Warden
-- Videos: https://youtu.be/oOCCjH8isiA
--         https://youtu.be/T_Us2Tmlm-E
--         https://youtu.be/fvgG8zfqr2o
--         https://youtu.be/BPbsHhbi4LE
--
-- Notes: See Pandemonium_Warden_HNM.lua for details on intermediate phases. This file will refer specifically to the behavior of this mob's short sequences between phases and the final form
--        spawns and immediately performs his sequence:
--          Cannot be damaged, doesn't autoattack/cast
--          calls 6 corpselight pets, which do nothing but follow their target
--          uses cackle
--          uses hellsnap
--          disappears himself and Lamps (pets)
--          Other mobId spawns in the particular phase, with fresh enmity table
--          when mob is defeated, does the same thing as before
--
--        When final intermediate phase is defeated, PW appears in final form
--          calls all 8 base pets in Dverger form
--          can be damaged/killed
--          pets and himself have access to BLM spells and Dverger mobskills
--          performs an astral flow sequence every 25% hp
--            calls secondary pet group: amount based on living Lamps + himself (i.e if he has 4 lamps up, he will call 5 avatars)
--            12s later PW will AF and his avatars will use their respective abilities and die
--              Everyone except tank should be prepared to get away when this happens, though there's plenty of time to run away unless you get stun locked by pet spells
--              "All avatars are summoned at once, and with them plus the lamps up, its hard to move your character."
--              "You will probably get locked in place and die from game mechanics alone."
-- TODO pet groups are: first 8 for all phase pets, final 9 are specifically for astral flow avatars
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
---@type TMobEntity
local entity = {}

local despawnPL = function()
    for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
        DespawnMob(petId)
        local pet = GetMobByID(petId)
        if pet then
            -- spawn listener will be added when next phase starts
            pet:removeListener('SET_PET_PROPERTIES')

            pet:setAutoAttackEnabled(false)
            pet:setMobAbilityEnabled(false)
            pet:setMagicCastingEnabled(false)
        end
    end
end

local despawnPW = function(mob)
    if mob and mob:isSpawned() then
        DespawnMob(mob:getID())
    end

    local pwHNM = mob and GetMobByID(mob:getID() + 1)
    if pwHNM and pwHNM:isSpawned() then
        DespawnMob(pwHNM:getID())
    end

    despawnPL()
end

-- used when determining if a phase has enough pets out (dead but still spawned pets count towards total)
local spawnedLamps = function()
    local petCount = 0
    for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
        local pet = GetMobByID(petId)
        if pet and pet:isSpawned() then
            petCount = petCount + 1
        end
    end

    return petCount
end

-- used when performing astral flow, living pets count towards avatar total
local livingLamps = function()
    local petCount = 0
    for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
        local pet = GetMobByID(petId)
        if pet and pet:isAlive() then
            petCount = petCount + 1
        end
    end

    return petCount
end

local resetFight = function(mob)
    -- Prevent death and hide HP until final phase
    mob:hideHP(true)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)

    -- only uses the sequence moves, otherwise just follows around looking at you menacingly
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)

    mob:setLocalVar('phase', 1)
    mob:setLocalVar('astralFlowsUsed', 0)

    -- Update pet properties based on phase
    mob:triggerListener('UNHIDE', mob)
end

-- skill sequence: cackle, hellsnap, disappear for HNM phase
-- doesn't perform on final phase
-- guard clauses in case PWDespawnTime is hit during phase change
local phaseSequence = function(mob)
    if mob:getLocalVar('phase') > 10 then
        return
    end

    -- incrementing phase is handled by Pandemonium_Warden_HNM.lua only if it is brought to 1% hp
    local timerDelay = 1000
    mob:timer(timerDelay, function(mobArg)
        if not mobArg:isSpawned() then
            return
        end

        mobArg:useMobAbility(xi.mobSkill.CACKLE)
    end)

    -- 8 seconds after cackle
    timerDelay = timerDelay + 8000
    mob:timer(timerDelay, function(mobArg)
        if not mobArg:isSpawned() then
            return
        end

        mobArg:useMobAbility(xi.mobSkill.HELLSNAP)
    end)

    -- 5 seconds after hellsnap
    timerDelay = timerDelay + 5000
    mob:timer(timerDelay, function(mobArg)
        if not mobArg:isSpawned() then
            return
        end

        mobArg:setStatus(xi.status.INVISIBLE)

        despawnPL()
    end)

    -- 3s later, HNM spawns
    timerDelay = timerDelay + 3000
    mob:timer(timerDelay, function(mobArg)
        local pwHNM = GetMobByID(mob:getID() + 1)
        if not mobArg:isSpawned() or not pwHNM then
            return
        end

        pwHNM:spawn()
    end)
end

entity.onMobInitialize = function(mob)
    -- "If all individuals who have developed enmity die, Pandemonium Warden will return to his spawn point, with his train of lamps, and will not be aggressive to any non-combat action"
    mob:setAggressive(false)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.ALLI_HATE, 30)

    -- Custom listener to trigger when spawning and unhiding from Pandemonium_Warden_HNM.lua
    mob:addListener('UNHIDE', 'PW_STATUS_CHANGE', function(mobArg)
        mobArg:setStatus(xi.status.UPDATE)
        local target = mobArg:getTarget()
        if target then
            mob:updateClaim(target)
        end

        -- Update pet parameters for PW dverger phases
        local lampModel  = 1839
        local skillList  = 361
        local spellList  = 560
        local petsNeeded = 8
        if mobArg:getLocalVar('phase') <= 10 then
            lampModel  = 1841
            skillList  = 0
            spellList  = 0
            petsNeeded = 6
        else
            -- final phase
            mob:hideHP(false)
            mob:setUnkillable(false)
            mob:setMod(xi.mod.UDMGPHYS, 0)
            mob:setMod(xi.mod.UDMGRANGE, 0)
            mob:setMod(xi.mod.UDMGBREATH, 0)
            mob:setMod(xi.mod.UDMGMAGIC, 0)

            mob:setMobAbilityEnabled(true)
            mob:setAutoAttackEnabled(true)
            mob:setMagicCastingEnabled(true)
        end

        for _, petId in ipairs(ID.mob.PANDEMONIUM_LAMPS) do
            local pet = GetMobByID(petId)
            if pet then
                -- skill/spell list has to be set after spawn
                pet:addListener('SPAWN', 'SET_PET_PROPERTIES', function(petArg)
                    petArg:setModelId(lampModel)
                    if skillList > 0 then
                        petArg:setMobMod(xi.mobMod.SKILL_LIST, skillList)
                        petArg:setMobAbilityEnabled(true)
                        petArg:setAutoAttackEnabled(true)
                    else
                        -- before final phase, they just follow around looking at you menacingly
                        petArg:setMobAbilityEnabled(false)
                        petArg:setAutoAttackEnabled(false)
                    end

                    if spellList == 0 then
                        petArg:setMagicCastingEnabled(false)
                    else
                        petArg:setSpellList(spellList)
                        petArg:setMagicCastingEnabled(true)
                    end
                end)
            end
        end

        -- call initial pets immediately
        -- they will be resummoned as needed in onMobFight
        -- - intermediate phases: as soon as they despawn
        -- - final phase: 60s between
        local callPetParams =
        {
            noAnimation = true,
            maxSpawns = petsNeeded - spawnedLamps(),
            ignoreBusy = true,
            dieWithOwner = true,
        }
        xi.mob.callPets(mobArg, ID.mob.PANDEMONIUM_LAMPS, callPetParams)
        -- small time gate to avoid calling xi.mob.callPets in onMobFight on the same tick
        mobArg:setLocalVar('petTimer', GetSystemTime() + 1)

        if mobArg:isEngaged() then
            phaseSequence(mobArg)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DEF, 450)
    mob:setMod(xi.mod.MEVA, 380)
    mob:setMod(xi.mod.MDEF, 50)

    -- small delay to not interfere with "something draws near"
    mob:timer(1000, function(mobArg)
        mobArg:showText(mobArg, ID.text.PW_WHO_DARES)
    end)

    -- Two hours to forced depop from spawn
    mob:setLocalVar('PWDespawnTime', GetSystemTime() + 7200)
    -- reset all properties (including the listener we created above)
    resetFight(mob)
end

entity.onMobDisengage = function(mob)
    resetFight(mob)
end

entity.onMobEngage = function(mob, target)
    phaseSequence(mob)
end

entity.onMobFight = function(mob, target)
    -- Check for time limit. This will despawn both PW mobs and all pets
    if GetSystemTime() > mob:getLocalVar('PWDespawnTime') then
        despawnPW(mob)
        return
    end

    -- stays engaged but invisible during HNM phases
    if mob:getStatus() > xi.status.UPDATE then
        return
    end

    if target then
        local drawInTable =
        {
            conditions =
            {
                mob:checkDistance(target) >= 10,
            },
            position = mob:getPos(),
        }
        utils.drawIn(target, drawInTable)
    end

    -- Init Vars
    local mobHPP = mob:getHPP()
    local phase  = mob:getLocalVar('phase')

    -- Intermediate phase sequence
    if phase <= 10 then
        -- PW brings out lamps as they despawn from previous phase
        local petsOut = spawnedLamps()
        if
            petsOut < 6 and
            mob:getLocalVar('petTimer') < GetSystemTime()
        then
            local callPetParams =
            {
                noAnimation = true,
                maxSpawns = 6 - petsOut,
                ignoreBusy = true,
                dieWithOwner = true,
            }

            -- small time gate to avoid calling this at the same time as the UNHIDE listener
            if xi.mob.callPets(mob, ID.mob.PANDEMONIUM_LAMPS, callPetParams) then
                mob:setLocalVar('petTimer', GetSystemTime() + 1)
            end
        end

        return
    end

    -- after intermediate phase logic because isEntityBusy considers timers as busy
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- final phase
    local astrals = mob:getLocalVar('astralFlowsUsed')
    if
        mobHPP < 100 - 25 * (1 + astrals) and
        GetSystemTime() > mob:getLocalVar('nextAstralFlow')
    then
        -- Calls X avatars (up to 9 with all lamps alive)
        local petsNeeded = 1 + livingLamps()
        local callPetParams =
        {
            inactiveTime = 5000,
            maxSpawns = petsNeeded,
            ignoreBusy = true,
            dieWithOwner = true,
        }

        if xi.mob.callPets(mob, utils.shuffle(ID.mob.PANDEMONIUM_AVATARS), callPetParams) then
            -- the avatar AF abilities are used by the mixin within Pandemonium_Lamp_Avatar.lua
            local actionTimer = callPetParams.inactiveTime + 11000
            mob:timer(actionTimer, function(mobArg)
                -- injects a fake action of "PW readies astral flow" before avatars use their respective abilities
                mobArg:injectActionPacket(mob:getID(), xi.action.MOBABILITY_START, 438, 0, 0x18, xi.msg.basic.READIES_WS, 0, xi.mobSkill.ASTRAL_FLOW_1)
                -- injects the packet to end the animation
                mobArg:injectActionPacket(mob:getID(), xi.action.MOBABILITY_FINISH, 438, 0, 0x18, xi.msg.basic.NONE, 0, xi.mobSkill.ASTRAL_FLOW_1)
            end)

            -- Increment astral
            mob:setLocalVar('astralFlowsUsed', astrals + 1)
            -- PW won't use another AF immediately even if HP is chunked into next quarter
            mob:setLocalVar('nextAstralFlow', GetSystemTime() + 30)
        end
    else
        -- normal final phase combat ticks
        local petsOut = spawnedLamps()
        local callPetParams =
        {
            noAnimation = true,
            maxSpawns = 1,
            dieWithOwner = true,
        }

        -- TODO what is the actual pet resummon timer?
        if
            petsOut == #ID.mob.PANDEMONIUM_LAMPS or
            (mob:getLocalVar('petTimer') < GetSystemTime() and
            xi.mob.callPets(mob, ID.mob.PANDEMONIUM_LAMPS, callPetParams))
        then
            -- tap pet summon timer so he resummons 60s after
            -- - last pet death when full on pets
            -- - last pet summon when pets aren't all out
            mob:setLocalVar('petTimer', GetSystemTime() + 60)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.PANDEMONIUM_QUELLER)
    end

    if optParams.isKiller or optParams.noKiller then
        mob:showText(mob, ID.text.PW_WHO_DARES + 1)
    end
end

entity.onMobDespawn = function(mob)
    despawnPW(mob)
end

return entity
