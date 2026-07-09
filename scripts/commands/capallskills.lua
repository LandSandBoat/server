-----------------------------------
-- func: capallskills
-- desc: Caps all the players skills.
-----------------------------------
---@type TCommand
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = ''
}

commandObj.onTrigger = function(player)
    player:capAllSkills()

    local automatonSkills =
    {
        xi.skill.AUTOMATON_MELEE,
        xi.skill.AUTOMATON_RANGED,
        xi.skill.AUTOMATON_MAGIC,
    }

    for _, skillId in ipairs(automatonSkills) do
        player:setSkillLevel(skillId, 5000)
    end

    player:printToPlayer('All skills capped!')
end

return commandObj
