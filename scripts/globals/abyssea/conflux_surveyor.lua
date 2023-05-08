-----------------------------------
-- Conflux Surveyor Global
-----------------------------------
require("scripts/globals/abyssea")
require("scripts/globals/status")
-----------------------------------
xi = xi or {}
xi.abyssea = xi.abyssea or {}

xi.abyssea.surveyorOnTrigger = function(player, npc)
    local timeRemaining = 0
    local prevTime = 0
    local numStones = xi.abyssea.getHeldTraverserStones(player)
    local numSojourn = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.SOJOURN)
    local hasRhapsody = player:hasKeyItem(xi.ki.RHAPSODY_IN_MAUVE)
    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
    local hasVisitantStatusEffect = 0

    if visitantEffect and visitantEffect:getIcon() == xi.effect.VISITANT then
        timeRemaining = player:getStatusEffect(xi.effect.VISITANT):getTimeRemaining() / 1000 - 4
        hasVisitantStatusEffect = 3
    else
        prevTime = player:getCharVar("abysseaTimeStored") -- Seconds remaining
    end

    player:startEvent(2001, hasVisitantStatusEffect, timeRemaining, prevTime, numStones, numSojourn, hasRhapsody, 0, 0)
end

xi.abyssea.surveyorOnEventFinish = function(player, csid, option, npc)
    local optionSelected = bit.band(option, 0xF)
    local additionalStones = math.min(bit.rshift(option, 16), xi.abyssea.getHeldTraverserStones(player))

    if
        csid == 2001 and
        (optionSelected == 2 or
        optionSelected == 3)
    then
        local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
        local visitantTime = 0

        -- If the player was granted visitant status, initialize with the time
        -- remaining on the effect, else use the stored time.  This is handled by the
        -- client as well, and this adds additional safety.
        if visitantEffect:getIcon() == xi.effect.VISITANT then
            visitantTime = visitantEffect:getTimeRemaining() / 1000 - 4
        else
            visitantTime = player:getCharVar("abysseaTimeStored")
            player:setCharVar("abysseaTimeStored", 0)
        end

        local numSojourn = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.SOJOURN)
        local timePerStone = player:hasKeyItem(xi.ki.RHAPSODY_IN_MAUVE) and 3600 or 1800

        visitantTime = visitantTime + timePerStone * additionalStones + additionalStones * (numSojourn * 180)

        -- At no point should we grant temporary visitant status, so we use
        -- CLuaStatusEffect::setIcon() to force an update.  Add the same 4
        -- seconds of buffer time for countdown, which is removed on saving
        visitantEffect:setDuration(math.min(visitantTime * 1000 + 4, 7200 * 1000))
        visitantEffect:resetStartTime()
        visitantEffect:setIcon(xi.effect.VISITANT)

        xi.abyssea.spendTravStones(player, additionalStones)
        xi.abyssea.displayAbysseaLights(player)
    end
end
