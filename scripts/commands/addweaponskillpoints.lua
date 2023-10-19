-----------------------------------
-- func: addWeaponSkillPoints <slot> <points> (player)
-- desc: Adds weapon skill points to an equipped item.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 'iis'
}

local function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer('!addweaponskillpoints <slot main=0, sub=1, ranged=2> <points> (player)')
end

commandObj.onTrigger = function(player, slot, points, target)
    -- validate slot
    if slot < xi.slot.MAIN or slot > xi.slot.RANGED then
        error(player, 'Slot out of range.')
        return
    end

    -- validate points
    if points < 0 then
        error(player, 'Cannot add negative points.')
        return
    end

    -- validate target
    if target == nil then
        target = player
    else
        target = GetPlayerByName(target)
        if target == nil then
            error(player, string.format('Player named "%s" not found!', target))
            return
        end
    end

    local item = target:getStorageItem(0, 0, slot)
    if item == nil then
        local slotname = slot == 0 and 'main' or slot == 1 and 'sub' or slot == 2 and 'ranged'
        error(player, string.format('No weapon equipped in %s slot.', slotname))
        return
    end

    -- add weaponskill points
    if target:addWeaponSkillPoints(slot, points) then
        player:PrintToPlayer(string.format('Added %s weapon skill points to %s.', points, item:getName()))
    else
        player:PrintToPlayer(string.format('Could not add weapon skill points to %s.', item:getName()))
    end
end

return commandObj
