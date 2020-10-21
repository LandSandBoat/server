---------------------------------------------------------------------------------------------------
-- func: immortal <player>
-- desc: Sets a target to be unkillable
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!immortal {player}")
end

function onTrigger(player, hp, target)
    -- validate target
    local targ
    local cursor_target = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    elseif cursor_target and not cursor_target:isNPC() then
        targ = cursor_target
    else
        targ = player
    end

    if not targ:isNPC() then
        if targ:isAlive() then
      
            local immortal = false
            if targ:isPC() then
                if targ:getCharVar("Immortal") == 1 then
                    targ:delStatusEffect(tpz.effect.ERGON_MIGHT)
                    targ:setCharVar("Immortal", 0)
                else
                    targ:addStatusEffect(tpz.effect.ERGON_MIGHT, 0, 0, 0)
                    targ:setCharVar("Immortal", 1)
                    immortal = true
                end
            else
                if targ:getLocalVar("Immortal") == 1 then
                    targ:setLocalVar("Immortal", 0)
                else
                    targ:setLocalVar("Immortal", 1)
                    immortal = true
                end
            end

            targ:setUnkillable(immortal)

            if immortal then
                player:PrintToPlayer(string.format("%s is now immortal!", targ:getName()))
            else
                player:PrintToPlayer(string.format("%s is mortal again.", targ:getName()))
            end
        else
            player:PrintToPlayer(string.format("%s is already dead.", targ:getName()))
        end
    else
        player:PrintToPlayer(string.format("%s is an NPC. You should not be attacking them.", targ:getName()))
    end
end
