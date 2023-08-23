-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut v2
-- BCNM: Wyrmking Descends
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local wyrms    = { 16896158, 16896159, 16896160, 16896161 }
local percents = { 90, 80, 70, 60, 50, 40, 30, 20 }
local adds     = { 80, 60, 40, 20 }

local flare = function(mob, target, level)
    local flareWait = mob:getLocalVar("FlareWait")
    local tauntShown = mob:getLocalVar("tauntShown")

    mob:setMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
    mob:setMagicCastingEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setLocalVar("autoOffSource", 2)

    if flareWait == 0 and tauntShown == 0 then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
        mob:setLocalVar("tauntShown", 1)
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

            mob:timer(3000, function(mobArg)
                if mobArg:isAlive() then
                    mobArg:setMobAbilityEnabled(true)
                    mobArg:setMagicCastingEnabled(true)
                    mobArg:setAutoAttackEnabled(true)
                end
            end)
        end

        mob:setLocalVar("FlareWait", mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
    elseif flareWait < mob:getBattleTime() and flareWait ~= 0 and tauntShown >= 0 then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
        if tauntShown == 1 and level == 0 then
            mob:setLocalVar("tauntShown", 2) -- if Megaflare gets stunned it won't show the text again, until successful use.
        end

        if mob:checkDistance(target) <= 15 then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
            if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then -- default behaviour
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
            end

            if level == 0 then
                mob:useMobAbility(1551) -- Megaflare
            elseif level == 1 then
                mob:useMobAbility(1552) -- Gigaflare
            else
                mob:useMobAbility(1553) -- Teraflare
            end

            mob:setLocalVar("flareQueued", 0)
        end
    end
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 10)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 56) -- (Level92 + 2) + 56 = 150
    -- gives firaga iv a cast time of ~2 seconds as per retail
    -- note baha has a job trait with fast cast of 15% so 75% total
    mob:setMod(xi.mod.UFASTCAST, 60)
    -- 425 + str bonus is 475 total attack
    mob:setMod(xi.mod.ATT, 425)
    mob:setMod(xi.mod.INT, 30)
    -- need to subject MATT to offset the MAB trait from BLM job
    mob:addMod(xi.mod.MATT, -28)
    -- Bahamut should use tp move every 20 sec
    mob:addMod(xi.mod.REGAIN, 450)
    mob:addMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.MDEF, 62)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setLocalVar("gigaFlareCount", 3)

    local randomWyrm = utils.shuffle(wyrms)
    mob:setLocalVar("wyrmOne", randomWyrm[1])
    mob:setLocalVar("wyrmTwo", randomWyrm[2])
    mob:setLocalVar("wyrmThree", randomWyrm[3])
    mob:setLocalVar("wyrmFour", randomWyrm[4])
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local flareTrigger = mob:getLocalVar("flareTrigger")
    local addsSummoned = mob:getLocalVar("addsSummoned")
    local summoning = mob:getLocalVar("summoning")

    for i = 1, #percents do
        if mob:getHPP() < percents[i] and flareTrigger < i then
            mob:setLocalVar("flareTrigger", flareTrigger + 1)
        end
    end

    if summoning == 0 then
        -- Summon adds even when stunned (as the case on retail mobs as well)
        for i = 1, #adds do
            if mob:getHPP() < adds[i] and addsSummoned < i then
                mob:setLocalVar("summoning", 1)
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
                        -- increment initially due to lua indexing starting from one
                        local nextAddIndex = mob:getLocalVar("addsSummoned") + 1
                        local wyrmOne = mob:getLocalVar("wyrmOne")
                        local wyrmTwo = mob:getLocalVar("wyrmTwo")
                        local wyrmThree = mob:getLocalVar("wyrmThree")
                        local wyrmFour = mob:getLocalVar("wyrmFour")
                        local wyrmOrder = { wyrmOne, wyrmTwo, wyrmThree, wyrmFour }
                        local wyrm = GetMobByID(wyrmOrder[nextAddIndex])
                        wyrm:spawn()
                        local bahaTarget = mobArg:getTarget()
                        if bahaTarget then
                            wyrm:updateEnmity(bahaTarget)
                        end

                        mobArg:setLocalVar("addsSummoned", nextAddIndex)
                        mobArg:setLocalVar("summoning", 0)
                    end
                end)
            end
        end
    end

    if mob:canUseAbilities() then
        -- Megaflare
        if
            mob:getLocalVar("megaFlareCount") < flareTrigger and
            flareTrigger < 4
        then
            flare(mob, target, 0)
        -- Gigaflare
        elseif
            mob:getLocalVar("gigaFlareCount") < flareTrigger and
            flareTrigger > 3
        then
            mob:setLocalVar("flareQueued", 1)
            flare(mob, target, 1)
        -- Teraflare
        elseif
            mob:getHPP() < 10 and
            mob:getLocalVar("TeraFlare") < 1 and
            mob:checkDistance(target) <= 15
        then
            mob:setLocalVar("flareQueued", 1)
            flare(mob, target, 2)
        end
    end

    -- Make sure if Wyrms deaggro that they assist Bahamut's target
    for i = ID.mob.BAHAMUT_V2 + 1, ID.mob.BAHAMUT_V2 + 4 do
        local wyrm = GetMobByID(i)
        if wyrm:getCurrentAction() == xi.act.ROAMING then
            wyrm:updateEnmity(target)
        end
    end

    -- Bahamut should use tp move every 20 sec
    -- decrease regain under 25% to keep approx timing
    if mob:getHPP() <= 25 then
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
    mob:setLocalVar("autoOffSource", 1)
    mob:timer(9000, function(mobArg)
        -- if auto attacks were turned off due to a tp move
        if mob:getLocalVar("autoOffSource") == 1 then
            mob:setAutoAttackEnabled(true)
        end
    end)
end

entity.onMobDisengage = function(mob)
    -- In case of wipe during Flares, this will reset Bahamut
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
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
            local bahaAdd = GetMobByID(ID.mob.BAHAMUT_V2 + i)
            if bahaAdd:isAlive() then
                bahaAdd:setHP(0)
            end
        end
    end
end

return entity
