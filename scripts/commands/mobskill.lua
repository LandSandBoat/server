-----------------------------------
-- func: mobskill
-- desc: Forces an entity to do a skill
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'iii'
}

local function error(player, msg)
    player:printToPlayer(msg)
    player:printToPlayer('!mobskill <skillID> {mob} {tp}')
end

commandObj.onTrigger = function(player, skillID, target, tp)
    if skillID == nil or skillID < 0 then
        error(player, 'You must provide a correct skill ID.')
        return
    end

    if tp == nil or tp < 1000 then
        tp = 1000
    end

    local targ
    local zone = player:getZone()

    if not zone then
        return
    end

    if target == nil then
        targ = player:getCursorTarget()
    elseif zone and zone:getTypeMask() == xi.zoneType.INSTANCED then
        local instance = player:getInstance()

        if not instance then
            return
        end

        targ = GetMobByID(target, instance)
    else
        targ = GetMobByID(target)
    end

    if targ == nil or targ:isPC() then
        error(player, 'You must either provide a mobID or target a mob.')
        return
    end

    -- use skill
    targ:setTP(tp)
    targ:useMobAbility(skillID)
end

return commandObj
