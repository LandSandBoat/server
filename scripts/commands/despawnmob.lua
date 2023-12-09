-----------------------------------
-- func: despawnmob <mobid-optional>
-- desc: Despawns the given mob <t> or mobID)
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'i'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!despawnmob (mobID)')
end

commandObj.onTrigger = function(player, mobId)
    -- validate mobId
    local targ
    if mobId == nil then
        targ = player:getCursorTarget()
        if targ == nil or not targ:isMob() then
            error(player, 'You must either provide a mobID or target a mob.')
            return
        end
    else
        targ = GetMobByID(mobId)
        if targ == nil then
            error(player, 'Invalid mobID.')
            return
        end
    end

    -- despawn mob
    DespawnMob(targ:getID())
    player:printToPlayer(string.format('Despawned %s %i.', targ:getName(), targ:getID()))
end

return commandObj
