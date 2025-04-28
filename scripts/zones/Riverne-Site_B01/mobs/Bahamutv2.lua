-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut v2
-- BCNM: Wyrmking Descends
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TMobEntity
local entity = {}

local wyrms    = { ID.mob.BAHAMUTV2 + 1, ID.mob.BAHAMUTV2 + 2, ID.mob.BAHAMUTV2 + 3, ID.mob.BAHAMUTV2 + 4 }
local megaFlareHPPs = { 90, 80, 70 }
local gigaFlareHPPs = { 60, 50, 40, 30, 20 }
local spawnAddHPPs  = { 80, 60, 40, 20 }

-- function that handles the logic of doing a flare mobskill (mega, giga, tera)
local function doFlare(mob, target, level)
    local flareWait = mob:getLocalVar('FlareWait')
    local tauntShown = mob:getLocalVar('tauntShown')

    -- disable all other abilities until the flare is used successfully
    mob:setMobAbilityEnabled(false)

    -- if there is a pedending flare and the last flare has been used successfully
    -- or if the first flare has not been used yet
    if flareWait == 0 and tauntShown == 0 then
        mob:setLocalVar('tauntShown', 1)
        if level == 0 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT)
        elseif level == 1 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 13)
        elseif level == 2 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 14)
            mob:timer(1000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 15)
                end
            end)

            mob:timer(2000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 16)
                end
            end)

            -- incase of interrupted flare make sure abilities are turned back on
            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:setMobAbilityEnabled(true)
                end
            end)
        end

        -- second taunt happens two seconds after the first.
        mob:setLocalVar('FlareWait', mob:getBattleTime() + 2)
    -- the wait time between the first and second taunt has passed
    -- also check for flareWait to be non-zero because it is set to 0 on successful use
    elseif flareWait < mob:getBattleTime() and flareWait ~= 0 and tauntShown >= 0 then
        if tauntShown == 1 and level == 0 then
            -- if megaflare gets stunned it won't show the text again, until successful use
            mob:setLocalVar('tauntShown', 2)
        end

        -- without this check if the target is out of range it will keep attemping and failing to use flare
        -- both megaflare and gigaflare have range of 15 yalms
        if mob:checkDistance(target) <= 15 then
            if bit.band(mob:getBehavior(), xi.behavior.NO_TURN) > 0 then -- default behaviour
                mob:setBehavior(bit.band(mob:getBehavior(), bit.bnot(xi.behavior.NO_TURN)))
            end

            if level == 0 then
                mob:useMobAbility(1551) -- Megaflare
            elseif level == 1 then
                mob:useMobAbility(1552) -- Gigaflare
            else
                mob:useMobAbility(1553) -- Teraflare
            end
        end
    end
end

local function performSummoningCheck(mob, mobHPP, target)
    local isSummoning = 0
    local prevAddIndex = mob:getLocalVar('prevAddIndex')
    -- summon adds even when stunned
    for i = 1, #spawnAddHPPs do
        if mobHPP < spawnAddHPPs[i] and prevAddIndex < i then
            mob:setLocalVar('isSummoning', 1)
            isSummoning = 1
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)

            -- show the wyrm call animation
            mob:injectActionPacket(mob:getID(), 11, 1144, 0, 0x18, 0, 1550, 0)

            mob:timer(1000, function(mobArg)
                mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 6)
            end)

            mob:timer(2000, function(mobArg)
                mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 7)
            end)

            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    -- get the index of the wyrm to summon
                    local addIndexToSpawn = mob:getLocalVar('prevAddIndex') + 1
                    local wyrmOne = mobArg:getLocalVar('wyrmOne')
                    local wyrmTwo = mobArg:getLocalVar('wyrmTwo')
                    local wyrmThree = mobArg:getLocalVar('wyrmThree')
                    local wyrmFour = mobArg:getLocalVar('wyrmFour')
                    local wyrmOrder = { wyrmOne, wyrmTwo, wyrmThree, wyrmFour }
                    local wyrm = GetMobByID(wyrmOrder[addIndexToSpawn])
                    if wyrm then
                        wyrm:spawn()
                        local bahaTarget = mobArg:getTarget()
                        if bahaTarget then
                            wyrm:updateEnmity(bahaTarget)
                        end
                    end

                    mobArg:setLocalVar('prevAddIndex', addIndexToSpawn)
                    mobArg:setLocalVar('isSummoning', 0)
                end
            end)

            -- break to only spawn one add at a time
            break
        end
    end

    return isSummoning
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 45)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 156)

    mob:setMod(xi.mod.UFASTCAST, 15)
    mob:setMod(xi.mod.ATT, 376)
    mob:setMod(xi.mod.INT, 21)
    mob:setMod(xi.mod.MATT, 12)
    mob:addMod(xi.mod.REGAIN, 450)
    mob:addMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.MDEF, 62)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
    -- set these here to make sure no issues if previously killed during a flare mobskill
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)

    -- set the random order of summoning the different wyrms
    local randomWyrm = utils.shuffle(wyrms)
    mob:setLocalVar('wyrmOne', randomWyrm[1])
    mob:setLocalVar('wyrmTwo', randomWyrm[2])
    mob:setLocalVar('wyrmThree', randomWyrm[3])
    mob:setLocalVar('wyrmFour', randomWyrm[4])
end

entity.onMobFight = function(mob, target)
    local isSummoning = mob:getLocalVar('isSummoning')
    local mobHPP = mob:getHPP()

    if isSummoning == 0 then
        isSummoning = performSummoningCheck(mob, mobHPP, target)
    end

    local isBusy = false
    local currentAction = mob:getCurrentAction()

    if
        currentAction == xi.act.MOBABILITY_START or
        currentAction == xi.act.MOBABILITY_USING or
        currentAction == xi.act.MOBABILITY_FINISH or
        currentAction == xi.act.MAGIC_START or
        currentAction == xi.act.MAGIC_CASTING or
        currentAction == xi.act.MAGIC_FINISH or
        isSummoning == 1
    then
        isBusy = true -- is set to true if Bahamut is in any stage of using a mobskill, casting a spell, or summoning
    end

    -- if Megaflare hasn't been set to be used this many times, increase the queue of Megaflares.
    -- This will allow it to use multiple Megaflares in a row if the HP is decreased quickly enough.
    local megaFlareTrigger = mob:getLocalVar('MegaFlareTrigger')
    for trigger, hpp in ipairs(megaFlareHPPs) do
        if mobHPP < hpp and megaFlareTrigger < trigger then
            mob:setLocalVar('MegaFlareTrigger', trigger)
            mob:setLocalVar('MegaFlareQueue', mob:getLocalVar('MegaFlareQueue') + 1)
        end
    end

    -- if gigaflare hasn't been set to be used this many times, increase the queue of gigaflares.
    -- This will allow it to use multiple gigaflares in a row if the HP is decreased quickly enough.
    local gigaFlareTrigger = mob:getLocalVar('GigaFlareTrigger')
    for trigger, hpp in ipairs(gigaFlareHPPs) do
        if mobHPP < hpp and gigaFlareTrigger < trigger then
            mob:setLocalVar('GigaFlareTrigger', trigger)
            mob:setLocalVar('GigaFlareQueue', mob:getLocalVar('GigaFlareQueue') + 1)
        end
    end

    local megaFlareQueue = mob:getLocalVar('MegaFlareQueue')
    local gigaFlareQueue = mob:getLocalVar('GigaFlareQueue')

    -- the last check prevents multiple Mega/Gigaflares from being called at the same time.
    if mob:actionQueueEmpty() and not isBusy then
        -- under 10% just spam Teraflare
        if
            mobHPP < 10 and
            mob:checkDistance(target) <= 15 and
            os.time() > mob:getLocalVar('lastTeraFlareTime') + 20
        then
            doFlare(mob, target, 2)
        -- otherwise prioritize any Gigaflares
        elseif
            gigaFlareQueue > 0 and
            mob:checkDistance(target) <= 15
        then
            doFlare(mob, target, 1)
        -- finally use any Megaflares
        elseif
            megaFlareQueue > 0 and
            mob:checkDistance(target) <= 15
        then
            doFlare(mob, target, 0)
        end
    end

    -- make sure if Wyrms deaggro that they assist Bahamut's target
    for i = ID.mob.BAHAMUTV2 + 1, ID.mob.BAHAMUTV2 + 4 do
        local wyrm = GetMobByID(i)
        if wyrm and wyrm:getCurrentAction() == xi.act.ROAMING then
            wyrm:updateEnmity(target)
        end
    end

    -- Bahamut should use tp move every 20 sec (this is special mechanic that some mobs have)
    -- decrease regain under 25% to keep approximately the same timing
    if mobHPP <= 25 then
        if mob:getMod(xi.mod.REGAIN) ~= 150 then
            mob:setMod(xi.mod.REGAIN, 150)
        end
    else
        if mob:getMod(xi.mod.REGAIN) ~= 450 then
            mob:setMod(xi.mod.REGAIN, 450)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- pause auto attacks after tp move for about 9 sec
    mob:setAutoAttackEnabled(false)
    mob:timer(9000, function(mobArg)
        mobArg:setAutoAttackEnabled(true)
    end)
end

entity.onMobDisengage = function(mob)
    -- in case of wipe during Flares, this will reset Bahamut
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 17)
        mob:timer(3000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 18)
        end)

        mob:timer(6000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 19)
        end)

        mob:timer(9000, function(mobArg)
            mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 20)
        end)

        for i = 1, 16 do
            -- the adds die rather than just despawn
            local bahaAdd = GetMobByID(ID.mob.BAHAMUTV2 + i)
            if bahaAdd and bahaAdd:isAlive() then
                bahaAdd:setHP(0)
            end
        end
    end
end

return entity
