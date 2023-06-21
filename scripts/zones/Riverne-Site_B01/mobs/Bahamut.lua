-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
end

entity.onMobSpawn = function(mob)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
end

local megaflareHPP =
{
    90, 80, 70, 60, 50, 40, 30, 20,
}

entity.onMobFight = function(mob, target)
    local megaFlareQueue = mob:getLocalVar("MegaFlareQueue")
    local megaFlareTrigger = mob:getLocalVar("MegaFlareTrigger")
    -- local megaFlareUses = mob:getLocalVar("MegaFlareUses")
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

    if mob:actionQueueEmpty() and not isBusy then -- the last check prevents multiple Mega/Gigaflares from being called at the same time.
        if megaFlareQueue > 0 then
            mob:setMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
            mob:setMagicCastingEnabled(false)
            mob:setAutoAttackEnabled(false)

            if flareWait == 0 and tauntShown == 0 then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
                target:showText(mob, ID.text.BAHAMUT_TAUNT)
                mob:setLocalVar("FlareWait", mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
                mob:setLocalVar("tauntShown", 1)
            elseif flareWait < mob:getBattleTime() and flareWait ~= 0 and tauntShown >= 0 then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
                if tauntShown == 1 then
                    mob:setLocalVar("tauntShown", 2) -- if Megaflare gets stunned it won't show the text again, until successful use.
                    target:showText(mob, ID.text.BAHAMUT_TAUNT + 1)
                end

                if mob:checkDistance(target) <= 15 then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                    if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then -- default behaviour
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
                    end

                    mob:useMobAbility(1551)
                end
            end
        elseif
            megaFlareQueue == 0 and
            mobHPP < 10 and
            gigaFlare < 1 and
            mob:checkDistance(target) <= 15
        then
            -- All of the scripted Megaflares are to happen before Gigaflare.
            if tauntShown == 0 then
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 2)
                mob:setLocalVar("tauntShown", 3) -- again, taunt won't show again until the move is successfully used.
            end

            if bit.band(mob:getBehaviour(), xi.behavior.NO_TURN) > 0 then -- default behaviour
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
            end

            mob:useMobAbility(1552)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
