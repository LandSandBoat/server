-----------------------------------
-- func: immortal <player>
-- desc: Sets a target to be unkillable
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!immortal (player)')
end

commandObj.onTrigger = function(player, target)
    -- validate target
    local targ
    local cursorTarget = player:getCursorTarget()

    if target then
        targ = GetPlayerByName(target)
        if not targ then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    elseif cursorTarget and not cursorTarget:isNPC() then
        targ = cursorTarget
    else
        targ = player
    end

    if not targ:isNPC() then
        if targ:isAlive() then

            local immortal = false
            if targ:isPC() then
                if targ:getCharVar('Immortal') == 1 then
                    targ:delStatusEffectSilent(0)
                    targ:setCharVar('Immortal', 0)
                else
                    targ:addStatusEffectEx(0, xi.effect.TRANSCENDENCY, 0, 0, 0)
                    targ:setCharVar('Immortal', 1)
                    immortal = true
                end
            else
                if targ:getLocalVar('Immortal') == 1 then
                    targ:setLocalVar('Immortal', 0)
                else
                    targ:setLocalVar('Immortal', 1)
                    immortal = true
                end
            end

            targ:setUnkillable(immortal)

            if immortal then
                player:PrintToPlayer(string.format('%s is now immortal!', targ:getName()))
            else
                player:PrintToPlayer(string.format('%s is mortal again.', targ:getName()))
            end
        else
            player:PrintToPlayer(string.format('%s is already dead.', targ:getName()))
        end
    else
        player:PrintToPlayer(string.format('%s is an NPC. You should not be attacking them.', targ:getName()))
    end
end

return commandObj
