-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

local megaflareHPP =
{
    90, 80, 70, 60, 50, 40, 30, 20,
}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 50)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 10)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 51) -- (lvl 83 + 2) + 51 = 136
    -- gives firaga iv a cast time of ~2 seconds as per retail
    -- note baha has a job trait with fast cast of 15% so 75% total
    mob:setMod(xi.mod.UFASTCAST, 60)
    mob:setMod(xi.mod.ATT, 425)
    mob:setMod(xi.mod.INT, 30)
    mob:addMod(xi.mod.MATT, -28)
    -- Bahamut should use tp move every 20 sec
    mob:addMod(xi.mod.REGAIN, 450)
    mob:addMod(xi.mod.REGEN, 50)
    mob:setMod(xi.mod.MDEF, 62)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 20)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 20)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setAutoAttackEnabled(true)
end

entity.onMobEngaged = function(mob, target)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local megaFlareQueue = mob:getLocalVar("MegaFlareQueue")
    local megaFlareTrigger = mob:getLocalVar("MegaFlareTrigger")
    local flareWait = mob:getLocalVar("FlareWait")
    local gigaFlare = mob:getLocalVar("GigaFlare")
    local tauntShown = mob:getLocalVar("tauntShown")
    local mobHPP = mob:getHPP()
    local isBusy = false
    local act = mob:getCurrentAction()

    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH or
        act == xi.act.MAGIC_START or
        act == xi.act.MAGIC_CASTING or
        act == xi.act.MAGIC_START
    then
        isBusy = true -- is set to true if Bahamut is in any stage of using a mobskill or casting a spell
    end

    -- if Megaflare hasn't been set to be used this many times, increase the queue of Megaflares. This will allow it to use multiple Megaflares in a row if the HP is decreased quickly enough.
    for trigger, hpp in ipairs(megaflareHPP) do
        if mobHPP < hpp and megaFlareTrigger < trigger then
            mob:setLocalVar("MegaFlareTrigger", trigger)
            mob:setLocalVar("MegaFlareQueue", megaFlareQueue + 1)
            break
        end
    end

    -- The last check prevents multiple Mega/Gigaflares from being called at the same time.
    if mob:actionQueueEmpty() and not isBusy then
        if megaFlareQueue > 0 then
            mob:setMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
            mob:setMagicCastingEnabled(false)
            mob:setAutoAttackEnabled(false)

            -- If there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
            if flareWait == 0 and tauntShown == 0 then
                target:showText(mob, ID.text.BAHAMUT_TAUNT)
                -- Second taunt happens two seconds after the first.
                mob:setLocalVar("FlareWait", mob:getBattleTime() + 2)
                mob:setLocalVar("tauntShown", 1)
                -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
            elseif flareWait < mob:getBattleTime() and flareWait ~= 0 and tauntShown >= 0 then
                if tauntShown == 1 then
                    -- if Megaflare gets stunned it won't show the text again, until successful use.
                    mob:setLocalVar("tauntShown", 2)
                    target:showText(mob, ID.text.BAHAMUT_TAUNT + 1)
                end

                -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                if mob:checkDistance(target) <= 15 then
                    -- default behaviour
                    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
                    end

                    mob:useMobAbility(1551)
                    mob:setLocalVar("MegaFlareQueue", 0)
                end
            end

        -- All of the scripted Megaflares are to happen before Gigaflare.
        elseif
            megaFlareQueue == 0 and
            mobHPP < 10 and gigaFlare < 1 and
            mob:checkDistance(target) <= 15
        then
            -- again, taunt won't show again until the move is successfully used.
            if tauntShown == 0 then
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 2)
                mob:setLocalVar("tauntShown", 3)
            end

            -- default behaviour
            if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
            end

            mob:useMobAbility(1552)
            mob:setLocalVar("GigaFlare", 1)
            mob:setLocalVar("MegaFlareQueue", 0)
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

entity.onMobDeath = function(mob, player, optParams)
end

return entity
