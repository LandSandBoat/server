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

-- TODO: More accurate weights for rolls. Fully Restore HP/MP only captured once, seems to be very rare.
-- TODO: Apparently you can steal the moblins dice on THF and it limits his rolls to only the player targeting dice.

-----------------------------------
--- Marionette Dice Table
-----------------------------------
local marionetteDice =
{
    -- Main target: Player.
    [ 1] = { skill = xi.mobSkill.MARIONETTE_DICE_1,  weight = 1, targetsFantoccini = false, isCasterRoll = false }, -- Fully Restores Player HP / MP
    [ 2] = { skill = xi.mobSkill.MARIONETTE_DICE_2,  weight = 8, targetsFantoccini = false, isCasterRoll = false }, -- Restore HP to Player
    [ 3] = { skill = xi.mobSkill.MARIONETTE_DICE_3,  weight = 8, targetsFantoccini = false, isCasterRoll =  true }, -- Restore MP to Player
    [ 4] = { skill = xi.mobSkill.MARIONETTE_DICE_4,  weight = 8, targetsFantoccini = false, isCasterRoll = false }, -- Attack Boost to Player
    [ 5] = { skill = xi.mobSkill.MARIONETTE_DICE_5,  weight = 8, targetsFantoccini = false, isCasterRoll = false }, -- Defense Boost to Player
    [ 6] = { skill = xi.mobSkill.MARIONETTE_DICE_6,  weight = 8, targetsFantoccini = false, isCasterRoll = false }, -- TP Boost to Player
    [ 7] = { skill = xi.mobSkill.MARIONETTE_DICE_15, weight = 5, targetsFantoccini = false, isCasterRoll = false }, -- Reset job abilities for Player

    -- Main target: Fantoccini.
    [ 8] = { skill = xi.mobSkill.MARIONETTE_DICE_7,  weight = 8, targetsFantoccini =  true, isCasterRoll = false }, -- Fantoccini uses a job ability or casts a spell
    [ 9] = { skill = xi.mobSkill.MARIONETTE_DICE_8,  weight = 8, targetsFantoccini =  true, isCasterRoll = false }, -- Fantoccini TP Boost
    [10] = { skill = xi.mobSkill.MARIONETTE_DICE_9,  weight = 8, targetsFantoccini =  true, isCasterRoll = false }, -- Fantoccini Attack Boost
    [11] = { skill = xi.mobSkill.MARIONETTE_DICE_10, weight = 8, targetsFantoccini =  true, isCasterRoll = false }, -- Fantoccini Defense Boost
    [12] = { skill = xi.mobSkill.MARIONETTE_DICE_11, weight = 8, targetsFantoccini =  true, isCasterRoll = false }, -- Restore HP to Fantoccini
    [13] = { skill = xi.mobSkill.MARIONETTE_DICE_12, weight = 8, targetsFantoccini =  true, isCasterRoll =  true }, -- Restore MP to Fantoccini
    [14] = { skill = xi.mobSkill.MARIONETTE_DICE_13, weight = 1, targetsFantoccini =  true, isCasterRoll = false }, -- Fully Restores Fantoccini HP / MP
    [15] = { skill = xi.mobSkill.MARIONETTE_DICE_14, weight = 5, targetsFantoccini =  true, isCasterRoll = false }, -- Fantoccini uses 2-hour ability
}

-----------------------------------
-- Function to select roll.
-----------------------------------
local function rollDice(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local mainJob  = battlefield:getLocalVar('initiatorJob')
    local isCaster = mainJob == xi.job.WHM or mainJob == xi.job.BLM or mainJob == xi.job.RDM or mainJob == xi.job.SMN or mainJob == xi.job.BLU

    local possibleRolls = {}
    local totalWeight   = 0

    for i = 1, #marionetteDice do
        local rollData = marionetteDice[i]
        if isCaster or not rollData.isCasterRoll then
            possibleRolls[#possibleRolls + 1] = rollData
            totalWeight                       = totalWeight + rollData.weight
        end
    end

    local randomRoll = math.randomInt(1, totalWeight)
    local weight     = 0
    for j = 1, #possibleRolls do
        weight = weight + possibleRolls[j].weight
        if randomRoll <= weight then
            return possibleRolls[j]
        end
    end
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
    mob:setLocalVar('marionetteDiceTime', currentTime + math.randomInt(10, 15))
end

entity.onMobFight = function(mob, target)
    local currentTime = GetSystemTime()

    -----------------------------------
    -- Marionette Dice Roll - Fetches possible rolls based off job and chooses one at random every 25-30 seconds.
    -----------------------------------
    if currentTime >= mob:getLocalVar('marionetteDiceTime') then
        mob:messageText(mob, ID.text.HO_HO + 2) -- Roly-poly, roly-poly♪

        local roll = rollDice(mob)
        if not roll then
            return
        end

        if roll.targetsFantoccini then
            local fantoccini = GetMobByID(mob:getID() + 2)
            if fantoccini and fantoccini:isAlive() then
                mob:useMobAbility(roll.skill, fantoccini, 0, true)
            end
        else
            mob:useMobAbility(roll.skill, target, 0, true)
        end

        mob:setLocalVar('marionetteDiceTime', currentTime + math.randomInt(25, 30))
    end

    -- Early return: Moblin is marked as attacked.
    if mob:getLocalVar('moblinAttacked') == 1 then
        return
    end

    -- Early return: Moblin HP is high enough to not count as having been attacked.
    if mob:getHPP() >= 95 then
        return
    end

    -- Handle being attacked.
    mob:setLocalVar('moblinAttacked', 1)
    mob:messageText(mob, ID.text.HO_HO + 11) -- Ow-ow, ow-ow! You make me mad now!
    mob:setAutoAttackEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setBehavior(xi.behavior.NONE)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillUsed = skill:getID()

    -----------------------------------
    -- If the skill used is not Marionette Dice, return.
    -----------------------------------
    if
        skillUsed < xi.mobSkill.MARIONETTE_DICE_1 or
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
