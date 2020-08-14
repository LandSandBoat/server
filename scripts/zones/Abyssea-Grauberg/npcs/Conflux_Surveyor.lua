-----------------------------------
-- Area: Abyssea - Grauberg
--  NPC: Conflux Surveyor
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/abyssea")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local visitant = 0
    local prevtime = player:getCharVar("Abyssea_Time")
    local STONES = tpz.abyssea.getTravStonesTotal(player)
    local SOJOURN = tpz.abyssea.getAbyssiteTotal(player, "SOJOURN")

    if player:hasStatusEffect(tpz.effect.VISITANT) then
        visitant = 60
    end

    player:startEvent(2002, 0, visitant, prevtime, STONES, SOJOURN, 0, 0, 0)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local SOJOURN = tpz.abyssea.getAbyssiteTotal(player, "SOJOURN")
    local duration = 0
    local prevtime = player:getCharVar("Abyssea_Time") -- Gets reduced by Visitants "on tic".

    if prevtime > 7200 then
        prevtime = 7200
        duration = prevtime
    else
        duration = prevtime
    end

    duration = duration+(SOJOURN *180)

    if csid == 2002 then
        if not VISITANT_SYSTEM and (option == 65538 or option == 131074 or option == 196610 or option == 262146) then
            player:addStatusEffect(tpz.effect.VISITANT, 0, 0, 0, 0, 0) -- using 0 should cause an infinate duration.
        elseif option == 2 then -- Use no stones, use previous remaining time
            player:addStatusEffect(tpz.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
        elseif option == 65538 then -- Use 1 stone
            duration = (duration + 1800) * VISITANT_BONUS
            player:addStatusEffect(tpz.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            tpz.abyssea.spendTravStones(player, 1)
        elseif option == 65539 then -- Use 1 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 131074 then -- Use 2 stone
            duration = (duration + 3600) * VISITANT_BONUS
            player:addStatusEffect(tpz.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            tpz.abyssea.spendTravStones(player, 2)
        elseif option == 131075 then -- Use 2 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 196610 then -- Use 3 stone
            duration = (duration + 5400) * VISITANT_BONUS
            player:addStatusEffect(tpz.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            tpz.abyssea.spendTravStones(player, 3)
        elseif option == 196611 then -- Use 3 stone
            player:PrintToPlayer( "Not implemented yet, sorry!" )
            -- Todo: extend time
        elseif option == 262146 then -- Use 4 stone
            duration = (duration + 7200) * VISITANT_BONUS
            player:addStatusEffect(tpz.effect.VISITANT, 0, 3, duration, 0, 0)
            player:setCharVar("Abyssea_Time", duration)
            tpz.abyssea.spendTravStones(player, 4)
        end
    end
end
