-----------------------------------
-- Zone: Abyssea - Konschtat
--  NPC: Conflux Surveyor
-- !pos 133.000 -72.738 -824.000 15
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/abyssea")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local timeRemaining = 0
    local timeBanked = player:getCharVar("Abyssea_Time")
    local numStones = xi.abyssea.getHeldTraverserStones(player)
    local sojourn = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.SOJOURN)

    if player:hasStatusEffect(xi.effect.VISITANT) then
        timeRemaining = player:getStatusEffect(xi.effect.VISITANT):getDuration()
    end

    player:startEvent(2001, 0, timeRemaining, timeBanked, numStones, sojourn, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local SOJOURN = xi.abyssea.getAbyssiteTotal(player, xi.abyssea.abyssiteType.SOJOURN)
    local duration = 0
    local prevtime = player:getCharVar("Abyssea_Time") -- Gets reduced by Visitants "on tic".

    if prevtime > 7200 then
        prevtime = 7200
        duration = prevtime
    else
        duration = prevtime
    end

    duration = duration + (SOJOURN * 180)

    if csid == 2001 then
        if option == 2 then -- Use no stones, use previous remaining time
            player:addStatusEffect(xi.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
        elseif option == 65538 then -- Use 1 stone
            duration = (duration + 1800)
            player:addStatusEffect(xi.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            xi.abyssea.spendTravStones(player, 1)
        elseif option == 65539 then -- Use 1 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 131074 then -- Use 2 stone
            duration = (duration + 3600)
            player:addStatusEffect(xi.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            xi.abyssea.spendTravStones(player, 2)
        elseif option == 131075 then -- Use 2 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 196610 then -- Use 3 stone
            duration = (duration + 5400)
            player:addStatusEffect(xi.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            xi.abyssea.spendTravStones(player, 3)
        elseif option == 196611 then -- Use 3 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 262146 then -- Use 4 stone
            duration = (duration + 7200)
            player:addStatusEffect(xi.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            xi.abyssea.spendTravStones(player, 4)
        end
    end
end

return entity
