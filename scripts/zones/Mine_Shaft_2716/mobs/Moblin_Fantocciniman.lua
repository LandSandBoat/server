-----------------------------------
-- Area: Mine Shaft 2716
-- ENM : Automaton Assault
-- Mob: Moblin Fantocciniman
-----------------------------------
---@type TMobEntity
local entity = {}
-----------------------------------
local ID = zones[xi.zone.MINE_SHAFT_2716]
-----------------------------------

-- TODO: Possible rolls are weighted?

-----------------------------------
--- Marionette Dice Table
-----------------------------------
local marionetteDice =
{
    -- Main target: Player.
    [ 1] = xi.mobSkill.MARIONETTE_DICE_2,  -- Restore HP to Player
    [ 2] = xi.mobSkill.MARIONETTE_DICE_3,  -- Restore MP to Player
    [ 3] = xi.mobSkill.MARIONETTE_DICE_4,  -- Attack Boost to Player
    [ 4] = xi.mobSkill.MARIONETTE_DICE_5,  -- Defense Boost to Player
    [ 5] = xi.mobSkill.MARIONETTE_DICE_6,  -- TP Boost to Player
    [ 6] = xi.mobSkill.MARIONETTE_DICE_15, -- Reset job abilities for Player

    -- Main target: Fantoccini.
    [ 7] = xi.mobSkill.MARIONETTE_DICE_7,  -- Fantoccini uses a job ability or casts a spell
    [ 8] = xi.mobSkill.MARIONETTE_DICE_8,  -- Fantoccini TP Boost
    [ 9] = xi.mobSkill.MARIONETTE_DICE_9,  -- Fantoccini Attack Boost
    [10] = xi.mobSkill.MARIONETTE_DICE_10, -- Fantoccini Defense Boost
    [11] = xi.mobSkill.MARIONETTE_DICE_11, -- Restore HP to Fantoccini
    [12] = xi.mobSkill.MARIONETTE_DICE_12, -- Restore MP to Fantoccini
    [13] = xi.mobSkill.MARIONETTE_DICE_14, -- Fantoccini uses 2-hour ability
}

-----------------------------------
-- Function to get the possible rolls based off the initiators job. If they are not a spell caster, mana rolls get excluded.
-----------------------------------
local function getPossibleRolls(mob)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local initiatorJob = battlefield:getLocalVar('initiatorJob')
    local possibleRolls = { 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13 }

    if
        initiatorJob == xi.job.WHM or
        initiatorJob == xi.job.BLM or
        initiatorJob == xi.job.RDM or
        initiatorJob == xi.job.SMN or
        initiatorJob == xi.job.BLU
    then
        table.insert(possibleRolls, 2)
        table.insert(possibleRolls, 12)
    end

    return possibleRolls
end

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setBehavior(xi.behavior.STANDBACK)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:messageText(mob, ID.text.HO_HO) -- Ho-Ho, ho-ho! Time for goodebyongo!
    mob:setLocalVar('marionetteDiceTime', currentTime + math.random(10, 15))
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()

    -----------------------------------
    -- Marionette Dice Roll - Fetches possible rolls based off job and chooses one at random every 25-30 seconds.
    -----------------------------------
    if currentTime >= mob:getLocalVar('marionetteDiceTime') then
        mob:messageText(mob, ID.text.HO_HO + 2) -- Roly-poly, roly-poly♪

        local possibleRolls = getPossibleRolls(mob)

        if not possibleRolls then
            return
        end

        local randomRoll = possibleRolls[math.random(1, #possibleRolls)]
        if randomRoll >= 7 then
            local fantoccini = GetMobByID(mob:getID() + 2)
            if fantoccini and fantoccini:isAlive() then
                mob:useMobAbility(marionetteDice[randomRoll], fantoccini, 0, true)
            end
        else
            mob:useMobAbility(marionetteDice[randomRoll], target, 0, true)
        end

        mob:setLocalVar('marionetteDiceTime', currentTime + math.random(25, 30))
    end

    if mob:getLocalVar('moblinAttacked') == 1 then
        return
    end

    -----------------------------------
    -- If the moblin is attacked and goes below 95% HP, attack the player. (They can still be enfeebled without this triggering)
    -----------------------------------
    if mob:getHPP() < 95 then
        mob:messageText(mob, ID.text.HO_HO + 11) -- Ow-ow, ow-ow! You make me mad now!
        mob:setLocalVar('moblinAttacked', 1)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setBehavior(xi.behavior.NONE)
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillUsed = skill:getID()

    -----------------------------------
    -- If the skill used is not Marionette Dice, return.
    -----------------------------------
    if
        skillUsed < xi.mobSkill.MARIONETTE_DICE_2 or
        skillUsed > xi.mobSkill.MARIONETTE_DICE_15
    then
        return
    end

    -----------------------------------
    -- If the Marionette Dice is good for the moblin, play emote 3, if its good for the player, play 1.
    -- We use a 5 second timer to delay the emote usage and to emulate the look of retail. 5 seconds looks excellent.
    -----------------------------------
    if
        skillUsed >= xi.mobSkill.MARIONETTE_DICE_7 and
        skillUsed < xi.mobSkill.MARIONETTE_DICE_15
    then
        mob:timer(5000, function(mobArg)
            mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)

            local fantoccini = GetMobByID(mobArg:getID() + 2)

            if not fantoccini then
                return
            end

            if skillUsed == xi.mobSkill.MARIONETTE_DICE_7 then
                mobArg:messageText(mobArg, ID.text.HO_HO + 5) -- Go-go, go-go! (Fantoccini uses a job ability or casts a spell)
                fantoccini:setLocalVar('diceRoll', 7)
            elseif skillUsed == xi.mobSkill.MARIONETTE_DICE_8 then
                mobArg:messageText(mobArg, ID.text.HO_HO + 6) -- Ha-ha, ha-ha! (Fantoccini uses a weaponskill)
                fantoccini:setLocalVar('diceRoll', 8)
            elseif skillUsed == xi.mobSkill.MARIONETTE_DICE_14 then
                mobArg:messageText(mobArg, ID.text.HO_HO + 7) -- Yay-yay, yay-yay! Not your lucky day! (Fantoccini uses a 2-hour ability)
                fantoccini:setLocalVar('diceRoll', 14)
            end
        end)
    else
        mob:timer(5000, function(mobArg)
            mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_1)
        end)
    end
end

entity.onMobDisengage = function(mob)
    mob:messageText(mob, ID.text.HO_HO + 12) -- Ho-ho, ho-ho! Goodebyongo!
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        mob:messageText(mob, ID.text.HO_HO + 10) -- Huff-huff, huff-huff... You play too rough...

        local mobId = mob:getID()
        for i = 2, 5 do
            local otherMob = GetMobByID(mobId + i)
            if otherMob and otherMob:isAlive() then
                otherMob:addStatusEffect(xi.effect.TERROR, { duration = 900, origin = mob })
            end
        end
    end
end

return entity
