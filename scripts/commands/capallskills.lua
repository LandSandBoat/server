-----------------------------------
-- func: capallskills
-- desc: Caps all the players skills.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    player:capAllSkills()
    player:printToPlayer('All skills capped!')
end

return commandObj
