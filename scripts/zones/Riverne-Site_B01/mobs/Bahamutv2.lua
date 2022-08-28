-----------------------------------
-- Area: Riverne - Site B01 (BCNM)
--   NM: Bahamut v2
-- BCNM: Wyrmking Descends
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/quests")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local wyrms    = {16896158, 16896159, 16896160, 16896161}
local percents = {90, 80, 70, 60, 50, 40, 30, 20}
local adds     = {80, 60, 40, 20}

local flare = function(mob, target, level)
    local flareWait = mob:getLocalVar("FlareWait")
    local tauntShown = mob:getLocalVar("tauntShown")

    mob:SetMobAbilityEnabled(false) -- disable all other actions until Megaflare is used successfully
    mob:SetMagicCastingEnabled(false)
    mob:SetAutoAttackEnabled(false)

    if flareWait == 0 and tauntShown == 0 then -- if there is a queued Megaflare and the last Megaflare has been used successfully or if the first one hasn't been used yet.
        mob:setLocalVar("tauntShown", 1)
        if level == 0 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT)
        elseif level == 1 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 13)
        elseif level == 2 then
            target:showText(mob, ID.text.BAHAMUT_TAUNT + 14)
            mob:timer(1000, function(mobArg) if mobArg:isAlive() then mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 15) end end)
            mob:timer(2000, function(mobArg) if mobArg:isAlive() then mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 16) end end)
            mob:timer(3000, function(mobArg) if mobArg:isAlive() then mobArg:SetMobAbilityEnabled(true) mobArg:SetMagicCastingEnabled(true) mobArg:SetAutoAttackEnabled(true) end end)
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
    mob:addMod(xi.mod.REGAIN, 300)
    mob:addMod(xi.mod.REGEN, 50)
    mob:addStatusEffect(xi.effect.PHALANX, 35, 0, 180)
    mob:addStatusEffect(xi.effect.STONESKIN, 350, 0, 300)
    mob:addStatusEffect(xi.effect.PROTECT, 175, 0, 1800)
    mob:addStatusEffect(xi.effect.SHELL, 24, 0, 1800)
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
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

    if mob:canUseAbilities() then
        -- Summon Adds
        for i = 1, #adds do
            if mob:getHPP() < adds[i] and addsSummoned < i then
                mob:setLocalVar("summoning", 1)
                mob:SetMobAbilityEnabled(false)
                mob:SetMagicCastingEnabled(false)
                mob:SetAutoAttackEnabled(false)
                target:showText(mob, ID.text.BAHAMUT_TAUNT + 5)
                mob:setLocalVar("addsSummoned", addsSummoned + 1)
                mob:timer(1000, function(mobArg) mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 6) end)
                mob:timer(2000, function(mobArg) mobArg:showText(mobArg, ID.text.BAHAMUT_TAUNT + 7) end)
                mob:timer(3000, function(mobArg) mobArg:useMobAbility(1550) mobArg:SetMobAbilityEnabled(true) mobArg:SetMagicCastingEnabled(true) mobArg:SetAutoAttackEnabled(true) end)
            end
        end

        -- Megaflare
        if mob:getLocalVar("megaFlareCount") < flareTrigger and flareTrigger < 4 and summoning == 0 then
            flare(mob, target, 0)
        -- Gigaflare
        elseif mob:getLocalVar("gigaFlareCount") < flareTrigger and flareTrigger > 3 and summoning == 0 then
            mob:setLocalVar("flareQueued", 1)
            flare(mob, target, 1)
        -- Teraflare
        elseif mob:getHPP() < 10 and mob:getLocalVar("TeraFlare") < 1 and mob:checkDistance(target) <= 15 then
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
end

entity.onMobWeaponSkill = function(target, mob, skill)
    --Summon Wyrms in a random order
    if skill:getID() == 1550 then
        local addsSummoned = mob:getLocalVar("addsSummoned")
        local wyrmOne = mob:getLocalVar("wyrmOne")
        local wyrmTwo = mob:getLocalVar("wyrmTwo")
        local wyrmThree = mob:getLocalVar("wyrmThree")
        local wyrmFour = mob:getLocalVar("wyrmFour")
        local wyrmOrder = {wyrmOne, wyrmTwo, wyrmThree, wyrmFour}

        for i = 1, #wyrmOrder do
            mob:setLocalVar("randWyrm", wyrmOrder[addsSummoned])
        end
    end
end

entity.onMobDisengage = function(mob)
    -- In case of wipe during Flares, this will reset Bahamut
    mob:SetMobAbilityEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:SetAutoAttackEnabled(true)
end

entity.onMobDeath = function(mob, player, isKiller)
    if isKiller then
        mob:messageText(mob, ID.text.BAHAMUT_TAUNT + 17)
        mob:timer(3000, function(mobArg) mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 18) end)
        mob:timer(6000, function(mobArg) mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 19) end)
        mob:timer(9000, function(mobArg) mobArg:messageText(mobArg, ID.text.BAHAMUT_TAUNT + 20) end)

        for i = 1, 16 do DespawnMob(ID.mob.BAHAMUT_V2 + i) end
    end
end

return entity
