-----------------------------------
-- func: addallmounts
-- desc: Adds all mount key items to GM if no target is specified.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
  permission = 1,
  parameters = 's'
}

local function error(player, msg)
  player:printToPlayer(msg)
  player:printToPlayer('!addallmounts (player)')
end

commandObj.onTrigger = function(player, target)
-- validate target
local targ
if target == nil then
  targ = player
else
  targ = GetPlayerByName(target)
  if targ == nil then
    error(player, string.format('Player named "%s" not found!', target))
    return
  end
end

-- add all mount key items
for i = 3072, 3108, 1 do
  targ:addKeyItem(i)
end

player:printToPlayer(string.format('%s now has all mounts.', targ:getName()))
end

return commandObj