-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")


function onMobInitialise(mob)
    mob:setMobMod(tpz.mobMod.HP_STANDBACK, -1)
end

function onMobSpawn(mob)
    mob:addStatusEffect(tpz.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(tpz.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(tpz.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(tpz.effect.SHELL, 24, 0, 1800)
end

function onMobFight(mob, target)
    local MegaFlareQueue = mob:getLocalVar("MegaFlareQueue")
    local MegaFlareTrigger = mob:getLocalVar("MegaFlareTrigger")
    local MegaFlareUses = mob:getLocalVar("MegaFlareUses")
    local FlareWait = mob:getLocalVar("FlareWait")
    local GigaFlare = mob:getLocalVar("GigaFlare")
    local tauntShown = mob:getLocalVar("tauntShown")
    local mobHPP = mob:getHPP()
    local isBusy = false
    local act = mob:getCurrentAction()

    if act == tpz.act.MOBABILITY_START or act == tpz.act.MOBABILITY_USING or act == tpz.act.MOBABILITY_FINISH or act == tpz.act.MAGIC_START or act == tpz.act.MAGIC_CASTING or act == tpz.act.MAGIC_START then
        isBusy = true -- is set to true if Bahamut is in any stage of using a mobskill or casting a spell
    end

    if (mobHPP < 90 and MegaFlareTrigger < 1) then -- if Megaflare hasn't been set to be used this many times, increase the queue of Megaflares. This will allow it to use multiple Megaflares in a row if the HP is decreased quickly enough.
        mob:setLocalVar("MegaFlareTrigger", 1)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 80 and MegaFlareTrigger < 2) then
        mob:setLocalVar("MegaFlareTrigger", 2)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 70 and MegaFlareTrigger < 3) then
        mob:setLocalVar("MegaFlareTrigger", 3)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 60 and MegaFlareTrigger < 4) then
        mob:setLocalVar("MegaFlareTrigger", 4)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 50 and MegaFlareTrigger < 5) then
        mob:setLocalVar("MegaFlareTrigger", 5)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 40 and MegaFlareTrigger < 6) then
        mob:setLocalVar("MegaFlareTrigger", 6)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 30 and MegaFlareTrigger < 7) then
        mob:setLocalVar("MegaFlareTrigger", 7)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    elseif (mobHPP < 20 and MegaFlareTrigger < 8) then
        mob:setLocalVar("MegaFlareTrigger", 8)
        mob:setLocalVar("MegaFlareQueue", MegaFlareQueue + 1)
    end

    if (mob:actionQueueEmpty() == true and isBusy == false) then -- the last check prevents multiple Mega/Gigaflares from being called at the same time.
        if (MegaFlareQueue > 0) then
            mob:SetMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
            mob:SetMagicCastingEnabled(false)
            mob:SetAutoAttackEnabled(false)
            if (FlareWait == 0 and tauntShown == 0) then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
                target:showText(mob, ID.text.BAHAMUT_TAUNT)
                mob:setLocalVar("FlareWait", mob:getBattleTime() + 2) -- second taunt happens two seconds after the first.
                mob:setLocalVar("tauntShown", 1)
            elseif (FlareWait < mob:getBattleTime() and FlareWait ~= 0 and tauntShown >= 0) then -- the wait time between the first and second taunt as passed. Checks for wait to be not 0 because it's set to 0 on successful use.
                if (tauntShown == 1) then
                    mob:setLocalVar("tauntShown", 2) -- if Megaflare gets stunned it won't show the text again, until successful use.
                    target:showText(mob, ID.text.BAHAMUT_TAUNT + 1)
                end
                if (mob:checkDistance(target) <= 15) then -- without this check if the target is out of range it will keep attemping and failing to use Megaflare. Both Megaflare and Gigaflare have range 15.
                    if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- default behaviour
                        mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
                    end
                    mob:useMobAbility(1551)
                end
            end
        elseif (MegaFlareQueue == 0 and mobHPP < 10 and GigaFlare < 1 and mob:checkDistance(target) <= 15) then  -- All of the scripted Megaflares are to happen before Gigaflare.
            if (tauntShown == 0) then
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 2)
                mob:setLocalVar("tauntShown", 3) -- again, taunt won't show again until the move is successfully used.
            end
            if (bit.band(mob:getBehaviour(), tpz.behavior.NO_TURN) > 0) then -- default behaviour
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(tpz.behavior.NO_TURN)))
            end
            mob:useMobAbility(1552)
        end
    end
end

function onMobDeath(mob, player, isKiller)
end
