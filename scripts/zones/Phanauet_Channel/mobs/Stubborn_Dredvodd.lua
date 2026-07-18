-----------------------------------
-- Area: Phanauet Channel (1)
--   NM: Stubborn Dredvodd
-- !pos -12.295 -2.5 0.14 1
-----------------------------------
local ID = zones[xi.zone.PHANAUET_CHANNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Orcs_Wyvern')

    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- He agros level 99 characters.
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 45) -- Seconds between casts. he only has 1 spell.
end

entity.onMobSpawn = function(mob)
    -- Burn the 21-24 hour window the instant it appears, so a pop that nobody
    -- stays aboard to kill still consumes the cooldown until it can show again.
    mob:setLocalVar('cooldown', GetSystemTime() + math.randomInt(75600, 86400)) -- 21 to 24 hours

    -- Emerge onto the barge: spawn invisible, jump aboard, then become targetable.
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAnimationSub(0) -- invisible
    mob:stun(3000)
    mob:timer(1000, function(mobArg)
        mobArg:setAnimationSub(1) -- jump aboard
    end)

    mob:timer(3000, function(mobArg)
        mobArg:hideName(false)
        mobArg:setUntargetable(false)
    end)

    -- Ineuteniace the timekeeper announces the appearance of Dredvodd.
    local timekeeper = GetNPCByID(ID.npc.TIMEKEEPER_OFFSET)
    if timekeeper then
        timekeeper:messageText(timekeeper, ID.text.DREDVODD_SPAWN, true)
    end
end

entity.onMobEngage = function(mob, target)
    -- Hold the first wyvern summon until 15 seconds after he engages.
    mob:setLocalVar('wyvernRecall', GetSystemTime() + 15)
end

entity.onMobFight = function(mob, target)
    -- Summon (or resummon) the wyvern. On retail, he uses "Call Wyvern"
    -- and it is accompanied by a dust cloud animation. He resummons the wyvern
    -- once the old one has died and faded.
    if
        not mob:hasPet() and
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() >= mob:getLocalVar('wyvernRecall')
    then
        mob:setLocalVar('wyvernRecall', GetSystemTime() + 5)
        mob:useMobAbility(xi.mobSkill.CALL_WYVERN_1)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONESKIN, mob, false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        -- Ineuteniace the timekeeper thanks the party for killing Dredvodd.
        local timekeeper = GetNPCByID(ID.npc.TIMEKEEPER_OFFSET)
        if timekeeper then
            timekeeper:messageText(timekeeper, ID.text.DREDVODD_DEATH, true)
        end
    end
end

return entity
