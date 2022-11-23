-----------------------------------
-- func: capskill
-- desc: Caps a specific skill.
-----------------------------------

require("scripts/globals/status")

cmdprops =
{
    permission = 1,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!capskill <skillID>")
end

function onTrigger(player, skillId)
    -- validate skillId
    if skillId == nil then
        error(player, "You must provide a skillID.")
        return
    end

    skillId = tonumber(skillId) or xi.skill[string.upper(skillId)]
    if skillId == nil or skillId == 0 then
        error(player, "Invalid skillID.")
        return
    end

    -- cap skill
    player:capSkill(skillId)
    player:PrintToPlayer(string.format("Capped skillID %i.", skillId))
end
