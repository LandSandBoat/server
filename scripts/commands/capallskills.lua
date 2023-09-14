-----------------------------------
-- func: capallskills
-- desc: Caps all the players skills.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 2,
    parameters = ""
}

commandObj.onTrigger = function(player)
    player:capAllSkills()
    player:PrintToPlayer('All skills capped!')
end

return commandObj
