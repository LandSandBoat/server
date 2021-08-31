-----------------------------------
-- Zone: Abyssea - Konschtat
--  NPC: Conflux Surveyor
-- !pos 133.000 -72.738 -824.000 15
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/abyssea")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local timeRemaining = 0
    local prevTime = player:getCharVar("abysseaTimeStored") -- Seconds remaining
    local numStones = xi.abyssea.getHeldTraverserStones(player)
    local numSojourn = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.SOJOURN)
    local hasRhapsody = player:hasKeyItem(xi.ki.RHAPSODY_IN_MAUVE)

    local visitantEffect = player:getStatusEffect(xi.effect.VISITANT)
    if visitantEffect and visitantEffect:getIcon() == xi.effect.VISITANT then
        timeRemaining = player:getStatusEffect(xi.effect.VISITANT):getTimeRemaining() / 1000 - 4
    end

    player:startEvent(2001, 0, timeRemaining, prevTime, numStones, numSojourn, hasRhapsody, 0, 2)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
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
    end
end

return entity
