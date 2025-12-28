-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Time Bomb
-- BCNM: 3, 2, 1...
-----------------------------------
local ID = zones[xi.zone.WAUGHROON_SHRINE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Ensure that nothing can stop the countdown.
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setBehavior(xi.behavior.NO_TURN)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('selfDestruct', currentTime + 60) -- After 60 seconds, self destruct.
    mob:setLocalVar('msgBit', 0)
end

-- Bitmask implementation seemed most efficient for tracking which messages have been sent rather than elseif chains.
local phaseTable =
{
-- [phase] = { time, text }
    [1] = { 60, ID.text.COUNTDOWN_OFFSET     },
    [2] = { 30, ID.text.COUNTDOWN_OFFSET + 1 },
    [3] = { 20, ID.text.COUNTDOWN_OFFSET + 2 },
    [4] = { 10, ID.text.COUNTDOWN_OFFSET + 3 },
    [5] = {  5, ID.text.COUNTDOWN_OFFSET + 4 },
    [6] = {  4, ID.text.COUNTDOWN_OFFSET + 5 },
    [7] = {  3, ID.text.COUNTDOWN_OFFSET + 6 },
    [8] = {  2, ID.text.COUNTDOWN_OFFSET + 7 },
    [9] = {  1, ID.text.COUNTDOWN_OFFSET + 8 },
}

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local currentTime   = GetSystemTime()
    local destructTime  = mob:getLocalVar('selfDestruct')
    local timeRemaining = destructTime - currentTime
    local phaseBitmask  = mob:getLocalVar('msgBit')

    -- Handle messages.
    for phase = 1, #phaseTable do
        if
            timeRemaining <= phaseTable[phase][1] and
            not utils.mask.getBit(phaseBitmask, phase)
        then
            mob:setLocalVar('msgBit', phaseBitmask + bit.lshift(1, phase))

            for _, player in pairs(battlefield:getPlayers()) do
                local distance = mob:checkDistance(player)
                if distance <= 30 then
                    player:messageSpecial(phaseTable[phase][2])
                end
            end

            break
        end
    end

    if
        currentTime >= destructTime and
        utils.mask.getBit(phaseBitmask, 9)
    then
        if battlefield:getLocalVar('timeBombExploded') == 0 then
            mob:useMobAbility(xi.mobSkill.SELF_DESTRUCT_BOMB_321)
            battlefield:setLocalVar('timeBombExploded', 1)
        elseif not xi.combat.behavior.isEntityBusy(mob) then
            mob:setHP(0)
        end
    end
end

entity.onMobDespawn = function(mob)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Anti-Grief method. Retail just allows you to stay in the battlefield until timeout.
    if battlefield:getLocalVar('timeBombExploded') == 1 then
        battlefield:setTimeLimit(0)
    end
end

return entity
